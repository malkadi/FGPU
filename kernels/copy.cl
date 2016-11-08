#include "FGPUlib.c"

__kernel void copy_word(__global int *in, __global int *out) {
    int index = get_global_id(0);
    out[index] = in[index];
}

