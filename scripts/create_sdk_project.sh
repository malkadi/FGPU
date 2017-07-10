#!/bin/sh

# arg0: path to project folder
# arg1: FGPU core version (V1 or V2). Default is V2.

if [ $# -eq 2 ]; then 
  VERSION="$2"
else
  VERSION="V2"
fi

cd `dirname $0`
source ./set_paths.sh
SCRIPT_DIR=`pwd`
cd ../benchmark
BENCHMARK_DIR=`pwd`
cd $SCRIPT_DIR

if [ $# -eq 0 ]; then
  for benchmarkPath in $(find $BENCHMARK_DIR -maxdepth 1 -mindepth 1 -type d) # iterate on all folders in benchmark folder
  do
    benchmark=`basename $benchmarkPath`
    if [ ${benchmark:0:1} = "." ]; then # ignore hidden directories
      continue;
    fi
    echo "Building" $benchmark

    if [ $benchmark = "MicroBlaze" ]; then
      # create MicroBlaze benchmark
      xsct -quiet create_MicroBlaze_project.tcl $BENCHMARK_DIR
      #replace the linking script
      cp lscript/lscript_MicroBlaze.ld $BENCHMARK_DIR/MicroBlaze/src/lscript.ld
    elif [ $benchmark = "power_measurement" ]; then
      # create power_measurement project
      xsct -quiet create_sdk_project.tcl $benchmark $VERSION "ARM_CORE_1" $BENCHMARK_DIR
      #replace the linking script
      cp lscript/lscript_power_measurement.ld $BENCHMARK_DIR/$benchmark/src/lscript.ld
    else
      # create an ARM/FGPU benchmark
      xsct -quiet create_sdk_project.tcl $benchmark $VERSION "ARM_CORE_0" $BENCHMARK_DIR
      #replace the linking script
      cp lscript/lscript.ld $BENCHMARK_DIR/$benchmark/src/
    fi
    # delete some unnecessary files that are generated on project creation
    rm -f $BENCHMARK_DIR/$benchmark/src/main.cc
    rm -f $BENCHMARK_DIR/$benchmark/src/Xilinx.spec
    rm -f $BENCHMARK_DIR/$benchmark/src/README.txt
    
    ./compile.sh $BENCHMARK_DIR/$benchmark
    
  done
else
  benchmark=`basename $1`
  echo "Building" $benchmark

  if [ "$benchmark" = "MicroBlaze" ]; then
    # create MicroBlaze benchmark
    xsct -quiet create_MicroBlaze_project.tcl $BENCHMARK_DIR
    #replace the linking script
    cp lscript/lscript_MicroBlaze.ld $BENCHMARK_DIR/MicroBlaze/src/lscript.ld
  elif [ "$benchmark" = "power_measurement" ]; then
    # create power_measurement project
    xsct -quiet create_sdk_project.tcl $benchmark $VERSION "ARM_CORE_1" $BENCHMARK_DIR
    #replace the linking script
    cp lscript/lscript_power_measurement.ld $BENCHMARK_DIR/$benchmark/src/lscript.ld
  else
    # create an ARM/FGPU benchmark
    xsct -quiet create_sdk_project.tcl $benchmark $VERSION "ARM_CORE_0" $BENCHMARK_DIR
    #replace the linking script
    cp lscript/lscript.ld $BENCHMARK_DIR/$benchmark/src/lscript.ld
  fi

  # delete some unnecessary files that are generated on project creation
  rm -f $BENCHMARK_DIR/$benchmark/src/main.cc
  rm -f $BENCHMARK_DIR/$benchmark/src/Xilinx.spec
  rm -f $BENCHMARK_DIR/$benchmark/src/README.txt

  ./compile.sh $BENCHMARK_DIR/$benchmark
  
fi

