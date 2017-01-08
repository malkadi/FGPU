# connect to th eboard
connect

# program bitstream
switch $benchmark {
  "edge_detection" {
    set bitstream ../bitstreams/V2_8CUs_fadd_fmul_fsqrt_uitofp_2AXI_185MHz.bit
  }
  "nbody" {
    set bitstream ../bitstreams/V2_4CUs_float_250MHz.bit
  }
  "vec_add" -
  "copy" {
    set bitstream ../bitstreams/V2_8CUs_fadd_2AXI.bit
  }
  "div" {
    # set bitstream ../bitstreams/V2_4CUs_fdiv_max.bit
    # set bitstream ../bitstreams/V2_8CUs_fdiv_225MHz.bit
    set bitstream ../bitstreams/V21_8CUs_fdiv_2AXI.bit
    # set bitstream ../bitstreams/V2_8CUs_fdiv_2AXI_215MHz.bit
  }
  "LUdecomposition" -
  "floydwarshall" -
  "fft" -
  "sum_power" -
  "sum_power_another" {
    # set bitstream ../bitstreams/V1_8CUs.bit
    set bitstream ../bitstreams/V2_8CUs_fadd_fmul.bit
    # set bitstream ../bitstreams/V2_8CUs_Atomic_2AXI_245MHz.bit
  }
  "vec_mul" {
    set bitstream ../bitstreams/V2_8CUs.bit
  }
  "max" -
  "bitonic" -
  "parallel_selection" -
  "sum" 
  {
    set bitstream ../bitstreams/V2_8CUs_2AXI.bit
  }
  "xcorr" -
  "fir" -
  "sharpen" -
  "matrix_multiply" -
  "median" 
  {
    # set bitstream ../bitstreams/V2_8CUs_SubInteger_2K_LMEM_240MHz.bit
    set bitstream ../bitstreams/V2_8CUs.bit
  }
  "power_measurement" {
  }
  "MicroBlaze" {
    set bitstream ../bitstreams/MicroBlaze_performance_180MHz.bit
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
  if { $benchmark == "MicroBlaze" } {
    targets -set -filter {name =~ "ARM*#1"}
  } else {
  targets -set -filter {name =~ "ARM*#0"}
  }
}

# reset the processor
rst -processor

# PS7 initialization
if {$benchmark == "MicroBlaze" } {
  source .MicroBlaze_hw/ps7_init.tcl
} else {
  source .FGPU_V2_hw/ps7_init.tcl
}
ps7_init
ps7_post_config
