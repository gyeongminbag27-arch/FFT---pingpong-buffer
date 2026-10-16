`ifndef FFT_BUFFER_SCOREBOARD_SVH
`define FFT_BUFFER_SCOREBOARD_SVH

`uvm_analysis_imp_decl(_adc)
`uvm_analysis_imp_decl(_core)

class fft_buffer_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fft_buffer_scoreboard)

    uvm_analysis_imp_adc #(
        adc_item, fft_buffer_scoreboard
    ) adc_imp;

    uvm_analysis_imp_core #(
        core_ready_item, fft_buffer_scoreboard
    ) core_imp;

    // Publish model-derived events to coverage.
    uvm_analysis_port #(fft_buffer_cov_item) cov_ap;

    localparam int unsigned SAMPLES_PER_FRAME = 128;
    localparam int unsigned PAIRS_PER_FRAME   = 64;

    // 시험 설정
    int unsigned expected_frames = 1;
    int unsigned expected_drops  = 0;
    bit allow_overflow = 0;

    int unsigned expected_adc_count;
    int unsigned expected_pair_count;

    // 모델이 수락한 입력만 저장하는 예상 출력 큐
    bit [11:0] expected_samples[$];

    // 두 monitor가 같은 입력을 관측하는지 종료 시 비교
    // 콜백 호출 순서에 의존하지 않도록 별도로 보관
    bit [11:0] adc_monitor_samples[$];
    bit [11:0] core_snapshot_samples[$];

    // 외부 관측으로 추적하는 버퍼 상태
    bit full0 = 0;
    bit full1 = 0;
    bit write_select = 0;
    bit read_select  = 0;

    int unsigned write_sample_count = 0;

    bit frame_active = 0;
    int unsigned frame_pair_count = 0;

    // 다음 관측에서 기대하는 overflow 상태
    bit expected_overflow = 0;

    // 집계
    int unsigned adc_count = 0;
    int unsigned snapshot_adc_count = 0;
    int unsigned accepted_count = 0;
    int unsigned dropped_count = 0;
    int unsigned accepted_after_overflow = 0;

    int unsigned frame_count = 0;
    int unsigned pair_count = 0;
    int unsigned match_count = 0;

    // 초기 reset 이후 요청하는 reset 횟수
    int unsigned expected_idle_resets = 0;
    int unsigned idle_reset_count = 0;

    // 초기 reset은 시험 중 reset 횟수에서 제외
    bit reset_in_progress = 1;

    function new(
        string name = "fft_buffer_scoreboard",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        adc_imp  = new("adc_imp", this);
        core_imp = new("core_imp", this);
        // Create the coverage analysis port.
        cov_ap = new("cov_ap", this);

        void'(uvm_config_db#(int unsigned)::get(
            this, "", "expected_frames", expected_frames
        ));

        void'(uvm_config_db#(int unsigned)::get(
            this, "", "expected_idle_resets", expected_idle_resets
        ));

        void'(uvm_config_db#(int unsigned)::get(
            this, "", "expected_drops", expected_drops
        ));

        void'(uvm_config_db#(bit)::get(
            this, "", "allow_overflow", allow_overflow
        ));

        if (expected_frames == 0) begin
            `uvm_fatal(
                "SB_CONFIG",
                "expected_frames must be greater than zero"
            )
        end

        if (!allow_overflow && expected_drops != 0) begin
            `uvm_fatal(
                "SB_CONFIG",
                "expected_drops requires allow_overflow=1"
            )
        end

        expected_adc_count =
            expected_frames * SAMPLES_PER_FRAME;

        expected_pair_count =
            expected_frames * PAIRS_PER_FRAME;

        `uvm_info(
            "SB_CONFIG",
            $sformatf(
                {"expected_frames=%0d expected_accepted=%0d ",
                 "expected_pairs=%0d expected_drops=%0d ",
                 "allow_overflow=%0b"},
                expected_frames,
                expected_adc_count,
                expected_pair_count,
                expected_drops,
                allow_overflow
            ),
            UVM_LOW
        )
    endfunction

    //==================================================
    // ADC monitor 경로
    //
    // 여기서는 관측된 입력을 기록합니다.
    // 수락·폐기 판단은 write_core에서 한 번만 합니다.
    //==================================================
    function void write_adc(adc_item observed);
        adc_count++;
        adc_monitor_samples.push_back(observed.sample);
    endfunction

    //==================================================
    // 같은 clocking event에서 관측한 ADC와 Core 신호로
    // 입력 수락·폐기 및 출력 전달을 함께 처리합니다.
    //==================================================
    function void write_core(core_ready_item observed);
        fft_buffer_cov_item cov_event;
        bit write_full_before;
        bit read_full_before;
        bit frame_handshake;
        bit pair_handshake;

        bit [11:0] sample0;
        bit [11:0] sample1;

        logic [39:0] expected_data0;
        logic [39:0] expected_data1;

        //==================================================
        // Reset 처리
        //
        // 이번 단계에서는 입력·출력이 모두 완료된 뒤의
        // reset만 지원합니다.
        //==================================================
        if (observed.rst === 1'b1) begin

            // 초기 reset 이후 새로 진입한 reset
            if (!reset_in_progress) begin

                if (frame_active ||
                    expected_samples.size() != 0 ||
                    write_sample_count != 0 ||
                    full0 || full1) begin

                    `uvm_fatal(
                        "SB_RESET_BUSY",
                        "Reset occurred before all buffered traffic completed"
                    )
                end

                idle_reset_count++;

                if (idle_reset_count > expected_idle_resets) begin
                    `uvm_fatal(
                        "SB_UNEXPECTED_RESET",
                        "More idle resets than configured"
                    )
                end

                `uvm_info(
                    "SB_IDLE_RESET",
                    $sformatf(
                        "time=%0t idle reset observed; count=%0d",
                        observed.sample_time,
                        idle_reset_count
                    ),
                    UVM_LOW
                )
            end

            reset_in_progress = 1;

            // 버퍼 관리 상태는 reset 시 처음 상태로 복귀
            full0 = 0;
            full1 = 0;

            write_select = 0;
            read_select  = 0;

            write_sample_count = 0;
            frame_active = 0;
            frame_pair_count = 0;

            expected_overflow = 0;

            // 실제 DUT의 overflow 해제 여부 확인
            if (observed.overflow !== 1'b0) begin
                `uvm_error(
                    "SB_RESET_OVERFLOW",
                    $sformatf(
                        "time=%0t overflow must be 0 during reset; actual=%b",
                        observed.sample_time,
                        observed.overflow
                    )
                )
            end

            // Reset temporal coverage history without clearing bin hits.
            cov_event =
                fft_buffer_cov_item::type_id::create("cov_event");

            cov_event.rst         = 1;
            cov_event.sample_time = observed.sample_time;

            cov_ap.write(cov_event);

            // 누적 입력·출력·비교 횟수는 지우지 않습니다.
            return;
        end

        if (observed.rst !== 1'b0) begin
            `uvm_error("SB_RESET_X", "Reset contains X/Z")
            return;
        end

        reset_in_progress = 0;

        if ($isunknown({
            observed.adc_valid,
            observed.frame_valid,
            observed.frame_ready,
            observed.data_valid,
            observed.data_ready,
            observed.overflow
        })) begin
            `uvm_error(
                "SB_CTRL_X",
                "Observed control signals contain X/Z"
            )
            return;
        end

        if (observed.adc_valid === 1'b1 &&
            $isunknown(observed.adc_data)) begin
            `uvm_error(
                "SB_ADC_X",
                "ADC data contains X/Z while valid=1"
            )
            return;
        end

        // input #1step으로 관측한 overflow는
        // 현재 에지에서 갱신되기 전의 값입니다.
        // 따라서 이전 관측에서 계산한 예상값과 비교합니다.
        if (observed.overflow !== expected_overflow) begin
            `uvm_error(
                "SB_OVERFLOW_MISMATCH",
                $sformatf(
                    "time=%0t expected=%0b actual=%0b",
                    observed.sample_time,
                    expected_overflow,
                    observed.overflow
                )
            )
        end

        // 현재 에지 직전 상태를 보관합니다.
        // 아래에서 full을 변경해도 입력 판단은 이 값을 사용합니다.
        write_full_before = write_select ? full1 : full0;
        read_full_before  = read_select  ? full1 : full0;

        frame_handshake =
            observed.frame_valid && observed.frame_ready;

        pair_handshake =
            observed.data_valid && observed.data_ready;

        // Create a fresh event object for this observed edge.
        cov_event =
            fft_buffer_cov_item::type_id::create("cov_event");

        // Save selectors before the model updates them.
        cov_event.write_buffer      = write_select;
        cov_event.read_buffer       = read_select;

        cov_event.pair_transfer     = pair_handshake;
        cov_event.observed_overflow = observed.overflow;
        cov_event.sample_time       = observed.sample_time;

        // 이 RTL은 프레임 수락 후 READ 상태를 거칩니다.
        if (frame_handshake && pair_handshake) begin
            `uvm_fatal(
                "SB_PROTOCOL",
                "Frame and data handshakes occurred on the same edge"
            )
        end

        //==================================================
        // 1. 프레임 수락
        //==================================================
        if (frame_handshake) begin
            if (frame_active || !read_full_before) begin
                `uvm_fatal(
                    "SB_FRAME_STATE",
                    $sformatf(
                        "Unexpected frame handshake: active=%0b full=%0b",
                        frame_active,
                        read_full_before
                    )
                )
            end

            if (expected_samples.size() < SAMPLES_PER_FRAME) begin
                `uvm_fatal(
                    "SB_FRAME_SHORT",
                    "Fewer than 128 accepted samples at frame handshake"
                )
            end

            frame_count++;
            frame_active = 1;
            frame_pair_count = 0;

            if (frame_count > expected_frames) begin
                `uvm_error(
                    "SB_EXTRA_FRAME",
                    "More frame handshakes than expected"
                )
            end
        end

        //==================================================
        // 2. ADC 입력 수락 또는 폐기
        //==================================================
        if (observed.adc_valid) begin
            snapshot_adc_count++;
            core_snapshot_samples.push_back(observed.adc_data);

            if (write_full_before) begin
                dropped_count++;

                // The ADC input was dropped at this edge.
                cov_event.dropped = 1;

                // 현재 에지에서 발생한 overflow는
                // 다음 clocking event에서 관측됩니다.
                expected_overflow = 1;

                `uvm_info(
                    "SB_DROP",
                    $sformatf(
                        "time=%0t sample=%0d write_buffer=%0d",
                        observed.sample_time,
                        observed.adc_data,
                        write_select
                    ),
                    UVM_MEDIUM
                )

                if (!allow_overflow) begin
                    `uvm_fatal(
                        "SB_UNEXPECTED_DROP",
                        "Input arrived at a full buffer in a no-overflow test"
                    )
                end
            end
            else begin
                accepted_count++;

                // The ADC input was accepted at this edge.
                cov_event.accepted = 1;

                if (expected_overflow)
                    accepted_after_overflow++;

                expected_samples.push_back(observed.adc_data);

                if (accepted_count > expected_adc_count) begin
                    `uvm_error(
                        "SB_EXTRA_ADC",
                        "More accepted ADC samples than expected"
                    )
                end

                if (write_sample_count == SAMPLES_PER_FRAME - 1) begin
                    cov_event.write_frame_done = 1;
                    write_sample_count = 0;

                    if (write_select == 0)
                        full0 = 1;
                    else
                        full1 = 1;

                    write_select = ~write_select;
                end
                else begin
                    write_sample_count++;
                end
            end
        end

        //==================================================
        // 3.  데이터 비교
        //==================================================
        if (!pair_handshake) begin
            // Publish input events even when no output pair transfers.
            cov_ap.write(cov_event);
            return;
        end

        if (!frame_active || !read_full_before) begin
            `uvm_fatal(
                "SB_PAIR_STATE",
                "Data handshake occurred without an active full frame"
            )
        end

        if (expected_samples.size() < 2) begin
            `uvm_fatal(
                "SB_QUEUE_EMPTY",
                "Insufficient accepted samples for output comparison"
            )
        end

        sample0 = expected_samples.pop_front();
        sample1 = expected_samples.pop_front();

        // ADC 12비트 -> 실수부 20비트 unsigned 확장
        // 허수부 20비트는 0
        expected_data0 = {8'b0, sample0, 20'b0};
        expected_data1 = {8'b0, sample1, 20'b0};

        pair_count++;
        frame_pair_count++;

        if (observed.data0 !== expected_data0 ||
            observed.data1 !== expected_data1) begin
            `uvm_error(
                "SB_MISMATCH",
                $sformatf(
                    {"frame=%0d pair=%0d ",
                     "expected=(%010h,%010h) actual=(%010h,%010h)"},
                    frame_count,
                    frame_pair_count - 1,
                    expected_data0,
                    expected_data1,
                    observed.data0,
                    observed.data1
                )
            )
        end
        else begin
            match_count++;
        end

        // 마지막 쌍이 실제 전달된 에지에서 버퍼를 비웁니다.
        // 위 ADC 판단에는 이미 저장한 write_full_before를 사용합니다.
        if (frame_pair_count == PAIRS_PER_FRAME) begin
            // This output transfer releases the selected buffer.
            cov_event.read_frame_done = 1;
            frame_active = 0;

            if (read_select == 0)
                full0 = 0;
            else
                full1 = 0;

            read_select = ~read_select;

            `uvm_info(
                "SB_FRAME_DONE",
                $sformatf(
                    "frame=%0d completed 64 pairs; total_pairs=%0d",
                    frame_count,
                    pair_count
                ),
                UVM_LOW
            )
        end

        // Publish after processing the output transfer.
        cov_ap.write(cov_event);
    endfunction

    //==================================================
    // 종료 시 누락·미완료 및 관측 경로 일치 검사
    //==================================================
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);

        if (adc_count != snapshot_adc_count) begin
            `uvm_error(
                "SB_MONITOR_COUNT",
                $sformatf(
                    "ADC monitor=%0d Core snapshot=%0d",
                    adc_count,
                    snapshot_adc_count
                )
            )
        end

        if (adc_monitor_samples.size() ==
            core_snapshot_samples.size()) begin

            foreach (adc_monitor_samples[i]) begin
                if (adc_monitor_samples[i] !==
                    core_snapshot_samples[i]) begin
                    `uvm_error(
                        "SB_MONITOR_DATA",
                        $sformatf(
                            "index=%0d ADC monitor=%0d Core snapshot=%0d",
                            i,
                            adc_monitor_samples[i],
                            core_snapshot_samples[i]
                        )
                    )
                end
            end
        end

        if (snapshot_adc_count !=
            expected_adc_count + expected_drops ||
            accepted_count != expected_adc_count ||
            dropped_count != expected_drops ||
            frame_count != expected_frames ||
            pair_count != expected_pair_count ||
            match_count != expected_pair_count) begin

            `uvm_error(
                "SB_FINAL_CHECK",
                $sformatf(
                    {"attempts=%0d accepted=%0d dropped=%0d ",
                     "frames=%0d pairs=%0d matches=%0d"},
                    snapshot_adc_count,
                    accepted_count,
                    dropped_count,
                    frame_count,
                    pair_count,
                    match_count
                )
            )
        end

        if (expected_samples.size() != 0 ||
            frame_active ||
            write_sample_count != 0 ||
            full0 || full1) begin

            `uvm_error(
                "SB_PENDING",
                $sformatf(
                    {"pending=%0d active=%0b partial_samples=%0d ",
                     "full0=%0b full1=%0b"},
                    expected_samples.size(),
                    frame_active,
                    write_sample_count,
                    full0,
                    full1
                )
            )
        end
        if (idle_reset_count != expected_idle_resets) begin
            `uvm_error(
                "SB_RESET_COUNT",
                $sformatf(
                    "expected idle resets=%0d actual=%0d",
                    expected_idle_resets,
                    idle_reset_count
                )
            )
        end

        if (reset_in_progress) begin
            `uvm_error(
                "SB_RESET_NOT_RELEASED",
                "Test ended before reset release was observed"
            )
        end
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "SB_SUMMARY",
            $sformatf(
                {"adc=%0d frames=%0d pairs=%0d matches=%0d pending=%0d ",
                 "accepted=%0d dropped=%0d accepted_after_overflow=%0d"},
                adc_count,
                frame_count,
                pair_count,
                match_count,
                expected_samples.size(),
                accepted_count,
                dropped_count,
                accepted_after_overflow
            ),
            UVM_NONE
        )

        `uvm_info(
            "SB_RESET_SUMMARY",
            $sformatf(
                "idle_resets=%0d expected=%0d",
                idle_reset_count,
                expected_idle_resets
            ),
            UVM_NONE
        )
    endfunction

endclass

`endif