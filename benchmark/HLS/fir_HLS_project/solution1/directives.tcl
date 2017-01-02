############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_loop_tripcount -min 1024 -max 1024 "fir/loop1"
set_directive_loop_tripcount -min 12 -max 12 "fir/loop2"
set_directive_pipeline "fir/loop1"
set_directive_pipeline "fir/loop2"
set_directive_pipeline "fir_local/loop_local1"
set_directive_pipeline "fir_local/loop_local2"
set_directive_pipeline "fir/loop3"
set_directive_dataflow "fir"
