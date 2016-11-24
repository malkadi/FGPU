# connect to th eboard
connect

# program bitstream
fpga ../../bitstreams/MicroBlaze_performance_180MHz.bit

# select the first ARM core as a target
targets -set -filter {name =~ "ARM*#0"}

# reset the processor
rst -processor

# PS7 initialization (necessary to have the clock for the MicroBlaze)
source ../MicroBlaze_hw/ps7_init.tcl
ps7_init
ps7_post_config
