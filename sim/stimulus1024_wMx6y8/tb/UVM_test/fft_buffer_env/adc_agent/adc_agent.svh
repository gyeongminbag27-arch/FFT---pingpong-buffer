`ifndef ADC_AGENT_SVH
`define ADC_AGENT_SVH

class adc_agent extends uvm_agent;

    `uvm_component_utils(adc_agent)

    adc_sequencer sequencer;
    adc_driver    driver;
    adc_monitor   monitor;

    function new(
        string name = "adc_agent",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    //==================================================
    // 1. 하위 component 생성
    //==================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Monitor는 active/passive 모두 생성
        monitor = adc_monitor::type_id::create(
            "monitor", this
        );

        // Sequencer와 driver는 active일 때 생성
        if (get_is_active() == UVM_ACTIVE) begin
            sequencer = adc_sequencer::type_id::create(
                "sequencer", this
            );

            driver = adc_driver::type_id::create(
                "driver", this
            );
        end
    endfunction

    //==================================================
    // 2. Sequencer와 driver 연결
    //==================================================
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if (get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(
                sequencer.seq_item_export
            );
        end
    endfunction

endclass

`endif