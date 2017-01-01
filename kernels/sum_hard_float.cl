#include "FGPUlib.c"
__kernel void sum_hard_float(__global float *in, __global float *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i = 0;
  float sum = 0;
  do{
    sum += in[begin];
    i++;
    begin += size0;
  }while(i!= reduce_factor); 
  out[x] = sum;
}
