#include "FGPUlib.c"

__kernel void copy_word(__global int *in, __global int *out) {
    int index = get_global_id(0);
    out[index] = in[index];
}

__kernel void vec_add(__global int *in1, __global int *in2, __global int *out) {
    int index = get_global_id(0);
    out[index] = in1[index] + in2[index];
}

__kernel void vec_mul(__global int *in1, __global int *in2, __global int *out) {
    int index = get_global_id(0);
    out[index] = in1[index] * in2[index];
}

__kernel void fir(__global int *in, __global int *coeff, __global int *out, int filter_len) {
  int index = get_global_id(0);
  int i = 0, acc = 0;
  do{
    acc += in[index+i] * coeff[i];
    i++;
  } while(i != filter_len);
  out[index] = acc;
}

__kernel void matrix_multiply(__global int* in1, __global int* in2, __global int* out){
  int row = get_global_id(1);
  int column = get_global_id(0);
  int len = get_global_size(0);
  int i = 0, res = 0;
  do{
    res += in1[row*len+i] * in2[column+i*len];
    i++;
  } while( i != len);
  out[row*len+column] = res;
}

__kernel void cross_correlation(__global int *in1, __global int *in2, __global int *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int res = 0, i = 0;
  do{
    res += in1[i] * in2[i+offset];
    i++;
  } while( i != len);
  out[offset] = res;
}
__kernel void transpose(__global int *in, __global int *out) {
  int x = get_global_id(1);
  int y = get_global_id(0);
  int n = get_global_size(0);
  out[x*n+y] = in[y*n+x];
}
