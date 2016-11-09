#!/bin/sh
cd `dirname $0`
source ./set_paths.sh

rm -rf "FGPU_hw"
rm -rf "FGPU_bsp"
rm -rf "SDK.log"
rm -rf ".metadata"

xsct create_bsp.tcl "FGPU"

if [ $# -eq 0 ]; then
  for benchmarkDir in $(find -maxdepth 1 -mindepth 1 -type d) # iterate on all subfloders
  do
    dirNameLen=${#benchmarkDir}
    if [ ${benchmarkDir:2:1} = "." ]; then # e.g. check x in "./xyz"
      # ignore hidden directories (Xilinx creates .Xil when compiling with the SDK)
      continue;
    fi
    if [ ${benchmarkDir:$dirNameLen-4:4} = "_bsp" ] || [ ${benchmarkDir:$dirNameLen-3:3} = "_hw" ] || [ $benchmarkDir = "./scripts" ]; then 
      # skips the bsp & hw projects and the scripts folder
      continue
    fi
    benchmark=${benchmarkDir:2:$dirNameLen-2}

    xsct create_project.tcl $benchmark
    cp scripts/lscript.ld $benchmark/src/
  done
else
  benchmark=$1

  xsct create_project.tcl $benchmark
  cp scripts/lscript.ld $benchmark/src/
  
fi

