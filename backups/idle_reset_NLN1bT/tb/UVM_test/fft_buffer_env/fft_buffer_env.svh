`ifndef FFT_BUFFER_ENV_SVH
`define FFT_BUFFER_ENV_SVH

class fft_buffer_env extends uvm_env;

    `uvm_component_utils(fft_buffer_env)

    adc_agent  adc_agt;
    core_agent core_agt;

    fft_buffer_scoreboard scoreboard;

    function new(
        string name = "fft_buffer_env",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        adc_agt = adc_agent::type_id::create(
            "adc_agt", this
        );

        core_agt = core_agent::type_id::create(
            "core_agt", this
        );

        scoreboard = fft_buffer_scoreboard::type_id::create(
            "scoreboard", this
        );
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        adc_agt.monitor.ap.connect(
            scoreboard.adc_imp
        );

        core_agt.monitor.ap.connect(
            scoreboard.core_imp
        );
    endfunction

endclass

`endif