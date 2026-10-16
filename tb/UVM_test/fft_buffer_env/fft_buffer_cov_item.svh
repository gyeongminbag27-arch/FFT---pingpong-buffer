`ifndef FFT_BUFFER_COV_ITEM_SVH
`define FFT_BUFFER_COV_ITEM_SVH

// Model-derived events for one observed clock edge.
// This object is used for coverage, not for driving DUT inputs.
class fft_buffer_cov_item extends uvm_sequence_item;

    `uvm_object_utils(fft_buffer_cov_item)

    // Reset was observed on this edge.
    bit rst;

    // An ADC sample was accepted or dropped on this edge.
    bit accepted;
    bit dropped;

    // An output pair was transferred on this edge.
    bit pair_transfer;

    // Buffer selectors before the model updates its state.
    bit write_buffer;
    bit read_buffer;

    // The final input sample completed a 128-sample frame.
    bit write_frame_done;

    // The final output pair completed a 64-pair transfer.
    bit read_frame_done;

    // Actual overflow signal sampled by the Core monitor.
    bit observed_overflow;

    // Time of the observed clock edge.
    time sample_time;

    function new(string name = "fft_buffer_cov_item");
        super.new(name);
    endfunction

endclass

`endif