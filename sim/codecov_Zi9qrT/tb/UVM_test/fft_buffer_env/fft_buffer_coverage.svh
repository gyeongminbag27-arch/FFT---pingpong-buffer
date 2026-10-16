`ifndef FFT_BUFFER_COVERAGE_SVH
`define FFT_BUFFER_COVERAGE_SVH

// Separate callback for raw Core monitor observations.
`uvm_analysis_imp_decl(_stimulus)

class fft_buffer_coverage extends uvm_subscriber #(fft_buffer_cov_item);
    `uvm_component_utils(fft_buffer_coverage)

    localparam int CONCURRENT = 0;
    localparam int FILL_0     = 1;
    localparam int FILL_1     = 2;
    localparam int REUSE_0    = 3;
    localparam int REUSE_1    = 4;
    localparam int FULL_DROP  = 5;
    localparam int RECOVERY   = 6;

    uvm_analysis_imp_stimulus #(core_ready_item, fft_buffer_coverage) stimulus_imp;

    bit [11:0] sampled_data;
    bit [1:0] sampled_ready;
    int unsigned sampled_gap;
    bit gap_known;
    bit have_previous_adc;
    int unsigned idle_cycles;
    int unsigned stimulus_observations;
    int unsigned input_samples;
    int unsigned data_hits[1024];
    int unsigned gap_hits[7];
    int unsigned ready_hits[4];
    int unsigned cross_hits[6][4];

    // These are independent samples from the raw monitor path.
    // Data bins describe ranges, not coverage of every individual value.
    covergroup stimulus_cg;
        option.per_instance = 1;

        cp_data: coverpoint sampled_data {
            bins value_range[1024] = {[0:4095]};
        }

        cp_gap: coverpoint sampled_gap iff (gap_known) {
            bins gap_cycles[] = {[0:5]};
            bins gap_6_or_more = {6};
        }

        // Sample ready at each valid ADC input, not on every idle clock.
        cp_ready: coverpoint sampled_ready {
            bins ready_00 = {2'b00};
            bins ready_01 = {2'b01};
            bins ready_10 = {2'b10};
            bins ready_11 = {2'b11};
        }

        // Target the existing random gap range (0..5) against all ready states.
        // Longer scenario/batch gaps remain visible in cp_gap, outside this cross.
        gap_x_ready: cross cp_gap, cp_ready iff (gap_known) {
            ignore_bins outside_random_gap_range = binsof(cp_gap.gap_6_or_more);
        }
    endgroup

    int event_code;
    int unsigned hits[7];
    int unsigned observation_count;
    bit freed_since_fill[2];
    bit drop_pending[2];
    bit freed_after_drop[2];

    // Each bin records a functional event; zero/false values are not targets.
    covergroup buffer_cg;
        option.per_instance = 1;
        cp_event: coverpoint event_code {
            bins accepted_and_output = {0};
            bins buffer_0_filled     = {1};
            bins buffer_1_filled     = {2};
            bins buffer_0_reused     = {3};
            bins buffer_1_reused     = {4};
            bins input_dropped_full = {5};
            bins collection_resumed = {6};
        }
    endgroup

    function new(string name = "fft_buffer_coverage",
                 uvm_component parent = null);
        super.new(name, parent);
        buffer_cg = new();
        stimulus_cg = new();
        stimulus_imp = new("stimulus_imp", this);
        have_previous_adc = 0;
        gap_known = 0;
        idle_cycles = 0;
        stimulus_observations = 0;
        input_samples = 0;
        foreach (data_hits[i]) data_hits[i] = 0;
        foreach (gap_hits[i]) gap_hits[i] = 0;
        foreach (ready_hits[i]) ready_hits[i] = 0;
        foreach (cross_hits[i,j]) cross_hits[i][j] = 0;
        foreach (hits[i]) hits[i] = 0;
        observation_count = 0;
        clear_history();
    endfunction

    // Reset breaks temporal relationships, but keeps accumulated coverage.
    function void clear_history();
        foreach (freed_since_fill[i]) begin
            freed_since_fill[i] = 0;
            drop_pending[i] = 0;
            freed_after_drop[i] = 0;
        end
    endfunction

    function void record_event(int code);
        event_code = code;
        hits[code]++;
        buffer_cg.sample();
    endfunction

    virtual function void write(fft_buffer_cov_item t);
        observation_count++;
        if (t.rst) begin
            clear_history();
            return;
        end

        // Both events must belong to the same observed clock edge.
        if (t.accepted && t.pair_transfer)
            record_event(CONCURRENT);

        if (t.dropped) begin
            record_event(FULL_DROP);
            drop_pending[t.write_buffer] = 1;
            freed_after_drop[t.write_buffer] = 0;
        end

        // Require drop -> release -> acceptance in the same buffer/reset epoch.
        // Overflow is sticky: recovery does not require it to return to zero.
        if (t.accepted && drop_pending[t.write_buffer] &&
            freed_after_drop[t.write_buffer] && t.observed_overflow) begin
            record_event(RECOVERY);
            drop_pending[t.write_buffer] = 0;
            freed_after_drop[t.write_buffer] = 0;
        end

        // Count use/reuse only after a complete 128-sample frame is collected.
        if (t.write_frame_done) begin
            record_event(t.write_buffer ? FILL_1 : FILL_0);
            if (freed_since_fill[t.write_buffer])
                record_event(t.write_buffer ? REUSE_1 : REUSE_0);
            freed_since_fill[t.write_buffer] = 0;
        end

        // Process release last: acceptance uses the state BEFORE this edge.
        // A full-buffer input on the final output edge is still a drop.
        if (t.read_frame_done) begin
            freed_since_fill[t.read_buffer] = 1;
            if (drop_pending[t.read_buffer])
                freed_after_drop[t.read_buffer] = 1;
        end
    endfunction

    // Called once per monitor snapshot, independently of scoreboard event sampling.
    function void write_stimulus(core_ready_item t);
        stimulus_observations++;

        if (t.rst !== 1'b0) begin
            have_previous_adc = 0;
            gap_known = 0;
            idle_cycles = 0;
            return;
        end

        if ($isunknown(t.adc_valid)) begin
            // The monitor reports X/Z. Do not bridge an unknown interval.
            have_previous_adc = 0;
            idle_cycles = 0;
            return;
        end

        if (t.adc_valid == 1'b0) begin
            // Saturate because all gaps >= 6 belong to one diagnostic bin.
            if (have_previous_adc && idle_cycles < 6)
                idle_cycles++;
            return;
        end

        if ($isunknown({t.adc_data, t.frame_ready, t.data_ready})) begin
            have_previous_adc = 0;
            idle_cycles = 0;
            return;
        end

        sampled_data = t.adc_data;
        sampled_ready = {t.frame_ready, t.data_ready};
        sampled_gap = idle_cycles;
        gap_known = have_previous_adc;
        stimulus_cg.sample();

        // Counters make the same bin definitions readable in the text report.
        input_samples++;
        data_hits[sampled_data / 4]++;
        ready_hits[sampled_ready]++;
        if (gap_known) begin
            gap_hits[sampled_gap]++;
            if (sampled_gap <= 5)
                cross_hits[sampled_gap][sampled_ready]++;
        end

        have_previous_adc = 1;
        idle_cycles = 0;
    endfunction

    function void report_stimulus();
        int unsigned covered_data;
        int unsigned covered_gap;
        int unsigned covered_ready;
        int unsigned covered_cross;
        covered_data = 0;
        covered_gap = 0;
        covered_ready = 0;
        covered_cross = 0;
        foreach (data_hits[i])
            if (data_hits[i] != 0) covered_data++;
        foreach (gap_hits[i])
            if (gap_hits[i] != 0) covered_gap++;
        foreach (ready_hits[i])
            if (ready_hits[i] != 0) covered_ready++;
        foreach (cross_hits[i,j])
            if (cross_hits[i][j] != 0) covered_cross++;

        `uvm_info("STIM_COV_SUMMARY", $sformatf(
            "inputs=%0d data_ranges=%0d/1024 gap_bins=%0d/7 ready_bins=%0d/4 gap_ready=%0d/24",
            input_samples, covered_data, covered_gap, covered_ready, covered_cross), UVM_NONE)
        `uvm_info("STIM_COV_SCORE", $sformatf(
            "data=%0.2f%% gap=%0.2f%% ready=%0.2f%% gap_ready=%0.2f%%",
            stimulus_cg.cp_data.get_inst_coverage(),
            stimulus_cg.cp_gap.get_inst_coverage(),
            stimulus_cg.cp_ready.get_inst_coverage(),
            stimulus_cg.gap_x_ready.get_inst_coverage()), UVM_NONE)

        foreach (gap_hits[i]) begin
            if (i < 6)
                `uvm_info("STIM_GAP", $sformatf("gap=%0d hits=%0d", i, gap_hits[i]), UVM_NONE)
            else
                `uvm_info("STIM_GAP", $sformatf("gap>=6 hits=%0d", gap_hits[i]), UVM_NONE)
        end
        foreach (ready_hits[i]) begin
            `uvm_info("STIM_READY", $sformatf("ready=%02b hits=%0d", i[1:0], ready_hits[i]), UVM_NONE)
        end
        foreach (cross_hits[i,j]) begin
            `uvm_info("STIM_CROSS", $sformatf(
                "gap=%0d ready=%02b hits=%0d", i, j[1:0], cross_hits[i][j]), UVM_NONE)
        end
    endfunction

    function string event_name(int code);
        case (code)
            CONCURRENT: return "accepted_and_output";
            FILL_0:     return "buffer_0_filled";
            FILL_1:     return "buffer_1_filled";
            REUSE_0:    return "buffer_0_reused";
            REUSE_1:    return "buffer_1_reused";
            FULL_DROP:  return "input_dropped_full";
            RECOVERY:   return "collection_resumed";
            default:    return "unknown";
        endcase
    endfunction

    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        if (stimulus_observations == 0)
            `uvm_error("STIM_NO_EVENTS", "Stimulus coverage received no monitor observations")
        if (observation_count == 0)
            `uvm_error("COV_NO_EVENTS", "Coverage received no observations")
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        report_stimulus();
        `uvm_info("COV_SUMMARY", $sformatf(
            "buffer coverage=%0.2f%% (7 bins, scoreboard-model events)",
            buffer_cg.get_inst_coverage()), UVM_NONE)
        foreach (hits[i]) begin
            `uvm_info("COV_BIN", $sformatf("%s hits=%0d",
                event_name(i), hits[i]), UVM_NONE)
            if (hits[i] == 0)
                `uvm_info("COV_MISSING", event_name(i), UVM_NONE)
        end
    endfunction
endclass

`endif
