`ifndef ADC_SEQUENCE_SVH
`define ADC_SEQUENCE_SVH

class adc_sequence extends uvm_sequence #(adc_item);

    `uvm_object_utils(adc_sequence)
    bit post_reset_mode = 0;

    function new(string name = "adc_sequence");
        super.new(name);
    endfunction

    // 지정한 값과 대기 시간을 driver에 전달
    task send_sample(
        input bit [11:0] value,
        input int unsigned gap
    );
        adc_item req;

        req = adc_item::type_id::create("req");

        start_item(req);

        req.sample     = value;
        req.gap_cycles = gap;

        finish_item(req);
    endtask

    virtual task body();
    if (post_reset_mode) begin
    `uvm_info(
        "ADC_SEQ",
        "Sending one frame after reset: samples 1024 through 1151",
        UVM_LOW
    )

    for (int unsigned i = 0; i < 128; i++) begin
        send_sample(1024 + i, 0);
    end

    return;
end

        //==================================================
        // 1. 두 버퍼 채우기
        //
        // Core가 프레임을 수락하지 않는 동안
        // 샘플 256개를 연속 입력
        //==================================================
        `uvm_info(
            "ADC_SEQ",
            "Sending 256 samples to fill both buffers",
            UVM_LOW
        )

        for (int unsigned i = 0; i < 256; i++) begin
            send_sample(i, 0);
        end

        //==================================================
        // 2. 두 버퍼가 가득 찬 상태에서 추가 입력
        //
        // 이 4개는 출력에 포함되면 안 됩니다.
        //==================================================
        `uvm_info(
            "ADC_SEQ",
            "Sending 4 samples that must be dropped",
            UVM_LOW
        )

        for (int unsigned i = 0; i < 4; i++) begin
            send_sample(12'hF00 + i, 0);
        end

        //==================================================
        // 3. 첫 버퍼가 비워질 때까지 기다린 후 재입력
        //
        // 첫 샘플 앞에서만 140클럭 대기
        // 나머지 127개는 연속 입력
        //==================================================
        `uvm_info(
            "ADC_SEQ",
            "Waiting 140 cycles before sending the recovery frame",
            UVM_LOW
        )

        for (int unsigned i = 0; i < 128; i++) begin
            if (i == 0)
                send_sample(512 + i, 140);
            else
                send_sample(512 + i, 0);
        end

            // Wait for buffer 1 to drain, then collect another full frame.
        `uvm_info(
            "ADC_SEQ",
            "Waiting 140 cycles before refilling buffer 1: samples 768 through 895",
            UVM_LOW
        )

        for (int unsigned i = 0; i < 128; i++) begin
            if (i == 0)
                send_sample(768 + i, 140);
            else
                send_sample(768 + i, 0);
        end


    endtask

endclass

`endif