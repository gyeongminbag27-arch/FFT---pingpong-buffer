`ifndef ADC_SEQUENCER_SVH
`define ADC_SEQUENCER_SVH

// provide adc sequence item to driver
class adc_sequencer extends uvm_sequencer #(adc_item);
// register this component with the UVM factory

    `uvm_component_utils(adc_sequencer)
// component cosntructor
    function new(
        string name = "adc_sequencer",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

endclass

`endif