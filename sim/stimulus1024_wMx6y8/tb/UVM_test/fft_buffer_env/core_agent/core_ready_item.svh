`ifndef CORE_READY_ITEM_SVH
`define CORE_READY_ITEM_SVH

class core_ready_item extends uvm_sequence_item;

    `uvm_object_utils(core_ready_item)

    //==================================================
    // 1. Sequence의 요청 / Monitor의 ready 관측
    //
    // Sequence: Driver에게 구동할 ready 값 지정
    // Monitor : 실제 interface에서 읽은 ready 값 기록
    //==================================================
    rand bit frame_ready;
    rand bit data_ready;

    //==================================================
    // 2. 요청 전용 필드
    //
    // Driver가 ready 값을 유지할 클럭 수
    // Monitor가 만든 객체에서는 사용하지 않음
    //==================================================
    rand int unsigned hold_cycles;

    constraint c_hold_cycles {
        hold_cycles inside {[1:20]};
    }

    //==================================================
    // 3. 관측 전용 필드
    //
    // Sequence와 Driver는 아래 필드를 사용하지 않음
    // Monitor가 clocking block에서 읽어 기록
    //==================================================
   logic rst;

    // 같은 에지의 ADC 입력 시도
    logic        adc_valid;
    logic [11:0] adc_data;

    // 프레임 및 데이터 출력 상태
    logic frame_valid;
    logic data_valid;

    logic [39:0] data0;
    logic [39:0] data1;

    logic overflow;

    time sample_time;

    function new(string name = "core_ready_item");
        super.new(name);
    endfunction

endclass

`endif