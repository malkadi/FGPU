set tclDir "../scripts/tcl"
set tclParams [list hd.visual 1] 
set bd_name     "bd_design"
set build_bd    1
set FGPU_ver    "2.1"
set FREQ        {250}
set_param general.maxThreads  4

####Input Directories
set srcDir      "./sources"
set rtlDir      "$srcDir/hdl"
set ipDir       "$srcDir/IPs"
set prjDir      "$srcDir/prj"
set xdcDir      "$srcDir/xdc"
set coreDir     "$srcDir/cores"
set netlistDir  "$srcDir/netlist"
set bdDir       ".srcs/sources_1/bd/$bd_name"

####Source required Tcl Procs
source $tclDir/design_utils.tcl -notrace
source $tclDir/log_utils.tcl -notrace
source $tclDir/synth_utils.tcl -notrace
source $tclDir/impl_utils.tcl -notrace
source $tclDir/pr_utils.tcl -notrace
source $tclDir/hd_floorplan_utils.tcl -notrace
source $tclDir/create_FGPU_block_design.tcl -notrace


##########  set FPGA part
set device        "xc7z045"
set package       "ffg900"
set speed         "-2"
set board         "xilinx.com:zc706:part0:1.2"
set part          $device$package$speed
check_part $part
# set part creates an in-memory project for the specified part
set_part $part
# set version 2.1 for static FGPU or 3.1 for partially reconfigurable FGPU


set_property BOARD_PART $board [current_project]
set_property target_language VHDL [current_project]



####flow control
set run.topSynth       1
set run.rmSynth        1
set run.opt            1
set run.phys           1
set run.prImpl         1
set run.prVerify       1
set run.writeBitstream 1
set run.writeHdf       1



####Report and DCP controls - values: 0-required min; 1-few extra; 2-all
set verbose      1
set dcpLevel     0

####Output Directories
set synthDir  "./synth"
set implDir   "./implement"
set dcpDir    "./checkpoint"
set bitDir    "./outputs"
set hdfDir    "./outputs"
set hdfName   "$hdfDir/V2_250MHz.hdf"


###############################################################
### Top Definition
###############################################################
set top "$bd_name\_wrapper"
set static "top"
add_module $static
set_attribute module $static moduleName     $top
set_attribute module $static top_level      1
set_attribute module $static ipRepo         $ipDir
# set_attribute module $static bd             [list $bdDir/$bd_name.bd]
set_attribute module $static vhdl           [list $bdDir/hdl/$bd_name\_wrapper.vhd]
# set_attribute module $static ip             [list [glob $ipDir/*.xcix]]
set_attribute module $static synth          ${run.topSynth}
set_attribute module $static synth_options  "-flatten_hierarchy rebuilt -fanout_limit 400 -keep_equivalent_registers \
                                            -resource_sharing off -no_lc -shreg_min_size 5 -fsm_extraction one_hot"
set_attribute module $static writeHdf       ${run.writeHdf} 

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "implement"
set config "Config_${state}" 
# set config "Config_${module1_variant1}_${module2_variant1}_${state}" 

add_implementation $config
set_attribute impl $config top              $top
set_attribute impl $config implXDC          [list $xdcDir/${top}.xdc]
set_attribute impl $config partitions       [list [list $static           $top          $state   ] ]
                                                 # [list $module1_variant1 $module1_inst implement] \
                                                 # [list $module2_variant1 $module2_inst implement] \
                                           ]
# set_attribute impl $config pr.impl         1
set_attribute impl $config pr.impl          0
set_attribute impl $config impl             ${run.prImpl} 
set_attribute impl $config opt              ${run.opt} 
set_attribute impl $config opt_directive    "ExploreWithRemap"
# set_attribute impl $config place_directive  "ExtraNetDelay_high"
set_attribute impl $config place_directive  "Explore"
set_attribute impl $config phys             ${run.phys} 
set_attribute impl $config phys_directive   "Explore"
set_attribute impl $config verify           ${run.prVerify} 
set_attribute impl $config route_directive  "Explore"
set_attribute impl $config bitstream        ${run.writeBitstream} 

########################################################################
### Task / flow portion
########################################################################
# Build the designs
source $tclDir/run.tcl

exit
