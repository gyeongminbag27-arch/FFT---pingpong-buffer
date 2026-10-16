`timescale 1ns / 1ps

module tb_top;

    import uvm_pkg::*;
    import fft_buffer_pkg::*;

    // 1. Clock: 10ns 주기
    parameter time CLK_PERIOD = 10ns;

    logic clk = 1'b0;

    always #(CLK_PERIOD / 2) clk = ~clk;

    // 2. 공용 interface
    fft_buffer_if bus_if (
        .clk(clk)
    );

    // 3. DUT 연결
    fft_buffer #(
        .ADC_BIT (12),
        .FFT_W   (40)
    ) dut (
        .clk              (clk),
        .rst              (bus_if.rst),

        .i_adc_data       (bus_if.i_adc_data),
        .i_adc_data_valid (bus_if.i_adc_data_valid),

        .o_frame_valid    (bus_if.o_frame_valid),
        .i_frame_ready    (bus_if.i_frame_ready),

        .o_buf_data_valid (bus_if.o_buf_data_valid),
        .i_buf_data_ready (bus_if.i_buf_data_ready),

        .o_buf_data0      (bus_if.o_buf_data0),
        .o_buf_data1      (bus_if.o_buf_data1),
        .o_overflow       (bus_if.o_overflow)
    );

    //==================================================
// 4. Reset 구동
//
// rst는 이 블록에서만 구동합니다.
// UVM test는 event로 reset을 요청합니다.
//==================================================
initial begin : reset_control
    uvm_event reset_request;
    uvm_event reset_done;

    reset_request =
        uvm_event_pool::get_global("fft_buffer_reset_request");

    reset_done =
        uvm_event_pool::get_global("fft_buffer_reset_done");

    // 초기 reset
    bus_if.rst = 1'b1;

    repeat (5) @(negedge clk);

    bus_if.rst = 1'b0;

    // 시험 중 요청받은 reset
    forever begin
        reset_request.wait_trigger();

        // 상승 에지에서의 입력 관측과 겹치지 않도록
        // 하강 에지에서 reset을 변경합니다.
        @(negedge clk);
        bus_if.rst = 1'b1;

        repeat (3) @(negedge clk);
        bus_if.rst = 1'b0;

        reset_done.trigger();
    end
end
    

    

    // 7. Interface 등록 후 UVM 실행
    initial begin
        uvm_config_db#(virtual fft_buffer_if.ADC_DRIVER)::set(
            null, "*", "adc_drv_vif", bus_if
        );

        uvm_config_db#(virtual fft_buffer_if.ADC_MONITOR)::set(
            null, "*", "adc_mon_vif", bus_if
        );

        uvm_config_db#(virtual fft_buffer_if.CORE_DRIVER)::set(
            null, "*", "core_drv_vif", bus_if
        );

        uvm_config_db#(virtual fft_buffer_if.CORE_MONITOR)::set(
            null, "*", "core_mon_vif", bus_if
        );

        run_test("fft_buffer_base_test");
    end

        // Record waveform data only when explicitly requested.
    initial begin : waveform_dump
        if ($test$plusargs("DUMP_FSDB")) begin
         //   $fsdbDumpfile("fft_buffer_reuse.fsdb");
         //   $fsdbDumpvars(0, tb_top);
        end
    end



endmodule