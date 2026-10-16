`ifndef CORE_DRIVER_SVH
`define CORE_DRIVER_SVH

class core_driver extends uvm_driver #(core_ready_item);

    `uvm_component_utils(core_driver)

    virtual fft_buffer_if.CORE_DRIVER vif;

    function new(
        string name = "core_driver",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    //==================================================
    // 1. Interface 참조 획득
    //==================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(
            virtual fft_buffer_if.CORE_DRIVER
        )::get(this, "", "core_drv_vif", vif)) begin

            `uvm_fatal(
                "NO_CORE_VIF",
                "core_drv_vif was not found in uvm_config_db"
            )
        end
    endfunction

    //==================================================
    // 2. Ready 구동 및 유지 기간 관리
    //==================================================
    virtual task run_phase(uvm_phase phase);
        core_ready_item req;
        int unsigned cycles_left;

        req         = null;
        cycles_left = 0;

        forever begin
            @(vif.core_drv_cb);

            // 초기 reset 동안 ready=0
            if (vif.core_drv_cb.rst !== 1'b0) begin
                vif.core_drv_cb.i_frame_ready    <= 1'b0;
                vif.core_drv_cb.i_buf_data_ready <= 1'b0;

                // 진행 중 요청의 reset 복구는 후속 구현
                if (req != null) begin
                    `uvm_fatal(
                        "CORE_RESET_DURING_ITEM",
                        "Reset during a Core item is not supported yet"
                    )
                end

                continue;
            end

            // 이전 에지에서 준비한 ready가
            // 현재 상승 에지에서 한 번 사용됨
            if (req != null) begin
                cycles_left--;

                if (cycles_left == 0) begin
                    seq_item_port.item_done();
                    req = null;
                end
            end

            // 이전 요청이 끝났거나 요청이 없으면
            // 같은 시각에 다음 요청 확인
            if (req == null) begin
                seq_item_port.try_next_item(req);

                if (req != null) begin
                    // 직접 대입한 값에는 constraint가 적용되지 않으므로 검사
                    if (req.hold_cycles == 0) begin
                        `uvm_fatal(
                            "CORE_BAD_HOLD",
                            "hold_cycles must be greater than zero"
                        )
                    end

                    cycles_left = req.hold_cycles;

                    `uvm_info(
                        "CORE_DRV",
                        $sformatf(
                            "Drive frame_ready=%0b data_ready=%0b for %0d cycles",
                            req.frame_ready,
                            req.data_ready,
                            req.hold_cycles
                        ),
                        UVM_MEDIUM
                    )
                end
            end

            // 다음 상승 에지에 사용할 ready 준비
            if (req == null) begin
                // 요청이 없으면 수락하지 않는 상태
                vif.core_drv_cb.i_frame_ready    <= 1'b0;
                vif.core_drv_cb.i_buf_data_ready <= 1'b0;
            end else begin
                vif.core_drv_cb.i_frame_ready
                    <= req.frame_ready;

                vif.core_drv_cb.i_buf_data_ready
                    <= req.data_ready;
            end
        end
    endtask

endclass

`endif