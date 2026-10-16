simSetSimulator "-vcssv" -exec \
           "/home/pedu12/workspace/fft_buffer/sim/reuse_wave_A6sGvr/simv_reuse_wave" \
           -args \
           "+UVM_TESTNAME=fft_buffer_base_test +UVM_VERBOSITY=UVM_MEDIUM +DUMP_FSDB"
debImport "-dbdir" \
          "/home/pedu12/workspace/fft_buffer/sim/reuse_wave_A6sGvr/simv_reuse_wave.daidir"
debLoadSimResult \
           /home/pedu12/workspace/fft_buffer/sim/reuse_wave_A6sGvr/fft_buffer_reuse.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "780" "209" "1384" "1089"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSelectGroup -win $_nWave2 {G1}
verdiSetActWin -win $_nWave2
viaOneSearchClose
verdiSetActWin -dock widgetDock_<Message>
verdiDockWidgetHide -dock widgetDock_<Message>
verdiSetActWin -win $_nWave2
srcHBSelect "tb_top.bus_if" -win $_nTrace1
srcHBSelect "tb_top.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.dut" -win $_nTrace1
srcSetScope "tb_top.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_top.dut" -win $_nTrace1
srcHBSelect "tb_top.dut" -win $_nTrace1
srcSetScope "tb_top.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_top.dut" -win $_nTrace1
srcHBSelect "tb_top.dut" -win $_nTrace1
srcSetScope "tb_top.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_top.dut" -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 17 -pos 2 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {17 17 5 6 3 1} -backward
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 17 -pos 2 -win $_nTrace1
srcAction -pos 16 4 2 -win $_nTrace1 -name "clk" -ctrlKey off
verdiSetActWin -dock widgetDock_<Message>
wvAddSignal -win $_nWave2 "/tb_top/clk"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiFindBar -show -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "rst" -next -widget MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvAddSignal -win $_nWave2 "/tb_top/dut/rst"
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiFindBar -pattern "i_adc_data" -next -widget MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 "/tb_top/dut/i_adc_data\[11:0\]"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
verdiFindBar -pattern "i_adc_data_valid" -next -widget MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 "/tb_top/dut/i_adc_data_valid"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 30 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvAddSignal -win $_nWave2 "/tb_top/dut/o_frame_valid"
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -word -line 31 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvAddSignal -win $_nWave2 "/tb_top/dut/i_frame_ready"
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
srcDeselectAll -win $_nTrace1
srcSelect -word -line 33 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvAddSignal -win $_nWave2 "/tb_top/dut/o_buf_data_valid"
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 34 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvAddSignal -win $_nWave2 "/tb_top/dut/i_buf_data_ready"
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 8)}
srcDeselectAll -win $_nTrace1
srcSelect -word -line 38 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvAddSignal -win $_nWave2 "/tb_top/dut/o_overflow"
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 9)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSetCursor -win $_nWave2 268584.689312 -snap {("G2" 0)}
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
verdiWindowResize -win $_Verdi_1 "170" "100" "2011" "1089"
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 0.000000
wvSetWindowTimeUnit -win $_nWave2 1.000000 us
wvSetCursor -win $_nWave2 2.502893
wvSetCursor -win $_nWave2 2.498597
wvSetCursor -win $_nWave2 2.501103
wvSetCursor -win $_nWave2 2.600992
wvSetCursor -win $_nWave2 2.753511 -snap {("G1" 6)}
wvSetCursor -win $_nWave2 4.050636 -snap {("G1" 5)}
wvSetCursor -win $_nWave2 4.048488 -snap {("G1" 5)}
wvSetCursor -win $_nWave2 4.050994 -snap {("G1" 5)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 4.055000
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 2.659411 -snap {("G1" 3)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 2.623608 -snap {("G1" 9)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 2.717053 -snap {("G1" 8)}
wvSetCursor -win $_nWave2 0.113852 -snap {("G2" 0)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 2.654937 -snap {("G1" 9)}
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 4.128120 -snap {("G2" 0)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 2.630926 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.639573 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.641607 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.672126 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.658901 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.700101 -snap {("G1" 4)}
wvZoom -win $_nWave2 2.642624 2.651271
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 2.811971 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.805460 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.845826 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 2.854941 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.943485 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 2.974736 -snap {("G1" 4)}
srcActiveTrace "tb_top.dut.i_adc_data\[11:0\]" -TraceByDConWave -TraceTime \
           2645000 -TraceValue 111100000011 -win $_nTrace1
wvSetCursor -win $_nWave2 2.956506 -snap {("G1" 5)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 3.698070 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 2.745896 -snap {("G1" 6)}
wvSetCursor -win $_nWave2 2.760138 -snap {("G1" 6)}
wvSetCursor -win $_nWave2 2.767259 -snap {("G1" 6)}
wvZoom -win $_nWave2 2.752000 2.760138
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSelectGroup -win $_nWave2 {G2}
wvSelectGroup -win $_nWave2 {G2}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetCursor -win $_nWave2 4.010411
verdiSetActWin -win $_nWave2
wvZoomIn -win $_nWave2
wvGoToTime -win $_nWave2 4.055
srcHBSelect "tb_top.bus_if.CORE_MONITOR" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSetCursor -win $_nWave2 4.159782 -snap {("G2" 0)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 4.110455 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 4.119034 -snap {("G2" 0)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 4.186131 -snap {("G2" 0)}
wvGoToTime -win $_nWave2 4.065
wvSetCursor -win $_nWave2 4.143433 -snap {("G2" 0)}
wvGoToTime -win $_nWave2 4.075
wvSetCursor -win $_nWave2 4.207663 -snap {("G2" 0)}
srcHBSelect "tb_top.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top" -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "bus_if.i_frame_ready" -line 32 -pos 1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "bus_if.o_buf_data_valid" -line 34 -pos 1
verdiWindowResize -win $_Verdi_1 "40" "100" "2141" "1089"
verdiSetActWin -win $_nWave2
nsMsgSwitchTab -tab cmpl
verdiSetActWin -dock widgetDock_<Message>
nsMsgSwitchTab -tab trace
nsMsgSwitchTab -tab search
nsMsgSwitchTab -tab intercon
nsMsgSwitchTab -tab trace
verdiSetActWin -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_top"
wvSetPosition -win $_nWave2 {("G1" 16)}
wvSetPosition -win $_nWave2 {("G1" 16)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_top/clk} -height 16 \
{/tb_top/dut/rst} -height 16 \
{/tb_top/dut/i_adc_data_valid} -height 16 \
{/tb_top/dut/i_adc_data\[11:0\]} -height 16 \
{/tb_top/dut/o_frame_valid} -height 16 \
{/tb_top/dut/i_frame_ready} -height 16 \
{/tb_top/dut/o_buf_data_valid} -height 16 \
{/tb_top/dut/i_buf_data_ready} -height 16 \
{/tb_top/dut/o_overflow} -height 16 \
{/tb_top/dut/full0_reg} -height 16 \
{/tb_top/dut/full1_reg} -height 16 \
{/tb_top/dut/write_buf_full} -height 16 \
{/tb_top/dut/wsel_reg} -height 16 \
{/tb_top/dut/adc_cnt_reg\[6:0\]} -height 16 \
{/tb_top/dut/rsel_reg} -height 16 \
{/tb_top/dut/pair_cnt_reg\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 16 )} 
wvSetPosition -win $_nWave2 {("G1" 16)}
wvSetPosition -win $_nWave2 {("G1" 16)}
wvSetPosition -win $_nWave2 {("G1" 16)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_top/clk} -height 16 \
{/tb_top/dut/rst} -height 16 \
{/tb_top/dut/i_adc_data_valid} -height 16 \
{/tb_top/dut/i_adc_data\[11:0\]} -height 16 \
{/tb_top/dut/o_frame_valid} -height 16 \
{/tb_top/dut/i_frame_ready} -height 16 \
{/tb_top/dut/o_buf_data_valid} -height 16 \
{/tb_top/dut/i_buf_data_ready} -height 16 \
{/tb_top/dut/o_overflow} -height 16 \
{/tb_top/dut/full0_reg} -height 16 \
{/tb_top/dut/full1_reg} -height 16 \
{/tb_top/dut/write_buf_full} -height 16 \
{/tb_top/dut/wsel_reg} -height 16 \
{/tb_top/dut/adc_cnt_reg\[6:0\]} -height 16 \
{/tb_top/dut/rsel_reg} -height 16 \
{/tb_top/dut/pair_cnt_reg\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 16 )} 
wvSetPosition -win $_nWave2 {("G1" 16)}
wvGetSignalClose -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 4.133698 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 4.140975 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 4.118072 -snap {("G2" 0)}
wvGoToTime -win $_nWave2 5.335
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSetRadix -win $_nWave2 -format UDec
wvSelectSignal -win $_nWave2 {( "G1" 12 )} 
wvSetPosition -win $_nWave2 {("G1" 12)}
wvSetPosition -win $_nWave2 {("G1" 11)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectSignal -win $_nWave2 {( "G1" 14 )} 
wvSetPosition -win $_nWave2 {("G1" 14)}
wvSetPosition -win $_nWave2 {("G1" 13)}
wvSetPosition -win $_nWave2 {("G1" 12)}
wvSetPosition -win $_nWave2 {("G1" 11)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSelectSignal -win $_nWave2 {( "G1" 12 )} 
wvSetPosition -win $_nWave2 {("G1" 11)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSelectSignal -win $_nWave2 {( "G1" 14 )} 
wvSetPosition -win $_nWave2 {("G1" 13)}
wvSetPosition -win $_nWave2 {("G1" 12)}
wvSetPosition -win $_nWave2 {("G1" 11)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetCursor -win $_nWave2 5.395052 -snap {("G2" 0)}
wvGoToTime -win $_nWave2 8.015
verdiWindowResize -win $_Verdi_1 "1181" "100" "1000" "1089"
verdiWindowResize -win $_Verdi_1 "1181" "100" "1424" "1089"
verdiWindowResize -win $_Verdi_1 "1463" "100" "1142" "1089"
debExit
