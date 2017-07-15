#!/bin/bash

# This script creates and compile an FGPU design in Vivado 
# It can be called with the name of the design to be generated as a parameter. The default name is FGPU_V2
# e.g. ./implement.sh <design name>
# After a successful implementation, the script generates a bitstream in HW/outputs/<design name>.bit
# In addition, an hdf file to generate a HW SDK project is generated in HW/outputs/<design name>.bit

# The implemented FGPU features can be adjusted by editing  ../RTL/FGPU_definitions.sh
# The implementation settings, e.g. operation frequency of FGPU and place and route strategy, can be adjusted in tcl/implement_FGPU.tcl

source set_paths.sh

cd `dirname $0`/../HW

vivado -mode tcl -source "../scripts/tcl/implement_FGPU.tcl" -nojournal -nolog

if [ $# -eq 1 ]; then
  name=$1
else
  name="FGPU_V2"
fi

cp implement/Config_implement/bd_design_wrapper.bit outputs/$name.bit
cp -p ../RTL/FGPU_definitions.vhd outputs/$name.vhd
cp implement/Config_implement/reports/bd_design_wrapper_utilization_route_design.rpt outputs/$name\_utilization.rpt
chmod -x outputs/$name.vhd
