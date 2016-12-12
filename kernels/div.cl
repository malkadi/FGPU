#include "FGPUlib.c"
unsigned int __udivsi3(unsigned int a, unsigned int b) {
  unsigned int l = 0, h = a;
  do {
    int m = (l+h)/2;
    unsigned int r = m*b;
    unsigned int greater = r > a;
    l = greater? l:m;
    h = greater? m:h;
  } while( (h-l) > 1);
  return l;
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

