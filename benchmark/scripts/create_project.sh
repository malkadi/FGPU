#!/bin/sh
cd `dirname $0`
source ./set_paths.sh


rm -rf "../FGPU_hw"
rm -rf "../FGPU_bsp"
rm -rf "../SDK.log"
rm -rf "../.metadata"

if [ $# -eq 0 ]; then
  # create hardware and bsp projects
  xsct create_bsp.tcl "FGPU"
  
  for benchmarkDir in $(find .. -maxdepth 1 -mindepth 1 -type d) # iterate on all folders in benchmark folder
  do
    dirNameLen=${#benchmarkDir}
    echo $benchmarkDir
    if [ ${benchmarkDir:2:1} = "." ]; then # e.g. check x in "./xyz"
      # ignore hidden directories (Xilinx creates .Xil when compiling with the SDK)
      continue;
    fi
    if [ ${benchmarkDir:$dirNameLen-4:4} = "_bsp" ] || [ ${benchmarkDir:$dirNameLen-3:3} = "_hw" ] || [ $benchmarkDir = "./scripts" ]; then 
      # skips the bsp & hw projects and the scripts folder
      continue
    fi
    benchmark=${benchmarkDir:2:$dirNameLen-2}

    if [ $benchmarkDir = "./MicroBlaze" ]; then
      # create MicroBlaze benchmark
      xsct scripts/create_MicroBlaze_project.tcl $benchmark
      #replace the linking script
      cp scripts/lscript_MicroBlaze.ld $benchmark/src/lscript.ld
    else
      # create ARM/FGPU benchmarks
      xsct create_project.tcl $benchmark
      #replace the linking script
      cp scripts/lscript.ld $benchmark/src/
    fi
    # delete some unnecessary files that are generated on project creation
    rm $benchmark/src/main.cc
    rm $benchmark/src/Xilinx.spec
    rm $benchmark/src/README.txt
    
    ./compile.sh $benchmark
    
  done
else
  benchmark=$1
  benchmarkLen=${#benchmark}
  #remove slash from the end of the name if existed
  if [ ${benchmark:$benchmarkLen-1:1} = "/" ]; then 
    benchmark=${benchmark:0:$benchmarkLen-1}
  fi
  
  if [ "${benchmark,,}" = "microblaze" ]; then
    benchmark="MicroBlaze"
    rm -rf ../MicroBlaze_bsp
    rm -rf ../MicroBlaze_hw
    # create MicroBlaze benchmark
    xsct create_MicroBlaze_project.tcl ../MicroBlaze
    #replace the linking script
    cp lscript_MicroBlaze.ld ../MicroBlaze/src/
  else
    # create hardware and bsp projects
    xsct create_bsp.tcl "FGPU"
    xsct create_project.tcl $benchmark
    #replace the linking script
    cp lscript.ld ../$benchmark/src/
  fi

  # delete some unnecessary files that are generated on project creation
  rm ../$benchmark/src/main.cc
  rm ../$benchmark/src/Xilinx.spec
  rm ../$benchmark/src/README.txt

  ./compile.sh $benchmark
  
fi

