#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
SCRIPT_DIR=`pwd`
cd ../benchmark
BENCHMARK_DIR=`pwd`
cd $SCRIPT_DIR

#import all bsps and hardware projects into workspace
# xsct -eval "setws $BENCHMARK_DIR; importprojects $BENCHMARK_DIR/.FGPU_hw; importprojects $BENCHMARK_DIR/.FGPU_bsp"

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
      xsct create_MicroBlaze_project.tcl $BENCHMARK_DIR
      #replace the linking script
      cp lscript_MicroBlaze.ld $BENCHMARK_DIR/MicroBlaze/src/lscript.ld
    else
      # create an ARM/FGPU benchmark
      xsct create_project.tcl $benchmark $BENCHMARK_DIR
      #replace the linking script
      cp lscript.ld $BENCHMARK_DIR/$benchmark/src/
    fi
    # delete some unnecessary files that are generated on project creation
    rm $BENCHMARK_DIR/$benchmark/src/main.cc
    rm $BENCHMARK_DIR/$benchmark/src/Xilinx.spec
    rm $BENCHMARK_DIR/$benchmark/src/README.txt
    
    ./compile.sh $BENCHMARK_DIR/$benchmark
    
  done
else
  benchmark=`basename $1`
  BENCHMARK_DIR=`dirname $1`
  BENCHMARK_DIR=`realpath $BENCHMARK_DIR`
  
  if [ "${benchmark,,}" = "microblaze" ]; then
    # create MicroBlaze benchmark
    xsct create_MicroBlaze_project.tcl $BENCHMARK_DIR
    #replace the linking script
    cp lscript_MicroBlaze.ld $BENCHMARK_DIR/MicroBlaze/src/lscript.ld
  else
    # create an ARM/FGPU benchmark
    xsct create_project.tcl $benchmark $BENCHMARK_DIR
    #replace the linking script
    cp lscript.ld $BENCHMARK_DIR/$benchmark/src/
  fi

  # delete some unnecessary files that are generated on project creation
  rm $BENCHMARK_DIR/$benchmark/src/main.cc
  rm $BENCHMARK_DIR/$benchmark/src/Xilinx.spec
  rm $BENCHMARK_DIR/$benchmark/src/README.txt

  ./compile.sh $BENCHMARK_DIR/$benchmark
  
fi

