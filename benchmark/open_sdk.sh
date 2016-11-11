#!/bin/sh

# Syntax: open_sdk project_name
# open xsct console to program bitstreams and download executables
# Use the command
#     source program_bitstream.ctl        (to programm the bitstream)
#     source download_elf.tcl             (to download the executable)
#     con                                 (to start execution)

cd `dirname $0`
source ./set_paths.sh
cd `dirname $0`/$1
xsct -interactive -eval "setws `dirname $0`/$1"
