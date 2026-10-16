`ifndef CORE_READY_SEQUENCE_SVH
`define CORE_READY_SEQUENCE_SVH

class core_ready_sequence
    extends uvm_sequence #(core_ready_item);

    `uvm_object_utils(core_ready_sequence)

    // 0: 기존 overflow 발생·복구 시험
    // 1: reset 이후 한 프레임 전달 시험
    bit post_reset_mode = 0;

    function new(string name = "core_ready_sequence");
        super.new(name);
    endfunction

    task send_ready(
        input bit frame_ready_value,
        input bit data_ready_value,
        input int unsigned cycles
    );
        core_ready_item req;

        req = core_ready_item::type_id::create("req");

        start_item(req);

        req.frame_ready = frame_ready_value;
        req.data_ready  = data_ready_value;
        req.hold_cycles = cycles;

        finish_item(req);
    endtask

    virtual task body();

        //==================================================
        // Reset 이후: 새 프레임 수집·출력 동안 ready 유지
        //==================================================
        if (post_reset_mode) begin
            send_ready(
                1'b1,
                1'b1,
                300
            );

            return;
        end

        //==================================================
        // Reset 이전: 두 버퍼가 가득 찰 때까지 수락 차단
        //==================================================
        send_ready(
            1'b0,
            1'b1,
            270
        );

        //==================================================
        // 기존 두 프레임과 overflow 이후 복구 프레임 출력
        //==================================================
        send_ready(
            1'b1,
            1'b1,
            430
        );

    endtask

endclass

`endif