#!/bin/bash


# This script creates all HW and BSP projects in Xilinx SDK to run the FGPU benchmarks


cd `dirname $0`
source ./set_paths.sh
SCRIPTS_DIR=`pwd`
cd ../benchmark
BENCHMARK_DIR=`pwd`
cd $SCRIPTS_DIR

LOG_FILE=$SCRIPTS_DIR"/create_sdk_bsps.log"
>$LOG_FILE


echo "Creating FGPU V2 HW & BSP SDK projects!"
xsct -quiet $SCRIPTS_DIR/create_sdk_bsp.tcl "FGPU_V2" hdf/V2.hdf $BENCHMARK_DIR &>> $LOG_FILE
a=$?
if [ $a != 0 ]; then
  echo "Creating FGPU V2 HW & BSP SDK projects failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi

echo "Creating FGPU V1 HW & BSP SDK projects!"
xsct -quiet $SCRIPTS_DIR/create_sdk_bsp.tcl "FGPU_V1" hdf/V1.hdf $BENCHMARK_DIR &>> $LOG_FILE
a=$?
if [ $a != 0 ]; then
  echo "Creating FGPU V1 HW & BSP SDK projects failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi

echo "Creating MicroBlaze HW & BSP SDK projects!"
xsct -quiet $SCRIPTS_DIR/create_sdk_bsp.tcl "MicroBlaze" hdf/MicroBlaze.hdf $BENCHMARK_DIR &>> $LOG_FILE
a=$?
if [ $a != 0 ]; then
  echo "Creating MicroBlaze HW & BSP SDK projects failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi

echo "Creating BSP SDK project for power measurement!"
xsct -quiet $SCRIPTS_DIR/create_sdk_bsp.tcl "power_measurement" $BENCHMARK_DIR &>> $LOG_FILE
a=$?
if [ $a != 0 ]; then
  echo "Creating BSP SDK project for power measurement failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi
