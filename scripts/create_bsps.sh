#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
SCRIPT_DIR=`pwd`
cd ../benchmark
BENCHMARK_DIR=`pwd`
cd $SCRIPT_DIR

# create hardware and bsp projects
xsct -quiet $SCRIPT_DIR/create_bsp.tcl "FGPU_V2" V2.hdf $BENCHMARK_DIR
xsct -quiet $SCRIPT_DIR/create_bsp.tcl "FGPU_V1" V1.hdf $BENCHMARK_DIR
xsct -quiet $SCRIPT_DIR/create_bsp.tcl "MicroBlaze" MicroBlaze.hdf $BENCHMARK_DIR
xsct -quiet $SCRIPT_DIR/create_bsp.tcl "power_measurement" $BENCHMARK_DIR
