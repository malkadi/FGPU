#!/bin/sh


# This script creates and compile an FGPU design in Vivado with partial configuration support
# e.g. ./implement_V3.sh <design name>
# NOTE: Generating the static and partial bitstreams is not fully automated.
#       The script in scripts/tcl/implement_FGPU_V3.tcl should be accordingly modified.
#       The designer should be familiar with the tcl-based partial configuration tool flow of Xilinx to be able to use this file.

# The implemented FGPU features can be adjusted by editing  ../RTL/FGPU_definitions.sh
# The implementation settings, e.g. operation frequency of FGPU and place and route strategy, can be adjusted in tcl/implement_FGPU_V3.tcl

source set_paths.sh
cd `dirname $0`

vivado -mode tcl -source "tcl/implement_FGPU_V3.tcl" -nojournal -nolog
# vivado -mode tcl -source "tcl/prepare_floorplan.tcl" -nojournal -nolog
