###########################
#### Implement Modules ####
###########################
proc implement {impl} {
  global tclParams 
  global part
  global dcpLevel
  global verbose
  global implDir
  global xdcDir
  global dcpDir
  global RFH

  set top                 [get_attribute impl $impl top]
  set name                [get_attribute impl $impl name]
  set implXDC             [get_attribute impl $impl implXDC]
  set linkXDC             [get_attribute impl $impl linkXDC]
  set cores               [get_attribute impl $impl cores]
  set ip                  [get_attribute impl $impl ip]
  set ipRepo              [get_attribute impl $impl ipRepo]
  set hd                  [get_attribute impl $impl hd.impl]
  set td                  [get_attribute impl $impl td.impl]
  set pr                  [get_attribute impl $impl pr.impl]
  set ic                  [get_attribute impl $impl ic.impl]
  set incr                [get_attribute impl $impl incr.impl]
  set iso                 [get_attribute impl $impl iso.impl]
  set ooc                 [get_attribute impl $impl ooc.impl]
  set pr.budget           [get_attribute impl $impl pr.budget]
  set budgetExclude       [get_attribute impl $impl pr.budget_exclude]
  set partitions          [get_attribute impl $impl partitions]
  set link                [get_attribute impl $impl link]
  set opt                 [get_attribute impl $impl opt]
  set opt.pre             [get_attribute impl $impl opt.pre]
  set opt_options         [get_attribute impl $impl opt_options]
  set opt_directive       [get_attribute impl $impl opt_directive]
  set place               [get_attribute impl $impl place]
  set place.pre           [get_attribute impl $impl place.pre]
  set place_options       [get_attribute impl $impl place_options]
  set place_directive     [get_attribute impl $impl place_directive]
  set phys                [get_attribute impl $impl phys]
  set phys.pre            [get_attribute impl $impl phys.pre]
  set phys_options        [get_attribute impl $impl phys_options]
  set phys_directive      [get_attribute impl $impl phys_directive]
  set route               [get_attribute impl $impl route]
  set route.pre           [get_attribute impl $impl route.pre]
  set route_options       [get_attribute impl $impl route_options]
  set route_directive     [get_attribute impl $impl route_directive]
  set bitstream           [get_attribute impl $impl bitstream]
  set bitstream.pre       [get_attribute impl $impl bitstream.pre]
  set bitstream_options   [get_attribute impl $impl bitstream_options]
  set bitstream_settings  [get_attribute impl $impl bitstream_settings]
  set drc.quiet           [get_attribute impl $impl drc.quiet]

  if {($hd && ($td || $ic || $pr || $ooc)) || \
      ($td && ($hd || $ic || $pr || $ooc)) || \
      ($ic && ($td || $hd || $pr || $ooc)) || \
      ($pr && ($td || $hd || $ic || $ooc)) || \
      ($ooc && ($td || $hd || $ic || $pr)) } {
     set errMsg "\nERROR: Implementation $impl has more than one of the following flow variables set to 1"
     append errMsg "\n\thd.impl($hd)\n\ttd.impl($td)\n\tic.impl($ic)\n\tpr.impl($pr)\n\t$ooc.impl($ooc)\n"
     append errMsg "Only one of these variables can be set true at one time. To run multiple flows, create separate implementation runs."
     error $errMsg
  }

  set resultDir "$implDir/$impl"
  set reportDir "$resultDir/reports"

  #### Make the implementation directory, Clean-out and re-make the results directory
  command "file mkdir $implDir"
  command "file delete -force $resultDir"
  command "file mkdir $resultDir"
  command "file mkdir $reportDir"
  
  #### Open local log files
  set rfh [open "$resultDir/run.log" w]
  set cfh [open "$resultDir/command.log" w]
  set wfh [open "$resultDir/critical.log" w]

  set vivadoVer [version]
  puts $rfh "Info: Running Vivado version $vivadoVer"
  puts $RFH "Info: Running Vivado version $vivadoVer"

  command "puts \"#HD: Running implementation $impl\""
  puts "\tWriting results to: $resultDir"
  puts "\tWriting reports to: $reportDir"
  puts $rfh "#HD: Running implementation $impl"
  puts $rfh "Writing results to: $resultDir"
  puts $rfh "Writing reports to: $reportDir"
  puts $RFH "#HD: Running implementation $impl"
  puts $RFH "Writing results to: $resultDir"
  puts $RFH "Writing reports to: $reportDir"
  set impl_start [clock seconds]

  #### Set Tcl Params
  if {[info exists tclParams] && [llength $tclParams] > 0} {
     set_parameters $tclParams
  }

  #### Create in-memory project
  command "create_project -in_memory -part $part" "$resultDir/create_project.log"
  
  #### Setup any IP Repositories 
  if {$ipRepo != ""} {
     puts "\tLoading IP Repositories:\n\t+ [join $ipRepo "\n\t+ "]"
     command "set_property IP_REPO_PATHS \{$ipRepo\} \[current_fileset\]" "$resultDir/temp.log"
     command "update_ip_catalog" "$resultDir/temp.log"
  }

  ###########################################
  # Linking
  ###########################################
  if {$link} {
     #Determine state of Top (import or implement). 
     set topState "implement"
     foreach partition $partitions {
        lassign $partition module cell state name type level dcp
        if {[string match $cell $top]} {
           set topState $state 
           if {[llength $dcp]} {
              set topFile $dcp
           }
        }
     }

     #If DCP for top is not defined in Partition settings, try and find it.
     if {![info exist topFile] || ![llength $topFile]} {
        foreach module [get_modules] {
           set moduleName [get_attribute module $module moduleName]
           if {[string match $top $moduleName]} {
              break
           }
        }
        if {[string match $topState "implement"]} {
           set topFile [get_module_file $module]
        } elseif {[string match $topState "import"]} {
           if {$pr} {
              set topFile "$dcpDir/${top}_static.dcp"
           } else {
              set topFile "$dcpDir/${top}_routed.dcp"
           }
        } else {
           set errMsg "\nERROR: State of Top module $top is set to illegal state $topState." 
           error $errMsg
        }
     }

     puts "\t#HD: Adding file $topFile for $top"
     if {[info exists topFile]} {
        command "add_files $topFile"
     } else {
        set errMsg "\nERROR: Specified file $topFile cannot be found on disk. Verify path is correct." 
        error $errMsg
     }
  
     ####Read in top-level cores, ip,  and XDC on if Top is being implemented
     if {[string match $topState "implement"]} { 
        # Read in IP Netlists 
        if {[llength $cores] > 0} {
           add_cores $cores
        }
        # Read IP XCI files
        if {[llength $ip] > 0} {
           set start_time [clock seconds]
           add_ip $ip
           set end_time [clock seconds]
           log_time add_ip $start_time $end_time 0 "Add XCI files and generate/synthesize IP"
        }
        # Read in XDC files
        if {[llength $implXDC] > 0 && [string match $topState "implement"]} {
           add_xdc $implXDC
        } else {
           if {[string match $topState "import"]} {
              puts "\tInfo: Skipping top-level XDC files because $top is set to $topState"
           } else {
              puts "\tInfo: No pre-link_design XDC file specified for $impl"
           }
        }
     }
  
     ###########################################################
     # Link the top-level design with black boxes for Partitions 
     ###########################################################
     set start_time [clock seconds]
     if {!$ooc} {
        puts "\t#HD: Running link_design for $top \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
        command "link_design -mode default -part $part -top $top" "$resultDir/${top}_link_design.log"
     } else {
        puts "\t#HD: Running link_design for $top \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
        command "link_design -mode out_of_context -part $part -top $top" "$resultDir/${top}_link_design.log"
        #Set appropriate attribute on "current_design" for ISO and OOC flows.
        if {$iso} {
           command "set_property HD.ISOLATED 1 \[current_design]"
        } else {  
           command "set_property HD.PARTITION 1 \[current_design]"
        }
     }
     set end_time [clock seconds]
     log_time link_design $start_time $end_time 1 "link_design -part $part -top $top"

     ##############################################
     # Resolve Partitions 
     ##############################################
     #Special processing for TopDown implementation
     if {$td && $verbose > 0} {
        #Turn off phys_opt_design and route_design for TD run
        set phys  [set_attribute impl $impl phys  0]
        set route [set_attribute impl $impl route 0]
        #Turn on param to generate PP_RANGE if one does not exist
        set_parameters {hd.partPinRangesForPblock 1} 
     }

     foreach partition $partitions {
        lassign $partition module cell state name type level dcp
        if {![llength $name]} {
           set name [lindex [split $cell "/"] end]
        }

        #Process each partition that is not Top
        set moduleName [get_attribute module $module moduleName]
        if {![string match $moduleName $top]} {
           #Set appropriate HD.* property if Top/Static is being implemented
           if {[string match $topState "implement"]} {
              #Mark all partitions as HD.RECONFIG in a PR run unless partition 'type' is set to OOC
              if {$pr && ![string match $type "ooc"] && ![string match $type "iso"]} {
                 command "set_property HD.RECONFIGURABLE 1 \[get_cells $cell]"
              } elseif [string match $type "iso"] {
                 command "set_property HD.ISOLATED 1 \[get_cells $cell]"
              } else {
                 command "set_property HD.PARTITION 1 \[get_cells $cell]"
              }
           }

           #Find correct file to be used for Partition
           if {[llength $dcp] && ![string match $state "greybox"]} {
              set partitionFile $dcp
           } else {
              #Greybox overrides any other settings regardless of flow
              if {[string match $state "greybox"]} {
                 puts "\tInfo: Cell $cell will be implemented as a grey box."
                 set partitionFile "NA"
              #if flow is incremental, load synth netlist regardless of $state equal to import Vs implement
              } elseif {[string match $state "implement"] || $incr} {
                 set partitionFile [get_module_file $module]
              } elseif {[string match $state "import"]} {
                 if {$iso || $ooc} {
                    set partitionFile "$dcpDir/${pblock}_${module}_route_design.dcp"
                 } else {
                    set pblock [get_pblock -of [get_cell $cell]]
                    #Since names rely on Pblock to uniquify, error if no Pblock exists.
                    if {![llength $pblock]} {
                       set errMsg "Error: No pblock found on partition cell $cell."
                       error $errMsg
                    }
                    set partitionFile "$dcpDir/${pblock}_${module}_route_design.dcp"
                 }
              } else {
                 set errMsg "\nERROR: Invalid state \"$state\" in settings for $name\($impl)."
                 append errMsg"Valid states are \"implement\", \"import\", or \"greybox\".\n" 
                 error $errMsg
              }
           }
           if {![file exists $partitionFile] && ![string match $state "greybox"]} {
              set errMsg "ERROR: Partition \'$cell\' with state \'$state\' is set to use the file:\n$partitionFile\n\nThis file does not exist."
              if {$ooc} {
                 append errMsg "Check that the Name of the parition matches the Name field of the corresponding OOC run."
              }
              error $errMsg
           }

           #Resolve blackbox for partition
           if {![get_property IS_BLACKBOX [get_cells $cell]]} {
              set start_time [clock seconds]
              puts "\tCritical Warning: Partition cell \'$cell\' is not a blackbox. This likely occurred because OOC synthesis was not used. This can cause illegal optimization. Please verify it is intentional that this cell is not a blackbox at this stage in the flow.\nResolution: Caving out cell to make required blackbox. \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
              command "update_design -cells $cell -black_box" "$resultDir/update_design_blackbox_$name.log"
              set end_time [clock seconds]
              log_time update_design $start_time $end_time 0 "Create blackbox for $name"
           }
           if {[string match $state "greybox"]} {
              command "set_msg_config -id \"Constraints 18-514\" -suppress"
              command "set_msg_config -id \"Constraints 18-515\" -suppress"
              command "set_msg_config -id \"Constraints 18-402\" -suppress"
              set start_time [clock seconds]
              puts "\t#HD: Inserting LUT1 buffers on interface of $name \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
              command "update_design -cells $cell -buffer_ports" "$resultDir/update_design_bufferport_$name.log"
              set end_time [clock seconds]
              log_time update_design $start_time $end_time 0 "Buffer blackbox RM $name"
              #If verbose it turned up, write out intermediate link_design DCP files
              if {$dcpLevel > 1} {
                 set start_time [clock seconds]
                 command "write_checkpoint -force $resultDir/${top}_link_design_intermediate.dcp" "$resultDir/temp.log"
                 set end_time [clock seconds]
                 log_time write_checkpoint $start_time $end_time 0 "Intermediate link_design checkpoint for debug"
              }
              set budgetXDC $xdcDir/${name}_budget.xdc
              if {![file exists $budgetXDC] || ${pr.budget}} {
                 set start_time [clock seconds]
                 puts "\t#HD: Creating budget constraints for greybox $name \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
                 create_pr_budget -cell $cell -file $budgetXDC -exclude $budgetExclude
                 set end_time [clock seconds]
                 log_time create_budget $start_time $end_time 0 "Create budget constraints for $name"
              }
              set start_time [clock seconds]
              readXDC $budgetXDC
              set end_time [clock seconds]
              log_time read_xdc $start_time $end_time 0 "Read in budget constraints for $name"
           } else {
              set fileSplit [split $partitionFile "."]
              set fileType [lindex $fileSplit end]
              if {[string match $fileType "dcp"]} {
                 set start_time [clock seconds]
                 puts "\tReading in checkpoint $partitionFile for $cell ($module) \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
                 command "read_checkpoint -cell $cell $partitionFile -strict" "$resultDir/read_checkpoint_${module}_${name}.log"
                 set end_time [clock seconds]
                 log_time read_checkpoint $start_time $end_time 0 "Resolve blackbox for $name"
              } elseif {[string match $fileType "edf"] || [string match $fileType "edn"]} {
                 set start_time [clock seconds]
                 puts "\tUpdating design with $partitionFile for $cell ($module) \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
                 command "update_design -cells $cell -from_file $partitionFile" "$resultDir/update_design_$name.log"
                 set end_time [clock seconds]
                 log_time update_design $start_time $end_time 0 "Resolve blackbox for $name"
              } else {
                 set errMsg "\nERROR: Invalid file type \"$fileType\" for $partitionFile.\n"
                 error $errMsg
              }
           }
  
           #Read in Module XDC if module is not imported
           if {![string match $state "import"]} { 
              ## Read in module Impl XDC files 
              set implXDC [get_attribute module $module implXDC]
              if {[llength $implXDC] > 0} {
                 set start_time [clock seconds]
                 readXDC $implXDC
                 set end_time [clock seconds]
                 log_time read_xdc $start_time $end_time 0 "Cell level XDCs for $name"
              } else {
                 puts "\tInfo: No cell XDC file specified for $cell"
              }
           }
  
           #Lock imported Partitions
           if {[string match $state "import"] && !$incr} {
              if {![llength $level]} {
                 set level "routing"
              }
              set start_time [clock seconds]
              puts "\tLocking $cell \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
              command "lock_design -level $level $cell" "$resultDir/lock_design_$name.log"
              set end_time [clock seconds]
              log_time lock_design $start_time $end_time 0 "Locking cell $cell at level routing"
           }
  
           #Do up front check for PR for Pblocks on Partitions
           if {$verbose && $pr} {
              set rpPblock [get_pblocks -quiet -of [get_cells $cell]]
              if {![llength $rpPblock]} {
                 set errMsg "ERROR: No pblock found for PR cell $cell."
                 #error $errMsg
              }
           }

           #Create constraints for OOC partitions if TopDown run.
           if {$td && [string match $type "ooc"]} {
              puts "\t#HD: Creating OOC constraints for $cell"
              set start_time [clock seconds]
              create_set_logic $name $cell $xdcDir
              create_ooc_clocks $name $cell $xdcDir
              set end_time [clock seconds]
              log_time "create_constraints" $start_time $end_time 0 "Create necessary OOC constraints"
           }

           #If verbose it turned up, write out intermediate link_design DCP files
           if {$dcpLevel > 1} {
              set start_time [clock seconds]
              command "write_checkpoint -force $resultDir/${top}_link_design_intermediate.dcp" "$resultDir/temp.log"
              set end_time [clock seconds]
              log_time write_checkpoint $start_time $end_time 0 "Intermediate link_design checkpoint for debug"
           }
        }; #End: Process each partition that is not Top
     }

     ##############################################
     # Read in any linkXDC files 
     ##############################################
     #if {[llength $linkXDC] > 0 && [string match $topState "implement"]} {}
     if {[llength $linkXDC] > 0 } {
        set start_time [clock seconds]
        readXDC $linkXDC
        set end_time [clock seconds]
        log_time read_xdc $start_time $end_time 0 "Post link_design XDC files"
     } else {
        puts "\tInfo: No post-link_design XDC file specified for $impl"
     }

     if {$dcpLevel > 0} {
        set start_time [clock seconds]
        command "write_checkpoint -force $resultDir/${top}_link_design.dcp" "$resultDir/temp.log"
        set end_time [clock seconds]
        log_time write_checkpoint $start_time $end_time 0 "Post link_design checkpoint"
     }


     ##############################################
     # Write out final link_design DCP 
     ##############################################
     if {$verbose > 1} {
        set start_time [clock seconds]
        command "report_utilization -file $reportDir/${top}_utilization_link_design.rpt" "$resultDir/temp.log"
        set end_time [clock seconds]
        log_time report_utilization $start_time $end_time
     } 
     puts "\t#HD: Completed link_design"
     puts "\t##########################\n"

     if {$incr} {
        set imports {}
        foreach partition $partitions {
           lassign $partition module cell state name type level dcp
           #Process each partition that is not Top
           set moduleName [get_attribute module $module moduleName]
           if {![string match $moduleName $top]} {
              if {[string match $state "import"]} {
                 lappend imports $cell
              }
           }
        }
        if {[llength $imports]} {
           set start_time [clock seconds]
           command "read_checkpoint -incremental -only_reuse \{$imports\} $dcpDir/${top}_incremental.dcp" "$resultDir/read_incremental.log"
           set end_time [clock seconds]
           log_time read_checkpoint $start_time $end_time 0 "Read incremental Checkpoint for $imports"
        }
     }

     ##############################################
     # Run Methodology DRCs checks 
     ##############################################
     #Run methodology DRCs and catch any Critical Warnings or Error (module ruledeck quiet)
     if {$verbose > 1} {
        set start_time [clock seconds]
        check_drc $top methodology_checks 1
        set end_time [clock seconds]
        log_time report_drc $start_time $end_time 0 "methodology checks"
        #Run timing DRCs and catch any Critical Warnings or Error (module ruledeck quiet)
        set start_time [clock seconds]
        check_drc $top timing_checks 1
        set end_time [clock seconds]
        log_time report_drc $start_time $end_time 0 "timing_checks"
     }
  }

#COPIED from OLD ooc_impl.tcl.  STILL NEEDED?
  #if OOC Create timing budget constraints for the interface ports based on a percentage of the full period
  #if {$ooc && ${budget.create}} {
  #   set budgetXDC "${top}_ooc_budget.xdc"
  #   puts "\tWriting inteface budgets constraints to XDC file \"$xdcDir/$budgetXDC\"."
  #   command "::debug::gen_hd_timing_constraints -percent ${budget.percent} -file $xdcDir/$budgetXDC"
  #   puts "\tReading XDC file $xdcDir/$budgetXDC"
  #   command "read_xdc -mode out_of_context $xdcDir/$budgetXDC" "$resultDir/read_xdc_${ooc_inst}_budget.log"
  #} 
  ############################################################################################
  # Implementation steps: opt_design, place_design, phys_opt_design, route_design
  ############################################################################################
 if {$opt} {
   impl_step opt_design $top $opt_options  $opt_directive ${opt.pre}
  }

  if {$place} {
     #Report out all RM clocks for PR runs
     if {$pr} {
        foreach partition $partitions {
           lassign $partition module cell state name type level dcp
           if {![string match $cell $top]} {
              if {![llength $name]} {
                 set name [lindex [split $cell "/"] end]
              }
              get_rp_clocks $cell $reportDir/${name}_clocks.rpt
           }
        }
     }
     impl_step place_design $top $place_options  $place_directive ${place.pre}

     #### If Top-Down, write out XDCs 
     if {$td && $verbose > 0} {
        puts "\n\tWriting instance level XDC files."
        foreach partition $partitions {
           lassign $partition module cell state name type level dcp
           if {![string match $cell $top]} {
              if {![llength $name]} {
                 set name [lindex [split $cell "/"] end]
              }
              write_hd_xdc $name $cell $xdcDir
           }
        }
     }
  }

  if {$phys} {
     impl_step phys_opt_design $top $phys_options $phys_directive ${phys.pre}
  }

  if {$route} {
     impl_step route_design $top $route_options $route_directive ${route.pre}

     #Run report_timing_summary on final design
     set start_time [clock seconds]
     command "report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $reportDir/${top}_timing_summary.rpt" "$resultDir/temp.log"
     set end_time [clock seconds]
     log_time report_timing $start_time $end_time 0 "Timing Summary"
  
     #Run a final DRC that catches any Critical Warnings (module ruledeck quiet)
     set start_time [clock seconds]
     if {$ooc} {
        check_drc $top default ${drc.quiet}
     } else {
        check_drc $top bitstream_checks ${drc.quiet}
     }

     set end_time [clock seconds]
     log_time report_drc $start_time $end_time 0 "bistream_checks"
  
     #Report PR specific statitics for debug and analysis
     if {$pr} {
        command "debug::report_design_status" "$reportDir/${top}_design_status.rpt"
     }
  }

  if {$phys} {
     impl_step phys_opt_design $top $phys_options $phys_directive ${phys.pre}
  }
  
  if {![file exists $dcpDir]} {
     command "file mkdir $dcpDir"
  }   

  #Write out checkpoints for OOC implementations
  if {$iso || $ooc} {
     set pblock [get_pblocks -filter PARENT==ROOT]
     set dcp "$resultDir/${top}_route_design.dcp"
     command "file copy -force $dcp $dcpDir/${pblock}_${top}_route_design.dcp"
  }

  if {$ic || $pr} {
     #Write out cell checkpoints for all Partitions and create black_box 
     foreach partition $partitions {
        lassign $partition module cell state name type level dcp
        set moduleName [get_attribute module $module moduleName]
        if {![string match $moduleName $top] && ([string match $state "implement"] || [string match $topState "implement"])} {
           if {![llength $name]} {
              set name [lindex [split $cell "/"] end]
           }
           set start_time [clock seconds]
           set pblock [get_pblock -of [get_cells $cell]]
           #Pblock required to generate unique name. Do not write out cell DCP if not Pblock exists.
           if {[llength $pblock]} {
              set dcp "$resultDir/${pblock}_${module}_route_design.dcp"
              command "write_checkpoint -force -cell $cell $dcp" "$resultDir/temp.log"
              set end_time [clock seconds]
              log_time write_checkpoint $start_time $end_time 0 "Write cell checkpoint for $cell"
              command "file copy -force $dcp $dcpDir"
           } else {
              puts "Critical Warning: No pblock found for $cell. No cell-level DCP will be written out."
           }
           if {[string match $topState "implement"]} {
              set start_time [clock seconds]
              puts "\tCarving out $cell to be a black box \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
              command "update_design -cell $cell -black_box" "$resultDir/carve_$name.log"
              set end_time [clock seconds]
              log_time update_design $start_time $end_time 0 "Carve out (blackbox) $cell"
           }
        }
     }

     #Write out implemented version of Top for import in subsequent runs
     foreach partition $partitions {
        lassign $partition module cell state name type level dcp
        set moduleName [get_attribute module $module moduleName]
        set name [lindex [split $cell "/"] end]
        if {[string match $moduleName $top] && [string match $state "implement"]} {
           set start_time [clock seconds]
           puts "\tLocking $top and exporting results \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
           command "lock_design -level routing" "$resultDir/lock_design_$top.log"
           set end_time [clock seconds]
           log_time lock_design $start_time $end_time 0 "Lock placement and routing of $top"
           if {$pr} {
              set topDCP "$resultDir/${top}_static.dcp"
           } else {
              set topDCP "$resultDir/${top}_routed.dcp"
           }
           set start_time [clock seconds]
           command "write_checkpoint -force $topDCP" "$resultDir/temp.log"
           command "file copy -force $topDCP $dcpDir"
           set end_time [clock seconds]
           log_time write_checkpoint $start_time $end_time 0 "Write out locked Static checkpoint"
        }
     }
  }

  #For incremental flow, lock all implemented partitions and write out an "incremental" DCP
  if {$incr} {
     foreach partition $partitions {
        lassign $partition module cell state name type level dcp
        set moduleName [get_attribute module $module moduleName]
        if {![string match $moduleName $top]} {
           if {[string match $state "implement"]} {
              set start_time [clock seconds]
              puts "\t#HD: Locking $cell \[[clock format $start_time -format {%a %b %d %H:%M:%S %Y}]\]"
              command "lock_design -level routing $cell" "$resultDir/lock_design_incremental.log"
              set end_time [clock seconds]
           }
        }
     }
     set start_time [clock seconds]
     command "write_checkpoint -force $resultDir/${top}_incremental.dcp" "$resultDir/temp.log"
     command "file copy -force $resultDir/${top}_incremental.dcp $dcpDir"
     set end_time [clock seconds]
     log_time write_checkpoint $start_time $end_time 0 "Write out locked incremental checkpoint"
  }

  #For PR, don't write out bitstreams until after PR_VERIFY has run. See run.tcl
  if {$bitstream && !$pr} {
     impl_step write_bitstream $top $bitstream_options none ${bitstream.pre} $bitstream_settings
  }
  
  #For ISO flow, disable DRCs so that OOC bitstream can be written
  if {$iso && $bitstream} {
     command "set_property IS_ENABLED {false} \[get_drc_checks\]"
     impl_step write_bitstream $ooc_inst $bitstream_options none ${bitstream.pre}
     command "reset_drc_check \[get_drc_checks]"
  }

  #Turn path segmentation message back on if any partitions were a greybox.
  foreach partition $partitions {
     lassign $partition module cell state name type level dcp
     if {[string match $state "greybox"]} {
        command "reset_msg_config -quiet -id \"Constraints 18-514\" -suppress"
        command "reset_msg_config -quiet -id \"Constraints 18-515\" -suppress"
        command "reset_msg_config -quiet -id \"Constraints 18-402\" -suppress"
        break
     }
  }

  set impl_end [clock seconds]
  log_time final $impl_start $impl_end 
  log_data $impl $top

  command "close_project"
  command "puts \"#HD: Implementation $impl complete\\n\""
  close $rfh
  close $cfh
  close $wfh
}
