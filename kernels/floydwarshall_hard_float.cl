#include "FGPUlib.c"

__kernel void floydWarshallPass_hard_float(__global float *mat, unsigned pass)
{
    unsigned i = get_global_id(0);
    unsigned j = get_global_id(1);
    unsigned size = get_global_size(0);

    float oldWeight = mat[j*size + i];
    float tempWeight = (mat[j*size + pass] + mat[pass*size + i]);
    
    if (tempWeight < oldWeight)
        mat[j*size + i] = tempWeight;
}

