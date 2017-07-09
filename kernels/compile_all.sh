#!/bin/bash
cd `dirname $0`

# compiler_outputs/clean.sh
COMPILE="./compile_and_log.sh"
# COMPILE="./compile.sh"

$COMPILE bitonic.cl
$COMPILE bitonic_hard_float.cl -hard-float
$COMPILE copy.cl
$COMPILE div.cl
$COMPILE div_hard_float.cl -hard-float
$COMPILE edge_detection.cl -hard-float
$COMPILE fft.cl
$COMPILE fft_hard_float.cl -hard-float
$COMPILE fir.cl
$COMPILE fir_hard_float.cl -hard-float
$COMPILE floydwarshall.cl
$COMPILE floydwarshall_hard_float.cl -hard-float
$COMPILE ludecomposition.cl
$COMPILE ludecomposition_hard_float.cl -hard-float
$COMPILE matrix_multiply.cl
$COMPILE matrix_multiply_hard_float.cl -hard-float
$COMPILE max.cl
$COMPILE max_hard_float.cl -hard-float
$COMPILE median.cl
$COMPILE nbody.cl -hard-float
$COMPILE parallel_selection.cl
$COMPILE parallel_selection_hard_float.cl -hard-float
$COMPILE sharpen.cl
$COMPILE sum.cl
$COMPILE sum_hard_float.cl -hard-float
$COMPILE sum_power.cl
$COMPILE sum_power_hard_float.cl -hard-float
$COMPILE vec_add.cl
$COMPILE vec_add_hard_float.cl -hard-float
$COMPILE vec_mul.cl
$COMPILE vec_mul_hard_float.cl -hard-float
$COMPILE xcorr.cl
$COMPILE xcorr_hard_float.cl -hard-float
