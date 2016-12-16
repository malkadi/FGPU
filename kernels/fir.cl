#include "FGPUlib.c"
#include "addsf3.c"
#include "mulsf3.c"
__kernel void fir_float(__global float *in, __global float *coeff, __global float *out, int filter_len) {
  int index = get_global_id(0);
  int i = 0;
  float acc = 0;
  do{
    acc += in[index+i] * coeff[i];
    i++;
  } while(i != filter_len);
  out[index] = acc;
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
__kernel void fir_half(__global short *in, __global short *coeff, __global short *out, int filter_len) {
  int index = get_global_id(0);
  int i = 0, acc = 0;
  do{
    acc += in[index+i] * coeff[i];
    i++;
  } while(i != filter_len);
  out[index] = acc;
}
__kernel void fir_half_improved(__global short2 *in, __global short2 *coeff, __global short2 *out, int filter_len) {
  uint index = get_global_id(0);
  int i = 0, acc1 = 0, acc2 = 0;
  do{
    acc1 += in[index+i].x * coeff[i].x;
    acc1 += in[index+i].y * coeff[i].y;
    acc2 += in[index+i].y * coeff[i].x;
    acc2 += in[index+i+1].x * coeff[i].y;
    i++;
  } while(i < filter_len/2);
  short2 res;
  res.x = acc1,
  res.y = acc2;
  out[index] = res;
}
__kernel void fir_byte(__global char *in, __global char *coeff, __global char *out, int filter_len) {
  int index = get_global_id(0);
  int i = 0, acc = 0;
  do{
    acc += in[index+i] * coeff[i];
    i++;
  } while(i != filter_len);
  out[index] = acc;
}
__kernel void fir_byte_improved(__global char4 *in, __global char4 *coeff, __global char4 *out, int filter_len) {
  int index = get_global_id(0);
  int i = 0, acc1 = 0, acc2 = 0, acc3 = 0, acc4 = 0;
  do{
    acc1 += in[index+i].x * coeff[i].x;
    acc1 += in[index+i].y * coeff[i].y;
    acc1 += in[index+i].z * coeff[i].z;
    acc1 += in[index+i].w * coeff[i].w;
    acc2 += in[index+i].y * coeff[i].x;
    acc2 += in[index+i].z * coeff[i].y;
    acc2 += in[index+i].w * coeff[i].z;
    acc2 += in[index+i+1].x * coeff[i].w;
    acc3 += in[index+i].z * coeff[i].x;
    acc3 += in[index+i].w * coeff[i].y;
    acc3 += in[index+i+1].x * coeff[i].z;
    acc3 += in[index+i+1].y * coeff[i].w;
    acc4 += in[index+i].w * coeff[i].x;
    acc4 += in[index+i+1].x * coeff[i].y;
    acc4 += in[index+i+1].y * coeff[i].z;
    acc4 += in[index+i+1].z * coeff[i].w;
    i++;
  } while(i != filter_len/4);
  out[index].x = acc1;
  out[index].y = acc2;
  out[index].z = acc3;
  out[index].w = acc4;
}
