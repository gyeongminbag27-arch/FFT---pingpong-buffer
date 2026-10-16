`ifndef CORE_MONITOR_SVH
`define CORE_MONITOR_SVH

class core_monitor extends uvm_monitor;

    `uvm_component_utils(core_monitor)

    virtual fft_buffer_if.CORE_MONITOR vif;

    uvm_analysis_port #(core_ready_item) ap;

    //==================================================
    // 1. 출력 데이터 유지 검사: 클래스 공용 변수
    //==================================================
    bit hold_pending = 0;

    logic [39:0] held_data0;
    logic [39:0] held_data1;

    int unsigned hold_check_count = 0;
    int unsigned hold_error_count = 0;

    //==================================================
    // 2. 프레임 수락 대기 검사: 클래스 공용 변수
    //
    // check_frame_wait / run_phase / report_phase가 공유
    //==================================================
    bit frame_wait_pending = 0;

    int unsigned frame_wait_cycles = 0;
    int unsigned frame_hold_checks = 0;
    int unsigned frame_wait_errors = 0;

    //==================================================
    // 3. 생성자
    //==================================================
    function new(
        string name = "core_monitor",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    //==================================================
    // 4. Analysis port 생성 및 interface 참조 획득
    //==================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap = new("ap", this);

        if (!uvm_config_db#(
            virtual fft_buffer_if.CORE_MONITOR
        )::get(this, "", "core_mon_vif", vif)) begin
            `uvm_fatal(
                "NO_CORE_MON_VIF",
                "core_mon_vif was not found"
            )
        end
    endfunction

    //==================================================
    // 5. 출력 대기 중 valid·data 유지 검사
    //==================================================
    function void check_output_hold();

        // 이전 에지에서 valid=1, ready=0이었다면
        // 현재 에지까지 valid와 데이터가 유지되어야 함
        if (hold_pending) begin
            hold_check_count++;

            if (vif.core_mon_cb.o_buf_data_valid !== 1'b1 ||
                vif.core_mon_cb.o_buf_data0 !== held_data0 ||
                vif.core_mon_cb.o_buf_data1 !== held_data1) begin

                hold_error_count++;

                `uvm_error(
                    "CORE_HOLD_FAIL",
                    $sformatf(
                        "time=%0t expected valid=1 data=(%010h,%010h), actual valid=%b data=(%010h,%010h)",
                        $time,
                        held_data0,
                        held_data1,
                        vif.core_mon_cb.o_buf_data_valid,
                        vif.core_mon_cb.o_buf_data0,
                        vif.core_mon_cb.o_buf_data1
                    )
                )
            end
        end

        // 현재 관측으로 다음 에지의 검사 준비
        hold_pending =
            (vif.core_mon_cb.o_buf_data_valid === 1'b1) &&
            (vif.core_mon_cb.i_buf_data_ready === 1'b0);

        if (hold_pending) begin
            held_data0 = vif.core_mon_cb.o_buf_data0;
            held_data1 = vif.core_mon_cb.o_buf_data1;
        end
    endfunction

    //==================================================
    // 6. 프레임 수락 대기 검사
    //==================================================
    function void check_frame_wait();
        bit waiting_now;

        waiting_now =
            (vif.core_mon_cb.o_frame_valid === 1'b1) &&
            (vif.core_mon_cb.i_frame_ready === 1'b0);

        // 이전 에지에서 기다리던 프레임은
        // 현재 수락 에지까지 valid를 유지해야 함
        if (frame_wait_pending) begin
            frame_hold_checks++;

            if (vif.core_mon_cb.o_frame_valid !== 1'b1) begin
                frame_wait_errors++;

                `uvm_error(
                    "FRAME_VALID_HOLD_FAIL",
                    $sformatf(
                        "time=%0t frame_valid dropped or became unknown before acceptance",
                        $time
                    )
                )
            end
        end

        // 실제 프레임 대기 에지 수
        if (waiting_now) begin
            frame_wait_cycles++;
        end

        // 원본 RTL은 프레임 수락 후 ST_READ를 거침.
        // 대기 중과 수락 에지에는 data_valid가 0이어야 함.
        if (waiting_now || frame_wait_pending) begin
            if (vif.core_mon_cb.o_buf_data_valid !== 1'b0) begin
                frame_wait_errors++;

                `uvm_error(
                    "FRAME_EARLY_DATA",
                    $sformatf(
                        "time=%0t data_valid asserted before the permitted output stage",
                        $time
                    )
                )
            end
        end

        // 다음 에지에서 사용할 이전 상태
        frame_wait_pending = waiting_now;
    endfunction

    //==================================================
    // 7. 신호 관측·검사 및 scoreboard 전달
    //==================================================
    virtual task run_phase(uvm_phase phase);
        core_ready_item observed;

        bit have_previous;
        bit previous_frame_ready;
        bit previous_data_ready;
        logic previous_overflow;

        have_previous = 0;

        forever begin
            @(vif.core_mon_cb);

            // 매 관측마다 새 객체 생성
            observed = core_ready_item::type_id::create(
                "observed"
            );

            observed.rst         = vif.core_mon_cb.rst;
            observed.sample_time = $time;

             // 같은 clocking event에서 샘플링한 ADC 입력
            observed.adc_valid = vif.core_mon_cb.i_adc_data_valid;
            observed.adc_data  = vif.core_mon_cb.i_adc_data;

            // 관측 객체에서는 요청용 유지 기간을 사용하지 않음
            observed.hold_cycles = 0;

            observed.rst         = vif.core_mon_cb.rst;
            observed.sample_time = $time;
            observed.hold_cycles = 0;
            
            observed.adc_valid = vif.core_mon_cb.i_adc_data_valid;
            observed.adc_data  = vif.core_mon_cb.i_adc_data;
            
            // reset 중에도 scoreboard가 overflow 해제를 확인하도록 전달
            observed.overflow = vif.core_mon_cb.o_overflow;


            // Reset 동안 이전 대기 상태 해제
            // 검사 횟수는 시험 전체 누적값으로 유지
            if (observed.rst !== 1'b0) begin
                have_previous      = 0;
                hold_pending       = 0;
                frame_wait_pending = 0;

                ap.write(observed);
                continue;
            end

            // 이전 에지와 현재 에지의 관계 검사
            check_output_hold();
            check_frame_wait();

            // ready를 bit 필드에 저장하기 전에 X/Z 검사
            if ($isunknown({
                vif.core_mon_cb.i_frame_ready,
                vif.core_mon_cb.i_buf_data_ready,
                vif.core_mon_cb.o_frame_valid,
                vif.core_mon_cb.o_buf_data_valid,
                vif.core_mon_cb.o_overflow
            })) begin
                `uvm_error(
                    "CORE_CTRL_X",
                    "Core control signals contain X/Z outside reset"
                )
                continue;
            end

            // 실제 interface 관측값 복사
            observed.frame_ready =
                vif.core_mon_cb.i_frame_ready;

            observed.data_ready =
                vif.core_mon_cb.i_buf_data_ready;

            observed.frame_valid =
                vif.core_mon_cb.o_frame_valid;

            observed.data_valid =
                vif.core_mon_cb.o_buf_data_valid;

            observed.data0 =
                vif.core_mon_cb.o_buf_data0;

            observed.data1 =
                vif.core_mon_cb.o_buf_data1;

            observed.overflow =
                vif.core_mon_cb.o_overflow;

            // 첫 관측 또는 ready 변화 시 출력
            if (!have_previous ||
                observed.frame_ready != previous_frame_ready ||
                observed.data_ready != previous_data_ready) begin

                `uvm_info(
                    "CORE_READY",
                    $sformatf(
                        "frame_ready=%b data_ready=%b",
                        observed.frame_ready,
                        observed.data_ready
                    ),
                    UVM_MEDIUM
                )
            end

            // 첫 관측 또는 overflow 변화 시 출력
            if (!have_previous ||
                observed.overflow !== previous_overflow) begin

                `uvm_info(
                    "CORE_OVERFLOW",
                    $sformatf(
                        "overflow=%b",
                        observed.overflow
                    ),
                    UVM_MEDIUM
                )
            end

            previous_frame_ready = observed.frame_ready;
            previous_data_ready  = observed.data_ready;
            previous_overflow    = observed.overflow;
            have_previous        = 1;

            // 프레임 handshake 관측
            if (observed.frame_valid &&
                observed.frame_ready) begin

                `uvm_info(
                    "CORE_FRAME",
                    "Frame handshake observed",
                    UVM_MEDIUM
                )
            end

            // 데이터 valid가 있을 때만 출력 데이터 검사
            if (observed.data_valid) begin

                if ($isunknown({
                    observed.data0,
                    observed.data1
                })) begin
                    `uvm_error(
                        "CORE_DATA_X",
                        "Output data contains X/Z while valid=1"
                    )
                end

                // 실제 데이터 전달 handshake 관측
                if (observed.data_ready) begin
                    `uvm_info(
                        "CORE_PAIR",
                        $sformatf(
                            "data0=0x%010h data1=0x%010h",
                            observed.data0,
                            observed.data1
                        ),
                        UVM_MEDIUM
                    )
                end
            end

            // 관측 객체를 scoreboard에 전달
            ap.write(observed);
        end
    endtask

    //==================================================
    // 8. 검사 결과 요약
    //==================================================
    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "CORE_HOLD_SUMMARY",
            $sformatf(
                "checks=%0d errors=%0d",
                hold_check_count,
                hold_error_count
            ),
            UVM_NONE
        )

        `uvm_info(
            "FRAME_WAIT_SUMMARY",
            $sformatf(
                "wait_cycles=%0d hold_checks=%0d errors=%0d",
                frame_wait_cycles,
                frame_hold_checks,
                frame_wait_errors
            ),
            UVM_NONE
        )
    endfunction

endclass

`endif