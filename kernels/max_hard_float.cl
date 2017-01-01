#include "FGPUlib.c"
__kernel void max_hard_float(__global float *in, __global float *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i = 1;
  float tmp, max_val = in[begin];
  do{
    begin += size0;
    tmp = in[begin];
    max_val = tmp<max_val?max_val:tmp;
    i++;
  }while(i!= reduce_factor); 
  out[x] = max_val;
}
