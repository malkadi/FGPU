#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
SCRIPT_DIR=`pwd`
cd ../benchmark
BENCHMARK_DIR=`pwd`
cd $SCRIPT_DIR

# delete some previously generated files or folders
rm -rf "../benchmark/.FGPU_hw"
rm -rf "../benchmark/.FGPU_bsp"
# .metadata has also information about existing projects in workspace
rm -rf "../benchmark/.metadata"
# create hardware and bsp projects
xsct $SCRIPT_DIR/create_bsp.tcl "FGPU" $BENCHMARK_DIR
