#!/bin/sh

# Syntax: open_sdk project_name
# open xsct console to program bitstreams and download executables
# Use the command
#     source program_bitstream.ctl        (to programm the bitstream)
#     source download_elf.tcl             (to download the executable)
#     con                                 (to start execution)
if [ "$#" -ne 1 ];then
  echo "Name of benchmark is missing!"
  exit 1
fi

cd `dirname $0`
source ../scripts/set_paths.sh
WORKSPACE=`dirname $0`
benchmark=`basename $1`
xsct -quiet -interactive -eval "setws $WORKSPACE; set benchmark $benchmark"
