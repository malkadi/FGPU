#include "FGPUlib.c"
__kernel void sum_power(__global int *in, __global int *out, unsigned reduce_factor, int mean){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned begin = x;
  int i = 0, sum = 0;
  do{
    sum += (in[begin]-mean)*(in[begin]-mean);
    i++;
    begin += size0;
  }while(i != reduce_factor);
  out[x] = sum;

}
__kernel void sum_power_atomic(__global int *in, __global int *out, unsigned reduce_factor){
  int x = get_global_id(0);
  int c = 100;
  int size0 = get_global_size(0);
  unsigned begin = x;
  int i = 0, sum = 0;
  do{
    sum += (in[begin]-c)*(in[begin]-c);
    i++;
    begin += size0;
  }while(i != reduce_factor);
  atomic_add(out, sum);
  
}

__kernel void sum(__global int *in, __global int *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i = 0;
  int sum = 0;
  do{
    sum += in[begin];
    i++;
    begin += size0;
  }while(i!= reduce_factor); 
  out[x] = sum;
}
