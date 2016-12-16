#include "FGPUlib.c"
#include "addsf3.c"
__kernel void vec_add(__global int *in1, __global int *in2, __global int *out) {
    int index = get_global_id(0);
    out[index] = in1[index] + in2[index];
}
__kernel void vec_add_half(__global short *in1, __global short *in2, __global short *out) {
    int index = get_global_id(0);
    out[index] = in1[index] + in2[index];
}
__kernel void vec_add_half_improved(__global short2 *in1, __global short2 *in2, __global short2 *out) {
    int index = get_global_id(0);
    out[index] = in1[index] + in2[index];
}
__kernel void vec_add_byte(__global char *in1, __global char *in2, __global char *out) {
    int index = get_global_id(0);
    out[index] = in1[index] + in2[index];
}
__kernel void vec_add_byte_improved(__global char4 *in1, __global char4 *in2, __global char4 *out) {
    int index = get_global_id(0);
    out[index] = in1[index] + in2[index];
}
__kernel void add_float(__global float *in1, __global float *in2, __global float *out) {
  int indx = get_global_id(0);
  out[indx] = in1[indx] + in2[indx];
}
