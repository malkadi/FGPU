set tclDir "./tcl"
set tclParams [list hd.visual 1] 
set bd_name     "bd_design"
set build_bd    1
# set version 2.1 for static FGPU or 3.1 for partially reconfigurable FGPU
set FGPU_ver    "3.1"
set FREQ        {250}
# set_param general.maxThreads  4

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


set_property BOARD_PART $board [current_project]
set_property target_language VHDL [current_project]

set synthOptions      " -flatten_hierarchy rebuilt -fanout_limit 400 -keep_equivalent_registers \
                        -resource_sharing off -no_lc -shreg_min_size 5 -fsm_extraction one_hot"

####flow control
set run.topSynth       0
set run.rmSynth        0
set run.opt            1
set run.phys           1
set run.prImpl         1
set run.prVerify       1
set run.writeBitstream 1
set run.writeHdf       1



####Report and DCP controls - values: 0-required min; 1-few extra; 2-all
set verbose      1
set dcpLevel     1

####Output Directories
set synthDir  "./synth"
set implDir   "./implement"
set dcpDir    "./checkpoint"
set bitDir    "./outputs"
set hdfDir    "./outputs"
set hdfName   "$hdfDir/FGPU_V3_nbody.hdf"


###############################################################
### Top Definition
###############################################################
set top "$bd_name\_wrapper"
set static "top"
add_module $static
set_attribute module $static moduleName     $top
set_attribute module $static top_level      1
if {!$build_bd} {
  set_attribute module $static bd             [list $bdDir/$bd_name.bd]
}
set_attribute module $static vhdl           [list $bdDir/hdl/$bd_name\_wrapper.vhd]
set_attribute module $static ipRepo         $ipDir
set_attribute module $static ip             [list [glob $ipDir/*.xcix]]
set_attribute module $static synth          ${run.topSynth}
set_attribute module $static synth_options  $synthOptions
set_attribute module $static writeHdf       ${run.writeHdf} 

# ####################################################################
# ### RP Module Definitions
# ####################################################################
set prModule "float_units"

set variant_fadd_fsub "float_units_fadd_fsub"
set variant $variant_fadd_fsub
add_module $variant
set_attribute module $variant moduleName    $prModule
set_attribute module $variant vhdl          [list $rtlDir/$variant.vhd $rtlDir/FGPU_definitions.vhd]
set_attribute module $variant synth         ${run.rmSynth}
set_attribute module $variant synth_options $synthOptions
set_attribute module $variant ipRepo         $ipDir
set_attribute module $variant ip             [list $ipDir/fadd_fsub.xcix]

set variant_fmul "float_units_fmul"
set variant $variant_fmul
add_module $variant
set_attribute module $variant moduleName    $prModule
set_attribute module $variant vhdl          [list $rtlDir/$variant.vhd $rtlDir/FGPU_definitions.vhd]
set_attribute module $variant synth         ${run.rmSynth}
set_attribute module $variant synth_options $synthOptions
set_attribute module $variant ipRepo         $ipDir
set_attribute module $variant ip             [list $ipDir/fmul.xcix]

set variant_fdiv "float_units_fdiv"
set variant $variant_fdiv
add_module $variant
set_attribute module $variant moduleName    $prModule
set_attribute module $variant vhdl          [list $rtlDir/$variant.vhd $rtlDir/FGPU_definitions.vhd]
set_attribute module $variant synth         ${run.rmSynth}
set_attribute module $variant synth_options $synthOptions
set_attribute module $variant ipRepo         $ipDir
set_attribute module $variant ip             [list $ipDir/fdiv.xcix]

set variant_fsqrt "float_units_fsqrt"
set variant $variant_fsqrt
add_module $variant
set_attribute module $variant moduleName    $prModule
set_attribute module $variant vhdl          [list $rtlDir/$variant.vhd $rtlDir/FGPU_definitions.vhd]
set_attribute module $variant synth         ${run.rmSynth}
set_attribute module $variant synth_options $synthOptions
set_attribute module $variant ipRepo         $ipDir
set_attribute module $variant ip             [list $ipDir/fsqrt.xcix]

# We care about the case where there are 4CUs
set inst_1 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[0].compute_unit_inst/CV_inst/float_units_inst.float_inst"
set inst_2 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[1].compute_unit_inst/CV_inst/float_units_inst.float_inst"
set inst_3 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[2].compute_unit_inst/CV_inst/float_units_inst.float_inst"
set inst_4 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[3].compute_unit_inst/CV_inst/float_units_inst.float_inst"

########################################################################
### Configuration (Implementation) Definition - DIV
########################################################################
# set state "implement"
# set config "Config_${variant_fdiv}_${state}" 
#
# add_implementation $config
# set_attribute impl $config top              $top
# set_attribute impl $config implXDC          [list $xdcDir/${top}.xdc $xdcDir/fplan_2.xdc]
# set_attribute impl $config partitions       [list [list $static           $top      $state   ]  \
#                                                   [list $variant_fdiv     $inst_1   implement]  \
#                                                   [list $variant_fdiv     $inst_2   implement]  \
#                                                   [list $variant_fdiv     $inst_3   implement]  \
#                                                   [list $variant_fdiv     $inst_4   implement]  \
#                                             ]
# set_attribute impl $config pr.impl          1
# set_attribute impl $config impl             ${run.prImpl} 
# set_attribute impl $config opt              ${run.opt} 
# set_attribute impl $config opt_directive    "ExploreWithRemap"
# set_attribute impl $config place_directive  "Explore"
# set_attribute impl $config phys             ${run.phys} 
# set_attribute impl $config phys_directive   "Explore"
# set_attribute impl $config verify           ${run.prVerify} 
# set_attribute impl $config bitstream        ${run.writeBitstream} 
########################################################################
### Configuration (Implementation) Definition - MUL
########################################################################
# set state "import"
# set config "Config_${variant_fmul}_${state}" 
#
# add_implementation $config
# set_attribute impl $config top              $top
# set_attribute impl $config implXDC          [list $xdcDir/${top}.xdc $xdcDir/fplan_2.xdc]
# set_attribute impl $config partitions       [list [list $static           $top      $state   ]  \
#                                                   [list $variant_fmul     $inst_1   implement]  \
#                                                   [list $variant_fmul     $inst_2   implement]  \
#                                                   [list $variant_fmul     $inst_3   implement]  \
#                                                   [list $variant_fmul     $inst_4   implement]  \
#                                             ]
# set_attribute impl $config pr.impl          1
# set_attribute impl $config impl             ${run.prImpl} 
# set_attribute impl $config verify           ${run.prVerify} 
# set_attribute impl $config bitstream        ${run.writeBitstream} 
########################################################################
### Configuration (Implementation) Definition - MUL
########################################################################
set state "import"
set config "Config_${variant_fadd_fsub}_${state}" 

add_implementation $config
set_attribute impl $config top              $top
set_attribute impl $config implXDC          [list $xdcDir/${top}.xdc $xdcDir/fplan_2.xdc]
set_attribute impl $config partitions       [list [list $static           $top      $state   ]  \
                                                  [list $variant_fadd_fsub     $inst_1   implement]  \
                                                  [list $variant_fadd_fsub     $inst_2   implement]  \
                                                  [list $variant_fadd_fsub     $inst_3   implement]  \
                                                  [list $variant_fadd_fsub     $inst_4   implement]  \
                                            ]
set_attribute impl $config pr.impl          1
set_attribute impl $config impl             ${run.prImpl} 
set_attribute impl $config verify           ${run.prVerify} 
set_attribute impl $config bitstream        ${run.writeBitstream} 
########################################################################
### Configuration (Implementation) Definition - MUL
########################################################################
set state "import"
set config "Config_${variant_fsqrt}_${state}" 

add_implementation $config
set_attribute impl $config top              $top
set_attribute impl $config implXDC          [list $xdcDir/${top}.xdc $xdcDir/fplan_2.xdc]
set_attribute impl $config partitions       [list [list $static           $top      $state   ]  \
                                                  [list $variant_fsqrt     $inst_1   implement]  \
                                                  [list $variant_fsqrt     $inst_2   implement]  \
                                                  [list $variant_fsqrt     $inst_3   implement]  \
                                                  [list $variant_fsqrt     $inst_4   implement]  \
                                            ]
set_attribute impl $config pr.impl          1
set_attribute impl $config impl             ${run.prImpl} 
set_attribute impl $config verify           ${run.prVerify} 
set_attribute impl $config bitstream        ${run.writeBitstream} 
########################################################################
### Task / flow portion
########################################################################
# Build the designs

source $tclDir/run.tcl

# open synthesized design and set all reconfigurable modules to fdiv and save
# open_checkpoint $synthDir/$static/$bd_name\_wrapper_synth.dcp
#
# read_checkpoint -cell $inst_1 $synthDir/$variant_fdiv/$prModule\_synth.dcp
# read_checkpoint -cell $inst_2 $synthDir/$variant_fdiv/$prModule\_synth.dcp
# read_checkpoint -cell $inst_3 $synthDir/$variant_fdiv/$prModule\_synth.dcp
# read_checkpoint -cell $inst_4 $synthDir/$variant_fdiv/$prModule\_synth.dcp
#
# set_property HD.RECONFIGURABLE 1 [get_cells $inst_1]
# set_property HD.RECONFIGURABLE 1 [get_cells $inst_2]
# set_property HD.RECONFIGURABLE 1 [get_cells $inst_3]
# set_property HD.RECONFIGURABLE 1 [get_cells $inst_4]
#
# write_checkpoint ./$dcpDir/all_div.dcp

exit
