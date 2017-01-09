#include "FGPUlib.c"
__kernel void sum_power_hard_float(__global float *in, __global float *out, unsigned reduce_factor, float mean){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned begin = x;
  int i = 0;
  float sum = 0;
  do{
    sum += (in[begin]-mean)*(in[begin]-mean);
    i++;
    begin += size0;
  }while(i != reduce_factor);
  out[x] = sum;
}

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
