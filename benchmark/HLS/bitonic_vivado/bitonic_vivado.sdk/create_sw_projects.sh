#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
SCRIPT_DIR=`pwd`
BENCHMARK_DIR=`pwd`
cd $SCRIPT_DIR
benchmark="bitonic"
hdfFile="solution1.hdf"

# create hardware and bsp projects
xsct -quiet $SCRIPT_DIR/create_bsp.tcl $benchmark $hdfFile $BENCHMARK_DIR

# create an ARM/FGPU benchmark
xsct -quiet create_project.tcl $benchmark "ARM_CORE_0" $BENCHMARK_DIR
#replace the linking script
cp lscript.ld $BENCHMARK_DIR/$benchmark/src/lscript.ld

# delete some unnecessary files that are generated on project creation
rm $BENCHMARK_DIR/$benchmark/src/Xilinx.spec
rm $BENCHMARK_DIR/$benchmark/src/README.txt

./compile.sh $BENCHMARK_DIR/$benchmark
  

