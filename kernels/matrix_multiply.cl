#include "FGPUlib.c"
#include "addsf3.c"
#include "mulsf3.c"
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
__kernel void matrix_multiply_half(__global short* in1, __global short* in2, __global short* out){
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
__kernel void matrix_multiply_half_improved(__global short2 *in1, __global short* in2, __global short* out){
  int row = get_global_id(1);
  int column = get_global_id(0);
  int len = get_global_size(0);
  int i = 0, k = 0, res = 0;
  do{
    res += in1[row*len/2+k].x * in2[column+i*len];
    i++;
    res += in1[row*len/2+k].y * in2[column+i*len];
    i++;
    k++;
  } while( i != len);
  out[row*len+column] = res;
}
__kernel void matrix_multiply_byte(__global char* in1, __global char* in2, __global char* out){
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
__kernel void matrix_multiply_byte_improved(__global char4 *in1, __global char* in2, __global char* out){
  int row = get_global_id(1);
  int column = get_global_id(0);
  int len = get_global_size(0);
  int i = 0, k = 0, res = 0;
  do{
    res += in1[row*len/4+k].x * in2[column+i*len];
    i++;
    res += in1[row*len/4+k].y * in2[column+i*len];
    i++;
    res += in1[row*len/4+k].z * in2[column+i*len];
    i++;
    res += in1[row*len/4+k].w * in2[column+i*len];
    i++;
    k++;
  } while( i != len);
  out[row*len+column] = res;
}
__kernel void matrix_multiply_float(__global float* in1, __global float* in2, __global float* out){
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
