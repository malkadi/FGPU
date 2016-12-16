#include "FGPUlib.c"
#include "comparesf2.c"
__kernel void max_float(__global float *in, __global float *out, unsigned int reduce_factor){
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
__kernel void max_word(__global int *in, __global int *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i = 1;
  int tmp, max_val = in[begin];
  do{
    begin += size0;
    tmp = in[begin];
    max_val = tmp<max_val?max_val:tmp;
    i++;
  }while(i!= reduce_factor); 
  out[x] = max_val;
}
__kernel void max_half(__global short *in, __global short *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i = 1;
  int tmp, max_val = in[begin];
  do{
    begin += size0;
    tmp = in[begin];
    max_val = tmp<max_val?max_val:tmp;
    i++;
  }while(i!= reduce_factor); 
  out[x] = max_val;
}
__kernel void max_half_improved(__global short2 *in, __global short *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  short2 tmp = in[begin];
  int max_val = tmp.x;
  max_val = tmp.y<max_val?max_val:tmp.y;
  int i;
  for(i = 1; i < reduce_factor/2; i++){
    begin += size0;
    tmp = in[begin];
    max_val = tmp.x<max_val?max_val:tmp.x;
    max_val = tmp.y<max_val?max_val:tmp.y;
  }
  out[x] = max_val;
}
__kernel void max_byte(__global char *in, __global char *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  int i = 1;
  int tmp, max_val = in[begin];
  do{
    begin += size0;
    tmp = in[begin];
    max_val = tmp<max_val?max_val:tmp;
    i++;
  }while(i!= reduce_factor); 
  out[x] = max_val;
}
__kernel void max_byte_improved(__global char4 *in, __global char *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  char4 tmp = in[begin];
  int max_val = tmp.x;
  max_val = tmp.y<max_val?max_val:tmp.y;
  max_val = tmp.z<max_val?max_val:tmp.z;
  max_val = tmp.w<max_val?max_val:tmp.w;
  int i;
  for(i = 1; i < reduce_factor/4; i++){
    begin += size0;
    tmp = in[begin];
    max_val = tmp.x<max_val?max_val:tmp.x;
    max_val = tmp.y<max_val?max_val:tmp.y;
    max_val = tmp.z<max_val?max_val:tmp.z;
    max_val = tmp.w<max_val?max_val:tmp.w;
  }
  out[x] = max_val;

}
__kernel void max_byte_improved_atomic(__global char4 *in, __global char *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  char4 tmp = in[begin];
  int max_val = tmp.x;
  max_val = tmp.y<max_val?max_val:tmp.y;
  max_val = tmp.z<max_val?max_val:tmp.z;
  max_val = tmp.w<max_val?max_val:tmp.w;
  int i;
  for(i = 1; i < reduce_factor/4; i++){
    begin += size0;
    tmp = in[begin];
    max_val = tmp.x<max_val?max_val:tmp.x;
    max_val = tmp.y<max_val?max_val:tmp.y;
    max_val = tmp.z<max_val?max_val:tmp.z;
    max_val = tmp.w<max_val?max_val:tmp.w;
  }
  atomic_max((__global int*) out, max_val);

}
__kernel void max_atomic(__global int *in, __global int *out, unsigned int reduce_factor) {
  int id0 = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned index = id0;
  int i = 1, max_val;
  max_val = in[index];
  index += size0;
  for(;i != reduce_factor; i++){
    max_val = max_val<in[index]?in[index]:max_val;
    index += size0;
  }
  atomic_max(out, max_val);
}
__kernel void max_half_atomic(__global short *in, __global short*out, unsigned int reduce_factor) {
  int id0 = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned index = id0;
  int i = 1, max_val;
  max_val = in[index];
  index += size0;
  for(;i != reduce_factor; i++){
    max_val = max_val<in[index]?in[index]:max_val;
    index += size0;
  }
  atomic_max((__global int*) out, max_val);
}
__kernel void max_half_improved_atomic(__global short2 *in, __global short *out, unsigned int reduce_factor){
  int x = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned int begin = x;
  short2 tmp = in[begin];
  int max_val = tmp.x;
  max_val = tmp.y<max_val?max_val:tmp.y;
  int i;
  for(i = 1; i < reduce_factor/2; i++){
    begin += size0;
    tmp = in[begin];
    max_val = tmp.x<max_val?max_val:tmp.x;
    max_val = tmp.y<max_val?max_val:tmp.y;
  }
  atomic_max((__global int*) out, max_val);
}
__kernel void max_byte_atomic(__global char *in, __global char *out, unsigned int reduce_factor) {
  int id0 = get_global_id(0);
  int size0 = get_global_size(0);
  unsigned index = id0;
  int i = 1, max_val;
  max_val = in[index];
  index += size0;
  for(;i != reduce_factor; i++){
    max_val = max_val<in[index]?in[index]:max_val;
    index += size0;
  }
  atomic_max((__global int*) out, max_val);
}
