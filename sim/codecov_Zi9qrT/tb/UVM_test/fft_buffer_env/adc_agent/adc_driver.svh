`ifndef ADC_DRIVER_SVH
`define ADC_DRIVER_SVH
// interface 
class adc_driver extends uvm_driver #(adc_item);

    `uvm_component_utils(adc_driver)

    // reference to bus if through the adc driver modport
    virtual fft_buffer_if.ADC_DRIVER vif;
    // component constructor
    function new(
        string name = "adc_driver",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

         // Retrieve the virtual interface registered by tb_top
        if (!uvm_config_db#(
            virtual fft_buffer_if.ADC_DRIVER
        )::get(this, "", "adc_drv_vif", vif)) begin

            `uvm_fatal(
                "NO_ADC_VIF",
                "adc_drv_vif was not found in uvm_config_db"
            )
        end
    endfunction

// retrieve the virtual interface registred by tb_top

virtual task run_phase(uvm_phase phase);
    adc_item req;
    int unsigned gap_left;
    bit sample_in_flight;

    req              = null;
    gap_left         = 0;
    sample_in_flight = 0;

    forever begin
        @(vif.adc_drv_cb);

        // 1. Drive idle values unless reset is known to be deasserted
        if (vif.adc_drv_cb.rst !== 1'b0) begin
            vif.adc_drv_cb.i_adc_data       <= 12'd0;
            vif.adc_drv_cb.i_adc_data_valid <= 1'b0;

            //  Recovery from reset during an active request is unsupported
            if (req != null) begin
                `uvm_fatal(
                    "ADC_RESET_DURING_ITEM",
                    "Reset during an ADC item is not supported yet"
                )
            end

            continue;
        end

        // 2. Complete the request 
        // driven at the previous clocking event
        //  The input sampling edge has occurred.
        if (sample_in_flight) begin
            seq_item_port.item_done();

            req              = null;
            sample_in_flight = 0;
        end

        // 3. Check for a new request 
        if (req == null) begin
            seq_item_port.try_next_item(req);

            if (req != null) begin
                gap_left = req.gap_cycles;
            end
        end

         // 4. Prepare inputs for the next rising edge
        if (req == null) begin
             // No request: valid 0
            vif.adc_drv_cb.i_adc_data_valid <= 1'b0;

        end else if (gap_left > 0) begin
           // Insert one idle cycle before driving the sample
           // valid 0, gpa_left 1 down
            vif.adc_drv_cb.i_adc_data_valid <= 1'b0;
            gap_left--;

        end else begin
            // Drive the sample after all requested idle cycles
            vif.adc_drv_cb.i_adc_data       <= req.sample;
            vif.adc_drv_cb.i_adc_data_valid <= 1'b1;

            // Mark the request for completion at the next clocking event
            sample_in_flight = 1;
        end
    end
endtask
endclass

`endif