`ifndef ADC_MONITOR_SVH
`define ADC_MONITOR_SVH

class adc_monitor extends uvm_monitor;

    `uvm_component_utils(adc_monitor)

    // 실제 interface의 ADC 관측용 참조
    virtual fft_buffer_if.ADC_MONITOR vif;

    // 관측한 adc_item을 scoreboard·coverage로 전달
    uvm_analysis_port #(adc_item) ap;

    function new(
        string name = "adc_monitor",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    //==================================================
    // 1. Analysis port 생성 및 interface 참조 획득
    //==================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap = new("ap", this);

        if (!uvm_config_db#(
            virtual fft_buffer_if.ADC_MONITOR
        )::get(this, "", "adc_mon_vif", vif)) begin

            `uvm_fatal(
                "NO_ADC_MON_VIF",
                "adc_mon_vif was not found in uvm_config_db"
            )
        end
    endfunction

    //==================================================
    // 2. 유효 ADC 입력 관측
    //==================================================
    virtual task run_phase(uvm_phase phase);
        adc_item observed;

        forever begin
            @(vif.adc_mon_cb);

            // Reset 해제가 확인된 동안만 관측
            if (vif.adc_mon_cb.rst === 1'b0) begin

                // Valid가 X/Z이면 오류 보고
                if ($isunknown(
                    vif.adc_mon_cb.i_adc_data_valid
                )) begin
                    `uvm_error(
                        "ADC_VALID_X",
                        "ADC valid contains X/Z outside reset"
                    )

                end else if (
                    vif.adc_mon_cb.i_adc_data_valid === 1'b1
                ) begin

                    // bit 필드에 대입하기 전에 원본 신호 검사
                    if ($isunknown(
                        vif.adc_mon_cb.i_adc_data
                    )) begin
                        `uvm_error(
                            "ADC_DATA_X",
                            "ADC data contains X/Z while valid=1"
                        )

                    end else begin
                        // 유효 샘플마다 새로운 관측 객체 생성
                        observed = adc_item::type_id::create(
                            "observed"
                        );

                        observed.sample =
                            vif.adc_mon_cb.i_adc_data;

                        // 요청용 필드이므로 관측에서는 사용하지 않음
                        // 실제 공백이 0이었다는 뜻이 아님
                        observed.gap_cycles = 0;

                        `uvm_info(
                            "ADC_MON",
                            $sformatf(
                                "time=%0t sample=%0d",
                                $time,
                                observed.sample
                            ),
                            UVM_MEDIUM
                        )

                        // 연결된 subscriber로 관측 객체 전달
                        ap.write(observed);
                    end
                end
            end
        end
    endtask

endclass

`endif