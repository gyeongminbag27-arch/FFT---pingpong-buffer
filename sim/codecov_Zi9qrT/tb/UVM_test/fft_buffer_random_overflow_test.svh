`ifndef FFT_BUFFER_RANDOM_OVERFLOW_TEST_SVH
`define FFT_BUFFER_RANDOM_OVERFLOW_TEST_SVH

class adc_overflow_random_sequence extends uvm_sequence #(adc_item);
    `uvm_object_utils(adc_overflow_random_sequence)

    int unsigned sample_count = 128;

    function new(string name = "adc_overflow_random_sequence");
        super.new(name);
    endfunction

    virtual task body();
        adc_item req;

        repeat (sample_count) begin
            req = adc_item::type_id::create("req");
            start_item(req);

            // Use the existing 12-bit sample and 0..5 cycle gap constraints.
            if (!req.randomize()) begin
                `uvm_fatal("ADC_RAND_FAIL", "ADC item randomization failed")
            end

            finish_item(req);
        end
    endtask
endclass

class core_overflow_random_sequence extends uvm_sequence #(core_ready_item);
    `uvm_object_utils(core_overflow_random_sequence)

    bit enable_output = 0;
    bit stop_requested = 0;

    function new(string name = "core_overflow_random_sequence");
        super.new(name);
    endfunction

    virtual task body();
        core_ready_item req;

        while (!stop_requested) begin
            req = core_ready_item::type_id::create("req");
            start_item(req);

            if (!enable_output) begin
                // Block frame acceptance until the planned drops complete.
                // Hold duration still uses the existing 1..20 cycle constraint.
                if (!req.randomize() with {
                    frame_ready == 0;
                    data_ready == 1;
                }) begin
                    `uvm_fatal("CORE_RAND_FAIL", "Blocked-ready randomization failed")
                end
            end
            else begin
                // Randomize both ready bits and hold duration during draining.
                if (!req.randomize()) begin
                    `uvm_fatal("CORE_RAND_FAIL", "Core item randomization failed")
                end
            end

            // Mode changes take effect after the current request completes.
            finish_item(req);
        end
    endtask
endclass

class fft_buffer_random_overflow_test extends uvm_test;
    `uvm_component_utils(fft_buffer_random_overflow_test)

    fft_buffer_env env;

    function new(string name = "fft_buffer_random_overflow_test",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Two initial frames and one refill of each buffer.
        uvm_config_db#(int unsigned)::set(
            this, "env.scoreboard", "expected_frames", 4);
        uvm_config_db#(int unsigned)::set(
            this, "env.scoreboard", "expected_drops", 4);
        uvm_config_db#(bit)::set(
            this, "env.scoreboard", "allow_overflow", 1'b1);
        uvm_config_db#(int unsigned)::set(
            this, "env.scoreboard", "expected_idle_resets", 0);

        env = fft_buffer_env::type_id::create("env", this);
    endfunction

    task send_random_samples(string seq_name, int unsigned count);
        adc_overflow_random_sequence seq;
        seq = adc_overflow_random_sequence::type_id::create(seq_name);
        seq.sample_count = count;
        seq.start(env.adc_agt.sequencer);

        // Let both monitor callbacks finish after the last driver item.
        #1ns;
    endtask

    virtual task run_phase(uvm_phase phase);
        core_overflow_random_sequence core_seq;

        phase.raise_objection(this);
        core_seq = core_overflow_random_sequence::type_id::create("core_seq");

        `uvm_info("RANDOM_SCOPE",
            "Random data/gaps and drain ready/hold; controlled fill, 4 drops, refill of both buffers; no mid-test reset",
            UVM_LOW)

        fork
            begin : run_traffic
                fork
                    begin
                        core_seq.start(env.core_agt.sequencer);
                    end

                    begin
                        `uvm_info("RAND_OVF_STAGE", "Fill both buffers with output blocked", UVM_LOW)
                        send_random_samples("fill_both", 256);

                        // Wait on observed model state; never write model state.
                        wait (env.scoreboard.full0 && env.scoreboard.full1);
                        #1ns;

                        `uvm_info("RAND_OVF_STAGE", "Send exactly 4 inputs while full", UVM_LOW)
                        send_random_samples("full_drops", 4);

                        // No more ADC inputs until buffer 0 has been released.
                        core_seq.enable_output = 1;
                        wait (env.scoreboard.pair_count >= 64 &&
                              !env.scoreboard.full0);
                        #1ns;

                        `uvm_info("RAND_OVF_STAGE", "Buffer 0 released; send its random refill", UVM_LOW)
                        send_random_samples("refill_0", 128);

                        // Buffer 1 may already have drained during refill_0.
                        // Wait if necessary to avoid unplanned extra drops.
                        wait (env.scoreboard.pair_count >= 128 &&
                              !env.scoreboard.full1);
                        #1ns;

                        `uvm_info("RAND_OVF_STAGE", "Buffer 1 released; send its random refill", UVM_LOW)
                        send_random_samples("refill_1", 128);

                        wait (env.scoreboard.pair_count >= 256);
                        #1ns;
                        `uvm_info("RAND_OVF_STAGE", "All four frames have drained", UVM_LOW)
                        core_seq.stop_requested = 1;
                    end
                join

                // Complete the final ready item before ending the test.
                #20ns;
            end

            begin : watchdog
                #1ms;
                `uvm_fatal("RANDOM_TIMEOUT", $sformatf(
                    "Timed out: accepted=%0d dropped=%0d pairs=%0d full0=%0b full1=%0b",
                    env.scoreboard.accepted_count,
                    env.scoreboard.dropped_count,
                    env.scoreboard.pair_count,
                    env.scoreboard.full0,
                    env.scoreboard.full1))
            end
        join_any
        disable fork;

        phase.drop_objection(this);
    endtask
endclass

`endif
