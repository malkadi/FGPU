############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_pipeline "bitonic/loop1"
set_directive_pipeline "bitonic/loop2"
set_directive_pipeline "bitonic/loop3"
set_directive_loop_tripcount -min 12 -max 12 "bitonic/loop1"
set_directive_loop_tripcount -min 12 -max 12 "bitonic/loop2"
set_directive_loop_tripcount -min 2048 -max 2048 "bitonic/loop3"
