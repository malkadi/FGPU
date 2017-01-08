#include "FGPUlib.c"
__kernel void matrix_multiply_hard_float(__global float* in1, __global float* in2, __global float* out){
  int row = get_global_id(1);
  int column = get_global_id(0);
  int len = get_global_size(0);
  int i = 0;
  float res = 0;
  do{
    res += in1[row*len+i] * in2[column+i*len];
    i++;
  } while( i != len);
  out[row*len+column] = res;
}
