`timescale 1ns / 1ps
interface fft_buffer_if(input logic clk);

logic rst;

// ADC 입력: 테스트 벤치 -> DUT

logic [11:0] i_adc_data;
logic        i_adc_data_valid;

// 프레임 전달

logic o_frame_valid;
logic i_frame_ready;

// 데이터 한 쌍 전달
logic o_buf_data_valid;
logic i_buf_data_ready;

//DUT 출력

logic [39:0] o_buf_data0;
logic [39:0] o_buf_data1;
logic        o_overflow;


// ADC 구동 : 상승 에지에서 다음 입력 준비
  clocking adc_drv_cb @(posedge clk);
        default input #1step output #0;

        input  rst;
        output i_adc_data;
        output i_adc_data_valid;
    endclocking

    // ADC 관측: 상승 에지 직전의 입력 샘플링
    clocking adc_mon_cb @(posedge clk);
        default input #1step;

        input rst;
        input i_adc_data;
        input i_adc_data_valid;
    endclocking

    // Core driver: 다음 상승 에지에 사용할 ready 준비
    clocking core_drv_cb @(posedge clk);
        default input #1step output #0;

        input  rst;
        output i_frame_ready;
        output i_buf_data_ready;
    endclocking

    // Core monitor: 해당 상승 에지의 출력·handshake 관측
       // Core 출력과 ADC 입력을 같은 에지 기준으로 관측
    clocking core_mon_cb @(posedge clk);
        default input #1step;

        input rst;

        // 추가: 같은 에지의 ADC 입력 시도
        input i_adc_data;
        input i_adc_data_valid;

        // 프레임 handshake
        input o_frame_valid;
        input i_frame_ready;

        // 데이터 handshake
        input o_buf_data_valid;
        input i_buf_data_ready;

        // 실제 출력
        input o_buf_data0;
        input o_buf_data1;

        // Overflow 표시
        input o_overflow;
    endclocking
        // ADC driver: ADC 입력 구동용 clocking block 사용
    modport ADC_DRIVER (
        clocking adc_drv_cb
    );

    // ADC monitor: ADC 입력 관측용 clocking block 사용
    modport ADC_MONITOR (
        clocking adc_mon_cb
    );

    // Core driver: ready 구동용 clocking block 사용
    modport CORE_DRIVER (
        clocking core_drv_cb
    );

    // Core monitor: 출력·handshake 관측용 clocking block 사용
    modport CORE_MONITOR (
        clocking core_mon_cb
    );

endinterface

