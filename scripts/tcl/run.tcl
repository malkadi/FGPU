###############################################################
###   Main flow - Do Not Edit
###############################################################
#TODO: For now define the script version here... find a better home like the README or design.tcl?
#set scriptVer "2015.1"
#set vivado [exec which vivado]
#if {[llength $vivado]} {
#   set vivadoVer [version -short]
#   puts "INFO: Found Vivado version $vivadoVer"
   #Bypass version check if script version is not specified
#   if {[info exists scriptVer]} {
#      if {![string match ${scriptVer}* $vivadoVer]} {
#         set errMsg "ERROR: Specified script version $scriptVer does not match Vivado version $vivadoVer.\n"
#         set errMsg "Critical Warning: Specified script version $scriptVer does not match Vivado version $vivadoVer.\n"
#         append errMsg "Either change the version of scripts being used or run with the correct version of Vivado."
#         error $errMsg
#         puts "$errMsg"
#      }
#   }
#} else {
#   errMsg "Error: No version of Vivado found"
#   error $errMsg
#}

list_runs

#### Run Synthesis on any modules requiring synthesis
foreach module [get_modules synth] {
   synthesize $module $FGPU_ver $FREQ
}

#### Run Top-Down implementation before OOC
foreach impl [get_implementations "td.impl impl" &&] {
   #Override directives if directive file is specified
   if {[info exists useDirectives]} {
      puts "#HD: Overriding directives for implementation $impl"
      set_directives impl $impl
   }
   implement $impl
}

### Run OOC implementations
foreach impl [get_implementations "impl ooc.impl" &&]  {
   #Override directives if directive file is specified
   if {[info exists useDirectives]} {
      puts "#HD: Overriding directives for implementation $impl"
      set_directives impl $impl
   }
   implement $impl
}

### Run PR configurations
foreach config [sort_configurations [get_implementations "impl pr.impl" &&]]  {
   #Override directives if directive file is specified
   if {[info exists useDirectives]} {
      puts "#HD: Overriding directives for configuration $config"
      set_directives impl $config
   }
   implement $config
}

### Run Assembly and Flat implementations
foreach impl [get_implementations "impl !td.impl !pr.impl !ooc.impl" &&]  {
   #Override directives if directive file is specified
   if {[info exists useDirectives]} {
      puts "#HD: Overriding directives for implementation $impl"
      set_directives impl $impl
   }
   implement $impl
}

set configurations [get_implementations "pr.impl verify" &&]
### Run PR verify 
if {[llength  $configurations] > 1} {
   verify_configs $configurations
}

### Genearte PR bitstreams 
set configurations [get_implementations "pr.impl bitstream" &&]
if {[llength  $configurations] > 0} {   #### Set Tcl Params
   if {[info exists tclParams] && [llength $tclParams] > 0} {
      set_parameters $tclParams
   }
   generate_pr_bitstreams $configurations
}

close $RFH
close $CFH
close $WFH
