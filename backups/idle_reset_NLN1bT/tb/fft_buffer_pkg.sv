`timescale 1ns / 1ps

package fft_buffer_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // ADC
    `include "adc_item.svh"
    `include "adc_sequence.svh"
    `include "adc_sequencer.svh"
    `include "adc_driver.svh"
    `include "adc_monitor.svh"
    `include "adc_agent.svh"

    // Core
    `include "core_ready_item.svh"
    `include "core_ready_sequence.svh"
    `include "core_sequencer.svh"
    `include "core_driver.svh"
    `include "core_monitor.svh"
    `include "core_agent.svh"

    // Environment / Test
    `include "fft_buffer_scoreboard.svh"
    `include "fft_buffer_env.svh"
    `include "fft_buffer_test.svh"

endpackage