verdiWindowResize -win $_vdCoverage_1 "978" "409" "1214" "710"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
verdiSetFont  -font  {DejaVu Sans}  -size  12
verdiSetFont -font "DejaVu Sans" -size "12"
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier /home/pedu12/workspace/fft_buffer/sim/stimulus1024_wMx6y8/stimulus1024_merged_seed1_10.vdb -testdir {} -test {/home/pedu12/workspace/fft_buffer/sim/stimulus1024_wMx6y8/stimulus1024_merged_seed1_10/test} -merge MergedTest -db_max_tests 10 -sdc_level 1 -fsm transition
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 "978" "409" "1214" "710"
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::buffer_cg   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::buffer_cg  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg
gui_list_expand -id CoverageTable.1   /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -column {Group} 
verdiWindowResize -win $_vdCoverage_1 "339" "409" "1853" "710"
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 "339" "409" "2161" "710"
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  /fft_buffer_pkg::fft_buffer_coverage::buffer_cg   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::buffer_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -column {Group} 
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
verdiWindowResize -win $_vdCoverage_1 "360" "557" "1402" "710"
verdiWindowResize -win $_vdCoverage_1 "666" "473" "1731" "710"
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg
gui_list_expand -id CoverageTable.1   /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -column {Group} 
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group}  }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_summarybar_goto -id  CovSrc.1   179
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_set_pref_value -category {ColumnCfg} -key {covergroup detail_V1.1_cp_ready_width} -value {91}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
verdiWindowResize -win $_vdCoverage_1 "112" "473" "2285" "710"
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -column {Instances} 
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_summarybar_goto -id  CovSrc.1   225
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap   } -type { {Cover Group} {Cover Group}  }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap  -type {Cover Group}
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_summarybar_goto -id  CovSrc.1   220
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap   } -type { {Cover Group}  }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<Summary>
gui_list_sort -id  CoverageTable.1   -list {covtblInstancesList} {Score}
gui_covtable_show -show  { Module List } -id  CoverageTable.1  -test  MergedTest
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -column {U+C} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap  -type {Cover Group}
verdiDockWidgetSetCurTab -dock widgetDock_<HvpDetail>
verdiSetActWin -dock widgetDock_<HvpDetail>
verdiDockWidgetSetCurTab -dock widgetDock_<CovDetail>
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -column {Group} 
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_gap   } -type { {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
verdiWindowResize -win $_vdCoverage_1 "897" "473" "1500" "710"
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -column {} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
verdiWindowResize -win $_vdCoverage_1 "430" "473" "1967" "710"
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -type {Cover Group}
verdiWindowResize -win $_vdCoverage_1 "430" "473" "2112" "710"
verdiWindowResize -win $_vdCoverage_1 "725" "306" "1462" "710"
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.gap_x_ready  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -column {Instances} 
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
verdiWindowResize -win $_vdCoverage_1 "725" "306" "1691" "710"
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap   } -type { {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
verdiDockWidgetSetCurTab -dock widgetDock_<HvpDetail>
verdiDockWidgetSetCurTab -dock widgetDock_<CovDetail>
gui_list_action -id  CovDetail.1 -list {covergroup} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_set_pref_value -category {ColumnCfg} -key {covergroup_V1.1_Score_U+C_width} -value {38}
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
gui_list_action -id  CovDetail.1 -list {covergroup} /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  -type {Cover Group}
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_gap  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_ready  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.gap_x_ready  /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list {covergroup detail} { {value_range[000:003]}   }
gui_list_sort -id  CovDetail.1   -list {covergroup detail} -descending  {Bin Name}
gui_list_sort -id  CovDetail.1   -list {covergroup detail} {Bin Name}
gui_list_select -id CovDetail.1 -list {covergroup detail} { {value_range[000:003]}  {value_range[008:00b]}   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { {value_range[008:00b]}  {value_range[004:007]}   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { {value_range[004:007]}  {value_range[000:003]}   }
gui_exclude_items -id  CovDetail.1  -list { covergroup detail } { {value_range[000:003]} }
gui_exclude_items -id  CovDetail.1  -list { covergroup detail }  -include { {value_range[000:003]} }
gui_list_select -id CovDetail.1 -list {covergroup detail} { {value_range[000:003]}   }
verdiWindowResize -win $_vdCoverage_1 "725" "306" "1691" "902"
verdiSetActWin -dock widgetDock_Message
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list covergroup { fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg.cp_data   } -type { {Cover Group}  }
verdiSetActWin -dock widgetDock_<CovSrc.1>
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 "753" "226" "1691" "1165"
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /fft_buffer_pkg::fft_buffer_coverage::stimulus_cg/fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.tb_top.me.obj.stimulus_cg  fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} fft_buffer_pkg::fft_buffer_coverage::stimulus_cg.cp_data  -column {} 
