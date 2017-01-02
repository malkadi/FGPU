# connect to th eboard
connect

set bitstream solution1.bit


fpga $bitstream
# select the first ARM core as a target
targets -set -filter {name =~ "ARM*#0"}

# reset the processor
rst -processor

# PS7 initialization
source .$benchmark\_hw/ps7_init.tcl
ps7_init
ps7_post_config
