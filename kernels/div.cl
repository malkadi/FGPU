#include "FGPUlib.c"
#include "divsf3.c"
unsigned int __udivsi3(unsigned int a, unsigned int b) {
  unsigned q = 0, r = 0;
  // int i; 
  // for(i = 31; i >= 0; i--) {
  //   r <<= 1;
  //   r += (a >> i) & 1;
  //   q += r<b? 0:1<<i;
  //   r -= r<b? 0:b;
  // }
  // The previous loop will be manually unrolled for better performance
  // 31
  r <<= 1;
  r += (a >> 31) & 1;
  q += r<b? 0:1<<31;
  r -= r<b? 0:b;
  // 30
  r <<= 1;
  r += (a >> 30) & 1;
  q += r<b? 0:1<<30;
  r -= r<b? 0:b;
  // 29
  r <<= 1;
  r += (a >> 29) & 1;
  q += r<b? 0:1<<29;
  r -= r<b? 0:b;
  // 28
  r <<= 1;
  r += (a >> 28) & 1;
  q += r<b? 0:1<<28;
  r -= r<b? 0:b;
  // 27
  r <<= 1;
  r += (a >> 27) & 1;
  q += r<b? 0:1<<27;
  r -= r<b? 0:b;
  // 26
  r <<= 1;
  r += (a >> 26) & 1;
  q += r<b? 0:1<<26;
  r -= r<b? 0:b;
  // 25
  r <<= 1;
  r += (a >> 25) & 1;
  q += r<b? 0:1<<25;
  r -= r<b? 0:b;
  // 24
  r <<= 1;
  r += (a >> 24) & 1;
  q += r<b? 0:1<<24;
  r -= r<b? 0:b;
  // 23
  r <<= 1;
  r += (a >> 23) & 1;
  q += r<b? 0:1<<23;
  r -= r<b? 0:b;
  // 22
  r <<= 1;
  r += (a >> 22) & 1;
  q += r<b? 0:1<<22;
  r -= r<b? 0:b;
  // 21
  r <<= 1;
  r += (a >> 21) & 1;
  q += r<b? 0:1<<21;
  r -= r<b? 0:b;
  // 20
  r <<= 1;
  r += (a >> 20) & 1;
  q += r<b? 0:1<<20;
  r -= r<b? 0:b;
  // 19
  r <<= 1;
  r += (a >> 19) & 1;
  q += r<b? 0:1<<19;
  r -= r<b? 0:b;
  // 18
  r <<= 1;
  r += (a >> 18) & 1;
  q += r<b? 0:1<<18;
  r -= r<b? 0:b;
  // 17
  r <<= 1;
  r += (a >> 17) & 1;
  q += r<b? 0:1<<17;
  r -= r<b? 0:b;
  // 16
  r <<= 1;
  r += (a >> 16) & 1;
  q += r<b? 0:1<<16;
  r -= r<b? 0:b;
  // 15
  r <<= 1;
  r += (a >> 15) & 1;
  q += r<b? 0:1<<15;
  r -= r<b? 0:b;
  // 14
  r <<= 1;
  r += (a >> 14) & 1;
  q += r<b? 0:1<<14;
  r -= r<b? 0:b;
  // 13
  r <<= 1;
  r += (a >> 13) & 1;
  q += r<b? 0:1<<13;
  r -= r<b? 0:b;
  // 12
  r <<= 1;
  r += (a >> 12) & 1;
  q += r<b? 0:1<<12;
  r -= r<b? 0:b;
  // 11
  r <<= 1;
  r += (a >> 11) & 1;
  q += r<b? 0:1<<11;
  r -= r<b? 0:b;
  // 10
  r <<= 1;
  r += (a >> 10) & 1;
  q += r<b? 0:1<<10;
  r -= r<b? 0:b;
  // 9
  r <<= 1;
  r += (a >> 9) & 1;
  q += r<b? 0:1<<9;
  r -= r<b? 0:b;
  // 8
  r <<= 1;
  r += (a >> 8) & 1;
  q += r<b? 0:1<<8;
  r -= r<b? 0:b;
  // 7
  r <<= 1;
  r += (a >> 7) & 1;
  q += r<b? 0:1<<7;
  r -= r<b? 0:b;
  // 6
  r <<= 1;
  r += (a >> 6) & 1;
  q += r<b? 0:1<<6;
  r -= r<b? 0:b;
  // 5
  r <<= 1;
  r += (a >> 5) & 1;
  q += r<b? 0:1<<5;
  r -= r<b? 0:b;
  // 4
  r <<= 1;
  r += (a >> 4) & 1;
  q += r<b? 0:1<<4;
  r -= r<b? 0:b;
  // 3
  r <<= 1;
  r += (a >> 3) & 1;
  q += r<b? 0:1<<3;
  r -= r<b? 0:b;
  // 2
  r <<= 1;
  r += (a >> 2) & 1;
  q += r<b? 0:1<<2;
  r -= r<b? 0:b;
  // 1
  r <<= 1;
  r += (a >> 1) & 1;
  q += r<b? 0:1<<1;
  r -= r<b? 0:b;
  // 0
  r <<= 1;
  r += (a >> 0) & 1;
  q += r<b? 0:1<<0;
  r -= r<b? 0:b;
  return q;
}
int __divsi3(int a, int b){
  unsigned int a_pos = a<0? -a:a;
  unsigned int b_pos = b<0? -b:b;
  unsigned int res_sign = ((a<0) && (b<0)) || (a>=0 && b>=0);
  unsigned res = a_pos / b_pos;
  return res_sign? res:-res;
}
__kernel void div_int(__global int *in, __global int *out, int val) {
    int x = get_global_id(0);
    out[x] = in[x]/val;
}
__kernel void div_float(__global float *in1, __global float *out, float val) {
  int x = get_global_id(0);
  out[x] = in1[x]/val;
}
