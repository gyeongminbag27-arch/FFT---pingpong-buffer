`ifndef FFT_BUFFER_MISSING_BINS_TEST_SVH
`define FFT_BUFFER_MISSING_BINS_TEST_SVH

class adc_missing_bins_sequence extends adc_sequence;
    `uvm_object_utils(adc_missing_bins_sequence)
    function new(string name = "adc_missing_bins_sequence");
        super.new(name);
    endfunction

    virtual task body();
        bit [11:0] bases[6] = '{12'h124, 12'h3c4, 12'h584,
                               12'h818, 12'hb5c, 12'hd94};
        // 미달한 구간 6개에 포함된 값 24개를 모두 입력합니다.
        foreach (bases[b]) begin
            for (int offset = 0; offset < 4; offset++)
                send_sample(bases[b] + offset, 0);
        end
        // 나머지 104개로 128샘플 프레임을 완성합니다.
        for (int i = 0; i < 104; i++)
            send_sample(12'h200 + i, 0);
    endtask
endclass

class fft_buffer_missing_bins_test extends fft_buffer_base_test;
    `uvm_component_utils(fft_buffer_missing_bins_test)
    function new(string name = "fft_buffer_missing_bins_test",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // 부모 시험의 overflow/reset 설정을 단일 정상 프레임으로 변경합니다.
        uvm_config_db#(int unsigned)::set(this, "env.scoreboard", "expected_frames", 1);
        uvm_config_db#(int unsigned)::set(this, "env.scoreboard", "expected_drops", 0);
        uvm_config_db#(bit)::set(this, "env.scoreboard", "allow_overflow", 0);
        uvm_config_db#(int unsigned)::set(this, "env.scoreboard", "expected_idle_resets", 0);
    endfunction

    virtual task run_phase(uvm_phase phase);
        adc_missing_bins_sequence adc_seq;
        core_ready_sequence core_seq;
        phase.raise_objection(this);
        adc_seq = adc_missing_bins_sequence::type_id::create("adc_seq");
        core_seq = core_ready_sequence::type_id::create("core_seq");
        core_seq.post_reset_mode = 1;
        fork
            begin
                fork
                    adc_seq.start(env.adc_agt.sequencer);
                    core_seq.start(env.core_agt.sequencer);
                join
                // Scoreboard 종료 검사에 더해 64쌍의 비교 완료를 기다립니다.
                wait (env.scoreboard.match_count == 64);
                #20ns;
            end
            begin
                #100us;
                `uvm_fatal("MISSING_BINS_TIMEOUT", "128-sample frame did not complete")
            end
        join_any
        disable fork;
        `uvm_info("MISSING_BINS", "Completed: 128 samples, 64 matched output pairs; check merged coverage separately", UVM_LOW)
        phase.drop_objection(this);
    endtask
endclass
`endif
