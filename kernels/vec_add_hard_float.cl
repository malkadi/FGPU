#include "FGPUlib.c"
__kernel void add_hard_float(__global float *in1, __global float *in2, __global float *out) {
  int indx = get_global_id(0);
  out[indx] = in1[indx] + in2[indx];
}
