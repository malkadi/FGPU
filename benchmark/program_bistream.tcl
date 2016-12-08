# connect to th eboard
connect

# program bitstream
switch $benchmark {
  "sum_atomic" -
  "copy" {
    set bitstream ../bitstreams/V2_8CUs_Atomic_noSubInteger_240MHz.bit
  }
  "vec_add" -
  "vec_mul" -
  "xcorr" -
  "fir" -
  "sharpen" -
  "matrix_multiply" -
  "median" -
  "parallel_selection" -
  "compass_edge_detection" {
    set bitstream ../bitstreams/V2_8CUs_SubInteger_2K_LMEM_240MHz.bit
  }

  default {
    puts "Please select an appropriate bitstream to the $benchmark in program_bitstream.tcl"
    exit 1
  }
}

fpga $bitstream


# select the first ARM core as a target
targets -set -filter {name =~ "ARM*#0"}

# reset the processor
rst -processor

# PS7 initialization
source ../.FGPU_hw/ps7_init.tcl
ps7_init
ps7_post_config
