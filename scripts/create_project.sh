#!/bin/sh
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
      cp lscript_MicroBlaze.ld $BENCHMARK_DIR/MicroBlaze/src/lscript.ld
    else
      # create an ARM/FGPU benchmark
      xsct -quiet create_project.tcl $benchmark V2 $BENCHMARK_DIR
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

  if [ "$benchmark" = "MicroBlaze" ]; then
    # create MicroBlaze benchmark
    xsct -quiet create_MicroBlaze_project.tcl $BENCHMARK_DIR
    #replace the linking script
    cp lscript_MicroBlaze.ld $BENCHMARK_DIR/MicroBlaze/src/lscript.ld
  elif [ $# -eq 2 ]; then 
    # create an ARM/FGPU benchmark
    if [ "$2" = "V1" ]; then
      xsct -quiet create_project.tcl $benchmark V1 $BENCHMARK_DIR
    else
      xsct -quiet create_project.tcl $benchmark V2 $BENCHMARK_DIR
    fi
  else
    # create an ARM/FGPU benchmark
    xsct -quiet create_project.tcl $benchmark V2 $BENCHMARK_DIR
  fi
  #replace the linking script
  cp lscript.ld $BENCHMARK_DIR/$benchmark/src/

  # delete some unnecessary files that are generated on project creation
  rm $BENCHMARK_DIR/$benchmark/src/main.cc
  rm $BENCHMARK_DIR/$benchmark/src/Xilinx.spec
  rm $BENCHMARK_DIR/$benchmark/src/README.txt

  ./compile.sh $BENCHMARK_DIR/$benchmark
  
fi

