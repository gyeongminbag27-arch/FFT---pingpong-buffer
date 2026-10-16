`ifndef ADC_ITEM_SVH
`define ADC_ITEM_SVH

class adc_item extends uvm_sequence_item;

    // 12 bit ADC sample value
    rand bit [11:0] sample;

    // number of idle cycles with valid =0 before driving this sample
    rand int unsigned gap_cycles;

    // default gap range used when randomize() is called 
    constraint c_gap_cycles {
        gap_cycles inside {[0:5]};
    }

    // Register this class with the UVM factory
    `uvm_object_utils(adc_item)

    // Object constructor
    function new(string name = "adc_item");
        super.new(name);
    endfunction

endclass

`endif
