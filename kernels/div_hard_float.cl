#include "FGPUlib.c"
__kernel void div_hard_float(__global float *in1, __global float *out, float val) {
  int x = get_global_id(0);
  out[x] = in1[x]/val;
}
