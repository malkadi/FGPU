#include "FGPUlib.c"

#include "divsf3.c"
// #include "subsf3.c"
// #include "mulsf3.c"


__kernel void ludecomposition_L_pass_fadd_fmul_hard_float(__global float *mat,__global float *L, unsigned size, unsigned k) 
{
  // i should have an offset of k+1
  unsigned i = get_global_id(0);

  
  if (i < size) {
    float tmp = mat[i*size + k] / mat[k*size + k];
    L[i*size + k] = tmp;
    if (i == k+1) {
      L[k*size + k] = 1;
    }
  }
}


__kernel void ludecomposition_U_pass_fmul_fadd_hard_float(__global float *mat,__global float *L, unsigned size, unsigned k) 
{
  // i & j should have an offset of k+1
  unsigned i = get_global_id(1);
  unsigned j = get_global_id(0);
  

  bool write = (i < size) & (j != k) & (j < size);
  // mat[i*size+j] = tmp;
  // if(write) {
    float tmp = L[i*size + k];
    float res = mat[i*size+j] - tmp*mat[k*size + j];
    mat[i*size+j] = res;
  // }
}

// This kernel decomposes a matrix into lower and upper parts
// The upper part will overwrite the oroginal matrix 
// The lower one will be stored in L
// __kernel void ludecomposition_pass_fadd_fmul_hard_float(__global float *mat,__global float *L, unsigned size, unsigned k) 
// {
//   // i & j should have an offset of k+1
//   unsigned i = get_global_id(1);
//   unsigned j = get_global_id(0);
//
//   float tmp = mat[i*size + k] / mat[k*size + k];
//   float res = mat[i*size+j] - tmp*mat[k*size + j];
//   
//   if (i < size) {
//     if (j == k) {
//       L[i*size + k] = tmp;
//       if (i == k+1) {
//         L[k*size + k] = 1;
//       }
//     } else if(j < size) {
//       mat[i*size+j] = res;
//     }
//   }
// }
