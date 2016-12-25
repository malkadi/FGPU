#include "FGPUlib.c"
#include "addsf3.c"
#include "mulsf3.c"
__kernel void xcorr(__global int *in1, __global int *in2, __global int *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int res = 0, i = 0;
  do{
    res += in1[i] * in2[i+offset];
    i++;
  } while( i != len);
  out[offset] = res;
}
__kernel void xcorr_improved(__global int *in1, __global int *in2, __global int *out) {
  int offset = get_global_id(0) << 2;
  int len = get_global_size(0) << 2;
  int i = 0;
  int res1 = 0, res2 = 0, res3 = 0, res4 = 0;
  do{
    res1 += in1[i] * in2[i+offset];
    res2 += in1[i] * in2[i+offset+1];
    res3 += in1[i] * in2[i+offset+2];
    res4 += in1[i] * in2[i+offset+3];
    i++;
  } while( i != len);
  out[offset] = res1;
  out[offset+1] = res2;
  out[offset+2] = res3;
  out[offset+3] = res4;
}
__kernel void xcorr_half(__global short *in1, __global short *in2, __global short *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int res = 0, i = 0;
  do{
    res += in1[i] * in2[i+offset];
    i++;
  } while( i != len);
  out[offset] = res;
}
__kernel void xcorr_half_improved(__global short2 *in1, __global short2 *in2, __global short2 *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int res1 = 0, res2 = 0, i = 0;
  do{
    res1 += in1[i].x * in2[i+offset].x;
    res1 += in1[i].y * in2[i+offset].y;
    res2 += in1[i].x * in2[i+offset].y;
    res2 += in1[i].y * in2[i+offset+1].x;
    i++;
  } while( i != len);
  out[offset].x = res1;
  out[offset].y = res2;
}
__kernel void xcorr_byte(__global char *in1, __global char *in2, __global char *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int res = 0, i = 0;
  do{
    res += in1[i] * in2[i+offset];
    i++;
  } while( i != len);
  out[offset] = res;
}
__kernel void xcorr_byte_improved(__global char4 *in1, __global char4 *in2, __global char4 *out) {
  int offset = get_global_id(0);
  int len = get_global_size(0);
  int res1 = 0, res2= 0, res3 = 0, res4 = 0, i = 0;
  do{
    res1 += in1[i].x * in2[i+offset].x;
    res1 += in1[i].y * in2[i+offset].y;
    res1 += in1[i].z * in2[i+offset].z;
    res1 += in1[i].w * in2[i+offset].w;
    res2 += in1[i].x * in2[i+offset].y;
    res2 += in1[i].y * in2[i+offset].z;
    res2 += in1[i].z * in2[i+offset].w;
    res2 += in1[i].w * in2[i+offset+1].x;
    res3 += in1[i].x * in2[i+offset].z;
    res3 += in1[i].y * in2[i+offset].w;
    res3 += in1[i].z * in2[i+offset+1].x;
    res3 += in1[i].w * in2[i+offset+1].y;
    res4 += in1[i].x * in2[i+offset].w;
    res4 += in1[i].y * in2[i+offset+1].x;
    res4 += in1[i].z * in2[i+offset+1].y;
    res4 += in1[i].w * in2[i+offset+1].z;
    i++;
  } while( i != len);
  out[offset].x = res1;
  out[offset].y = res2;
  out[offset].z = res3;
  out[offset].w = res4;
}
__kernel void xcorr_float(__global float *in1, __global float *in2, __global float *out) {
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
