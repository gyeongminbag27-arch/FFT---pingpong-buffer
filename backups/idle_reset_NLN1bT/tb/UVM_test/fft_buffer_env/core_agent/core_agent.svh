`ifndef CORE_AGENT_SVH
`define CORE_AGENT_SVH

class core_agent extends uvm_agent;

    `uvm_component_utils(core_agent)

    core_sequencer sequencer;
    core_driver    driver;
    core_monitor   monitor;

    function new(
        string name = "core_agent",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // 관측은 active/passive 모두 수행
        monitor = core_monitor::type_id::create(
            "monitor", this
        );

        if (get_is_active() == UVM_ACTIVE) begin
            sequencer = core_sequencer::type_id::create(
                "sequencer", this
            );

            driver = core_driver::type_id::create(
                "driver", this
            );
        end
    endfunction

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