#include "FGPUlib.c"
__kernel void ParallelSelection_hard_float(__global float *in,__global float *out){
  int i = get_global_id(0); // current thread
  int n = get_global_size(0); // input size
  float ith = in[i];
  // Compute position of in[i] in output
  int pos = 0, j = 0;
  do
  {
    float jth = in[j]; // broadcasted
    bool smaller = (jth < ith);
    bool equal_and_smaller = (jth == ith && j < i);  // in[j] < in[i] ?
    pos += smaller||equal_and_smaller;
    j++;
  }while(j != n);
  out[pos] = ith;
}
