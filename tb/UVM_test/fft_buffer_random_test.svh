`ifndef FFT_BUFFER_RANDOM_TEST_SVH
`define FFT_BUFFER_RANDOM_TEST_SVH

class adc_random_batch_sequence extends uvm_sequence #(adc_item);
    `uvm_object_utils(adc_random_batch_sequence)

    function new(string name = "adc_random_batch_sequence");
        super.new(name);
    endfunction

    virtual task body();
        adc_item req;

        // Two frames per batch. The test drains both before the next batch.
        repeat (256) begin
            req = adc_item::type_id::create("req");
            start_item(req);

            // Randomize the 12-bit sample and the existing 0..5 cycle gap.
            if (!req.randomize()) begin
                `uvm_fatal("ADC_RAND_FAIL", "ADC item randomization failed")
            end

            finish_item(req);
        end
    endtask
endclass

class core_random_ready_sequence extends uvm_sequence #(core_ready_item);
    `uvm_object_utils(core_random_ready_sequence)

    bit stop_requested = 0;

    function new(string name = "core_random_ready_sequence");
        super.new(name);
    endfunction

    virtual task body();
        core_ready_item req;

        while (!stop_requested) begin
            req = core_ready_item::type_id::create("req");
            start_item(req);

            // Randomize both ready bits and the existing 1..20 cycle hold.
            if (!req.randomize()) begin
                `uvm_fatal("CORE_RAND_FAIL", "Core item randomization failed")
            end

            // Complete the current request before checking the stop flag.
            finish_item(req);
        end
    endtask
endclass

class fft_buffer_random_test extends uvm_test;
    `uvm_component_utils(fft_buffer_random_test)

    fft_buffer_env env;

    function new(string name = "fft_buffer_random_test",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Four batches, two frames each, with no expected input drops.
        uvm_config_db#(int unsigned)::set(
            this, "env.scoreboard", "expected_frames", 8);
        uvm_config_db#(int unsigned)::set(
            this, "env.scoreboard", "expected_drops", 0);
        uvm_config_db#(bit)::set(
            this, "env.scoreboard", "allow_overflow", 1'b0);
        uvm_config_db#(int unsigned)::set(
            this, "env.scoreboard", "expected_idle_resets", 0);

        env = fft_buffer_env::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        adc_random_batch_sequence adc_seq;
        core_random_ready_sequence core_seq;

        phase.raise_objection(this);
        core_seq = core_random_ready_sequence::type_id::create("core_seq");

        `uvm_info("RANDOM_SCOPE",
            "8 frames: random ADC samples/gaps and Core ready/hold; no drops or mid-test reset",
            UVM_LOW)

        fork
            begin : run_traffic
                fork
                    begin
                        core_seq.start(env.core_agt.sequencer);
                    end

                    begin
                        for (int unsigned batch = 0; batch < 4; batch++) begin
                            adc_seq = adc_random_batch_sequence::type_id::create(
                                $sformatf("adc_batch_%0d", batch));
                            adc_seq.start(env.adc_agt.sequencer);

                            // Wait for observed output, not merely driver completion.
                            wait (env.scoreboard.pair_count >= (batch + 1) * 128);
                            #1ns;

                            `uvm_info("RANDOM_BATCH", $sformatf(
                                "batch=%0d completed; accepted=%0d pairs=%0d matches=%0d",
                                batch + 1, env.scoreboard.accepted_count,
                                env.scoreboard.pair_count,
                                env.scoreboard.match_count), UVM_LOW)
                        end

                        core_seq.stop_requested = 1;
                    end
                join

                // Allow idle drive and final monitor observations to settle.
                #20ns;
            end

            begin : watchdog
                // A test timeout is a failure, not a coverage exclusion.
                #1ms;
                `uvm_fatal("RANDOM_TIMEOUT", $sformatf(
                    "Timed out: accepted=%0d pairs=%0d",
                    env.scoreboard.accepted_count, env.scoreboard.pair_count))
            end
        join_any
        disable fork;

        phase.drop_objection(this);
    endtask
endclass

`endif
