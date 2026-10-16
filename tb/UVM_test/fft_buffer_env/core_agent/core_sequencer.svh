`ifndef CORE_SEQUENCER_SVH
`define CORE_SEQUENCER_SVH

class core_sequencer extends uvm_sequencer #(core_ready_item);

    `uvm_component_utils(core_sequencer)

    function new(
        string name = "core_sequencer",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

endclass

`endif