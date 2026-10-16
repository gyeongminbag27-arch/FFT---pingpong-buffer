`ifndef ADC_ITEM_SVH
`define ADC_ITEM_SVH

class adc_item extends uvm_sequence_item;

    // ADC에 전달할 12비트 샘플
    rand bit [11:0] sample;

    // 이번 샘플을 보내기 전에 valid=0으로 대기할 클럭 수
    rand int unsigned gap_cycles;

    // 기본 랜덤 시험에서는 대기 시간을 0~5클럭으로 제한
    constraint c_gap_cycles {
        gap_cycles inside {[0:5]};
    }

    // UVM factory에 클래스 등록
    `uvm_object_utils(adc_item)

    // 객체 생성자
    function new(string name = "adc_item");
        super.new(name);
    endfunction

endclass

`endif
