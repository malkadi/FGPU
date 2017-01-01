#include "FGPUlib.c"
__kernel void fir_hard_float(__global float *in, __global float *coeff, __global float *out, int filter_len) {
  int index = get_global_id(0);
  int i = 0;
  float acc = 0;
  do{
    acc += in[index+i] * coeff[i];
    i++;
  } while(i != filter_len);
  out[index] = acc;
}
