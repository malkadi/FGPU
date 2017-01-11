#include "FGPUlib.c"

// This kernel decomposes a matrix into lower and upper parts
// The upper part will overwrite the oroginal matrix 
// The lower one will be stored in L
__kernel void ludecomposition_pass_hard_float(__global float *mat,__global float *L, unsigned size, unsigned k) 
{
  // i & j should have an offset of k+1
  unsigned i = get_global_id(1);
  unsigned j = get_global_id(0);

  float tmp = mat[i*size + k] / mat[k*size + k];
  float res = mat[i*size+j] - tmp*mat[k*size + j];
  
  if (i < size) {
    if (j == k) {
      L[i*size + k] = tmp;
      if (i == k+1) {
        L[k*size + k] = 1;
      }
    } else if(j < size) {
      mat[i*size+j] = res;
    }
  }
}
