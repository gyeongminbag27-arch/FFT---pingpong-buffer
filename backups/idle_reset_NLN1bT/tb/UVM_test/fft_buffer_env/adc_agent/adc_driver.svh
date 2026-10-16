`ifndef ADC_DRIVER_SVH
`define ADC_DRIVER_SVH

class adc_driver extends uvm_driver #(adc_item);

    `uvm_component_utils(adc_driver)

    // 실제 bus_if를 가리킬 참조
    // ADC_DRIVER modport에 공개된 clocking block 사용
    virtual fft_buffer_if.ADC_DRIVER vif;

    function new(
        string name = "adc_driver",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // tb_top에서 등록한 interface 참조 가져오기
        if (!uvm_config_db#(
            virtual fft_buffer_if.ADC_DRIVER
        )::get(this, "", "adc_drv_vif", vif)) begin

            `uvm_fatal(
                "NO_ADC_VIF",
                "adc_drv_vif was not found in uvm_config_db"
            )
        end
    endfunction

    // 다음 단계:
    // run_phase에서 item을 받아 vif를 통해 신호 구동


virtual task run_phase(uvm_phase phase);
    adc_item req;
    int unsigned gap_left;
    bit sample_in_flight;

    req              = null;
    gap_left         = 0;
    sample_in_flight = 0;

    forever begin
        @(vif.adc_drv_cb);

        // 1. 초기 reset 동안 입력 초기화
        if (vif.adc_drv_cb.rst !== 1'b0) begin
            vif.adc_drv_cb.i_adc_data       <= 12'd0;
            vif.adc_drv_cb.i_adc_data_valid <= 1'b0;

            // 진행 중 요청의 reset 복구는 후속 단계에서 구현
            if (req != null) begin
                `uvm_fatal(
                    "ADC_RESET_DURING_ITEM",
                    "Reset during an ADC item is not supported yet"
                )
            end

            continue;
        end

        // 2. 지난 에지에서 구동한 샘플의 전송 완료
        // 현재 에지에서 DUT가 해당 입력을 읽었음
        if (sample_in_flight) begin
            seq_item_port.item_done();

            req              = null;
            sample_in_flight = 0;
        end

        // 3. 처리 중인 요청이 없으면 새 요청 확인
        if (req == null) begin
            seq_item_port.try_next_item(req);

            if (req != null) begin
                gap_left = req.gap_cycles;
            end
        end

        // 4. 다음 상승 에지에 사용할 입력 준비
        if (req == null) begin
            // 요청 없음: valid 해제, data는 유지
            vif.adc_drv_cb.i_adc_data_valid <= 1'b0;

        end else if (gap_left > 0) begin
            // 이번 한 클럭을 입력 공백으로 사용
            vif.adc_drv_cb.i_adc_data_valid <= 1'b0;
            gap_left--;

        end else begin
            // 공백 대기가 끝났으므로 샘플 구동
            vif.adc_drv_cb.i_adc_data       <= req.sample;
            vif.adc_drv_cb.i_adc_data_valid <= 1'b1;

            // 다음 상승 에지에서 완료 처리할 표시
            sample_in_flight = 1;
        end
    end
endtask
endclass

`endif