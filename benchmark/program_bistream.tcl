# connect to th eboard
connect

# program bitstream
switch $benchmark {
  "copy" {
    set bitstream ../bitstreams/V2_8CUs_Atomic_noSubInteger_240MHz.bit
  }
  "max" -
  "sum_power" -
  "sum_power_another" -
  "sum" {
    # set bitstream ../bitstreams/V1_8CUs.bit
    set bitstream ../bitstreams/V2_8CUs_Atomic_SubInteger_2AXI_220MHz.bit
    # set bitstream ../bitstreams/V2_8CUs_Atomic_2AXI_245MHz.bit
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
    # set bitstream ../bitstreams/V2_8CUs_SubInteger_2K_LMEM_240MHz.bit
    set bitstream ../bitstreams/V2_8CUs_Atomic_SubInteger_2AXI_220MHz.bit
  }
  "power_measurement" {
  }

  default {
    puts "Please select an appropriate bitstream to the $benchmark in program_bitstream.tcl"
    exit 1
  }
}


if { $benchmark == "power_measurement" } {
  # select the second ARM core as a target
  targets -set -filter {name =~ "ARM*#1"}
} else {
  fpga $bitstream
  # select the first ARM core as a target
  targets -set -filter {name =~ "ARM*#0"}
}

# reset the processor
rst -processor

# PS7 initialization
source .FGPU_V2_hw/ps7_init.tcl
ps7_init
ps7_post_config
