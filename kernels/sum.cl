#include "FGPUlib.c"
#include "addsf3.c"
__kernel void sum_atomic_word(__global int *in, __global int *out, unsigned int reduce_factor) {
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned begin = x;
  int i = 0, sum = 0;
  do{
    sum += in[begin];
    i++;
    begin += size0;
  }while(i != reduce_factor);
  atomic_add(out, sum);
}
__kernel void sum_half_atomic(__global short *in, __global short *out, unsigned int reduce_factor) {
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned begin = x;
  int i = 0, sum = 0;
  do{
    sum += in[begin];
    i++;
    begin += size0;
  }while(i != reduce_factor);
  atomic_add((__global int*)out, sum);
}
__kernel void sum_half_improved_atomic(__global short2 *in, __global short *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i;
  int sum = 0;
  for(i = 0; i < reduce_factor/2; i++){
    sum += in[begin].x;
    sum += in[begin].y;
    begin += size0;
  }
  atomic_add((__global int*)out, sum);
}
__kernel void sum_byte_atomic(__global char *in, __global char *out, unsigned int reduce_factor) {
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned begin = x;
  int i = 0, sum = 0;
  do{
    sum += in[begin];
    i++;
    begin += size0;
  }while(i != reduce_factor);
  atomic_add((__global int*)out, sum);
}
__kernel void sum_byte_improved_atomic(__global char4 *in, __global char *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i;
  int sum = 0;
  for(i = 0; i < reduce_factor/4; i++){
    sum += in[begin].x;
    sum += in[begin].y;
    sum += in[begin].z;
    sum += in[begin].w;
    begin += size0;
  }
  atomic_add((__global int*)out, sum);
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
__kernel void sum_half(__global short *in, __global short *out, unsigned int reduce_factor){
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
__kernel void sum_half_improved(__global short2 *in, __global short *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i;
  int sum = 0;
  for(i = 0; i < reduce_factor/2; i++){
    sum += in[begin].x;
    sum += in[begin].y;
    begin += size0;
  }
  out[x] = sum;
}
__kernel void sum_byte(__global char *in, __global char *out, unsigned int reduce_factor){
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
__kernel void sum_byte_improved(__global char4 *in, __global char *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i;
  int sum = 0;
  for(i = 0; i < reduce_factor/4; i++){
    sum += in[begin].x;
    sum += in[begin].y;
    sum += in[begin].z;
    sum += in[begin].w;
    begin += size0;
  }
  out[x] = sum;
}
__kernel void sum_float(__global float *in, __global float *out, unsigned int reduce_factor){
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
