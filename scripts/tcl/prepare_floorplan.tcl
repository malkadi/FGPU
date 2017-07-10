
###### All the following variable values are taken from implement_FGPU_V3.tcl
set synthDir  "./synth"
set static "top"
set bd_name     "bd_design"
set prModule "float_units"
set variant_fdiv "float_units_fdiv"
set dcpDir    "./checkpoint"

# We care about the case where there are 4CUs
set inst_1 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[0].compute_unit_inst/CV_inst/float_units_inst.float_inst"
set inst_2 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[1].compute_unit_inst/CV_inst/float_units_inst.float_inst"
set inst_3 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[2].compute_unit_inst/CV_inst/float_units_inst.float_inst"
set inst_4 "$bd_name\_i/FGPU_0/U0/uut/compute_units_i[3].compute_unit_inst/CV_inst/float_units_inst.float_inst"


open_checkpoint $synthDir/$static/$bd_name\_wrapper_synth.dcp

read_checkpoint -cell $inst_1 $synthDir/$variant_fdiv/$prModule\_synth.dcp
read_checkpoint -cell $inst_2 $synthDir/$variant_fdiv/$prModule\_synth.dcp
read_checkpoint -cell $inst_3 $synthDir/$variant_fdiv/$prModule\_synth.dcp
read_checkpoint -cell $inst_4 $synthDir/$variant_fdiv/$prModule\_synth.dcp

set_property HD.RECONFIGURABLE 1 [get_cells $inst_1]
set_property HD.RECONFIGURABLE 1 [get_cells $inst_2]
set_property HD.RECONFIGURABLE 1 [get_cells $inst_3]
set_property HD.RECONFIGURABLE 1 [get_cells $inst_4]

write_checkpoint ./$dcpDir/all_div.dcp
