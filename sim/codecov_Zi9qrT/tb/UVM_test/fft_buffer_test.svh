`ifndef FFT_BUFFER_BASE_TEST_SVH
`define FFT_BUFFER_BASE_TEST_SVH

class fft_buffer_base_test extends uvm_test;

    `uvm_component_utils(fft_buffer_base_test)

    fft_buffer_env env;

    function new(
        string name = "fft_buffer_base_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // reset 전 3프레임 + reset 후 1프레임
        uvm_config_db#(int unsigned)::set(
            this,
            "env.scoreboard",
            "expected_frames",
            5
        );

        // 기존 overflow 시험의 폐기 입력 4개
        uvm_config_db#(int unsigned)::set(
            this,
            "env.scoreboard",
            "expected_drops",
            4
        );

        uvm_config_db#(bit)::set(
            this,
            "env.scoreboard",
            "allow_overflow",
            1'b1
        );

        // 초기 reset을 제외한 추가 reset 1회
        uvm_config_db#(int unsigned)::set(
            this,
            "env.scoreboard",
            "expected_idle_resets",
            1
        );

        env = fft_buffer_env::type_id::create(
            "env", this
        );
    endfunction

    virtual task run_phase(uvm_phase phase);
        adc_sequence adc_seq;
        adc_sequence adc_after_reset;

        core_ready_sequence core_seq;
        core_ready_sequence core_after_reset;

        uvm_event reset_request;
        uvm_event reset_done;

        phase.raise_objection(this);

        reset_request =
            uvm_event_pool::get_global(
                "fft_buffer_reset_request"
            );

        reset_done =
            uvm_event_pool::get_global(
                "fft_buffer_reset_done"
            );

        //==================================================
        // 1. 기존 overflow 및 복구 시험
        //==================================================
        `uvm_info(
            "TEST_REV",
             "Overflow recovery, reuse of both buffers, idle reset, and one post-reset frame",
            UVM_LOW
        )

        adc_seq = adc_sequence::type_id::create(
            "adc_seq"
        );

        core_seq = core_ready_sequence::type_id::create(
            "core_seq"
        );

        fork
            begin
                adc_seq.start(env.adc_agt.sequencer);
            end

            begin
                core_seq.start(env.core_agt.sequencer);
            end
        join

        // driver의 idle 구동 이후 추가 관측
        #20ns;

        //==================================================
        // 2. tb_top에 reset 요청
        //
        // 출력 완료 여부는 scoreboard가 reset 진입 시
        // 큐·프레임·버퍼 상태로 검사합니다.
        //==================================================
        `uvm_info(
            "RESET_REQUEST",
            "Requesting reset after the first traffic sequence",
            UVM_LOW
        )

        reset_request.trigger();

        // tb_top이 reset을 해제할 때까지 대기
        reset_done.wait_trigger();

        `uvm_info(
            "RESET_DONE",
            "Reset released; starting a new frame",
            UVM_LOW
        )

        //==================================================
        // 3. Reset 이후 새 프레임
        //==================================================
        adc_after_reset =
            adc_sequence::type_id::create(
                "adc_after_reset"
            );

        core_after_reset =
            core_ready_sequence::type_id::create(
                "core_after_reset"
            );

        adc_after_reset.post_reset_mode = 1;
        core_after_reset.post_reset_mode = 1;

        fork
            begin
                adc_after_reset.start(
                    env.adc_agt.sequencer
                );
            end

            begin
                core_after_reset.start(
                    env.core_agt.sequencer
                );
            end
        join

        `uvm_info(
            "WAIT_BEGIN",
            "Post-reset sequences finished; starting 20ns observation",
            UVM_LOW
        )

        #20ns;

        `uvm_info(
            "WAIT_END",
            "Observation finished",
            UVM_LOW
        )

        phase.drop_objection(this);
    endtask

endclass

`endif