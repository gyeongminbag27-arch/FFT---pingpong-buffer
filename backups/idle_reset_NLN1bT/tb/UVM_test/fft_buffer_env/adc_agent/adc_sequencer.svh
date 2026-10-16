`ifndef ADC_SEQUENCER_SVH
`define ADC_SEQUENCER_SVH

class adc_sequencer extends uvm_sequencer #(adc_item);

    `uvm_component_utils(adc_sequencer)

    function new(
        string name = "adc_sequencer",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

endclass

`endif