#include "FGPUlib.c"
__kernel void xcorr_float_hard_float(__global float *in1, __global float *in2, __global float *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int i = 0;
  float res = 0;
  do{
    res += in1[i] * in2[i+offset];
    i++;
  } while( i != len);
  out[offset] = res;
}
