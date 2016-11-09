#include "FGPUlib.c"

__kernel void copy_word(__global int *in, __global int *out) {
    int index = get_global_id(0);
    out[index] = in[index];
}

__kernel void copy_half(__global short *in, __global short *out) {
    int index = get_global_id(0);
    out[index] = in[index];
}

__kernel void copy_half_improved(__global ushort2 *in, __global ushort2 *out) {
    uint index = get_global_id(0);
    out[index] = in[index];
}

__kernel void copy_byte(__global char *in, __global char *out) {
    int index = get_global_id(0);
    out[index] = in[index];
}

__kernel void copy_byte_improved(__global uchar4 *in, __global uchar4 *out) {
    uint index = get_global_id(0);
    out[index] = in[index];
}
