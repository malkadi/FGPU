#include "FGPUlib.c"
#include "comparesf2.c"
__kernel void ParallelSelection(__global int * in,__global int* out){
  int i = get_global_id(0); // current thread
  int n = get_global_size(0); // input size
  int ith = in[i];
  // Compute position of in[i] in output
  int pos = 0, j = 0;
  do
  {
    int jth = in[j]; // broadcasted
    bool smaller = (jth < ith);
    bool equal_and_smaller = (jth == ith && j < i);  // in[j] < in[i] ?
    pos += smaller||equal_and_smaller;
    j++;
  }while(j != n);
  out[pos] = ith;
}
__kernel void ParallelSelection_half(__global short* in,__global short* out){
  int i = get_global_id(0); // current thread
  int n = get_global_size(0); // input size
  int ith = in[i];
  // Compute position of in[i] in output
  int pos = 0, j = 0;
  do
  {
    int jth = in[j]; // broadcasted
    bool smaller = (jth < ith);
    bool equal_and_smaller = (jth == ith && j < i);  // in[j] < in[i] ?
    pos += smaller||equal_and_smaller;
    j++;
  }while(j != n);
  out[pos] = ith;
}
__kernel void ParallelSelection_half_improved(__global short2* in,__global short* out){
  int i = get_global_id(0); // current thread
  int n = get_global_size(0); // input size
  __global short *in_short = (__global short*) in;
  int ith = in_short[i];
  int pos = 0, j = 0;
  do
  {
    short2 tmp = in[j>>1];
    int jth = tmp.x; 
    bool smaller = (jth < ith);
    bool equal_and_smaller = (jth == ith && j < i);
    pos += smaller||equal_and_smaller;
    j++;
    jth = tmp.y; 
    smaller = (jth < ith);
    equal_and_smaller = (jth == ith && j < i);
    pos += smaller||equal_and_smaller;
    j++;
  }while(j != n);
  out[pos] = ith;
}
__kernel void ParallelSelection_byte_improved(__global uchar4* in,__global uchar* out){
  unsigned i = get_global_id(0); // current thread
  unsigned n = get_global_size(0); // input size
  __global unsigned char *in_char = (__global unsigned char*) in;
  unsigned ith = in_char[i];
  unsigned pos = 0, j = 0;
  do
  {
    uchar4 tmp = in[j>>2];
    unsigned  jth = tmp.x; 
    bool smaller = (jth < ith);
    bool equal_and_smaller = (jth == ith && j < i);
    pos += smaller||equal_and_smaller;
    j++;
    jth = tmp.y; 
    smaller = (jth < ith);
    equal_and_smaller = (jth == ith && j < i);
    pos += smaller||equal_and_smaller;
    j++;
    jth = tmp.z; 
    smaller = (jth < ith);
    equal_and_smaller = (jth == ith && j < i);
    pos += smaller||equal_and_smaller;
    j++;
    jth = tmp.w; 
    smaller = (jth < ith);
    equal_and_smaller = (jth == ith && j < i);
    pos += smaller||equal_and_smaller;
    j++;
  }while(j != n);
  out[pos] = ith;
}
__kernel void ParallelSelection_byte(__global unsigned char* in,__global unsigned char* out){
  int i = get_global_id(0); // current thread
  int n = get_global_size(0); // input size
  unsigned ith = in[i];
  // Compute position of in[i] in output
  unsigned pos = 0, j = 0;
  do
  {
    unsigned jth = in[j]; // broadcasted
    bool smaller = (jth < ith);
    bool equal_and_smaller = (jth == ith && j < i);  // in[j] < in[i] ?
    pos += smaller||equal_and_smaller;
    j++;
  }while(j != n);
  out[pos] = ith;
}
__kernel void ParallelSelection_float(__global float *in,__global float *out){
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
