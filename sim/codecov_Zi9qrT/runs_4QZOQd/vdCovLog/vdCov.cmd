verdiWindowResize -win $_vdCoverage_1 "724" "464" "1635" "710"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
verdiSetFont  -font  {DejaVu Sans}  -size  12
verdiSetFont -font "DejaVu Sans" -size "12"
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier /home/pedu12/workspace/fft_buffer/sim/codecov_Zi9qrT/runs_4QZOQd/codecov_merged_fixed.vdb -testdir {} -test {/home/pedu12/workspace/fft_buffer/sim/codecov_Zi9qrT/runs_4QZOQd/codecov_merged_fixed/test} -merge MergedTest -db_max_tests 10 -sdc_level 1 -fsm transition
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 "724" "464" "1635" "710"
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_top   }
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} tb_top
gui_list_expand -id CoverageTable.1   tb_top
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_top  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_top  tb_top.dut   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_top.dut  -column {} 
gui_list_select -id CovDetail.1 -list line { Block   }
gui_list_action -id  CovDetail.1 -list {line} Block
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list line { Block  Statement   }
gui_list_action -id  CovDetail.1 -list {line} Statement
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_covdetail_select -id  CovDetail.1   -name   Condition
gui_covdetail_select -id  CovDetail.1   -name   Branch
gui_list_select -id CovDetail.1 -list branch { Item4   }
gui_list_action -id  CovDetail.1 -list {branch} Item4  -column {Coverage} 
verdiWindowResize -win $_vdCoverage_1 "281" "429" "1934" "710"
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_covdetail_select -id  CovDetail.1   -name   Line
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_top.dut  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_top.dut  tb_top   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_top  tb_top.dut   }
verdiWindowResize -win $_vdCoverage_1 "983" "429" "1232" "710"
verdiDockWidgetSetCurTab -dock widgetDock_<Hvp>
verdiSetActWin -dock widgetDock_<Hvp>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
verdiDockWidgetSetCurTab -dock widgetDock_<CovSrc.1>
verdiSetActWin -dock widgetDock_<CovSrc.1>
verdiDockWidgetSetCurTab -dock widgetDock_<HvpDetail>
verdiSetActWin -dock widgetDock_<HvpDetail>
verdiDockWidgetSetCurTab -dock widgetDock_<CovDetail>
verdiSetActWin -dock widgetDock_<CovDetail>
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_covdetail_select -id  CovDetail.1   -name   FSM
gui_covdetail_select -id  CovDetail.1   -name   Condition
verdiWindowResize -win $_vdCoverage_1 "551" "353" "1745" "710"
vdCovExit -noprompt
