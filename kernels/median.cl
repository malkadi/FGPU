#include "FGPUlib.c"
#define sort3(a, b, c){                 \
  unsigned pos_a, pos_b, pos_c;         \
  unsigned tmp_a, tmp_b;                \
  unsigned a_bigger_b, a_bigger_c;      \
  unsigned b_bigger_c;                  \
  a_bigger_b = (a) > (b);               \
  a_bigger_c = (a) > (c);               \
  b_bigger_c = (b) > (c);               \
  pos_a = a_bigger_c + a_bigger_b;      \
  pos_b = !a_bigger_b + b_bigger_c;     \
  pos_c = !a_bigger_c + !b_bigger_c;    \
  tmp_a = (a);                          \
  tmp_b = (b);                          \
  (a) = pos_b == 0 ? (b):(a);           \
  (a) = pos_c == 0 ? (c):(a);           \
  (b) = pos_a == 1 ? tmp_a:(b);         \
  (b) = pos_c == 1 ? (c):(b);           \
  (c) = pos_a == 2 ? tmp_a:(c);         \
  (c) = pos_b == 2 ? tmp_b:(c);         \
}

__kernel void median(__global unsigned *in, __global unsigned *out){
  unsigned x = get_global_id(1);
  unsigned y = get_global_id(0);
  unsigned rowLen = get_global_size(0);
  unsigned p00, p01, p02;
  unsigned p10, p11, p12;
  unsigned p20, p21, p22;
  unsigned res = 0;
  
  // return on boarder pixels
  bool border =  x < 1 | y < 1 | (x>rowLen-2) | (y>rowLen-2);
  if(border) 
    return;

  // read pixels
  p00 = in[(x-1)*rowLen+y-1];
  p10 = in[x*rowLen+y-1];
  p20 = in[(x+1)*rowLen+y-1];
  p01 = in[(x-1)*rowLen+y];
  p11 = in[x*rowLen+y];
  p21 = in[(x+1)*rowLen+y];
  p02 = in[(x-1)*rowLen+y+1];
  p12 = in[x*rowLen+y+1];
  p22 = in[(x+1)*rowLen+y+1];

  // calculate r values
  unsigned p00r, p01r, p02r;
  unsigned p10r, p11r, p12r;
  unsigned p20r, p21r, p22r;

  p00r = p00 & 255;
  p01r = p01 & 255;
  p02r = p02 & 255;
  p10r = p10 & 255;
  p11r = p11 & 255;
  p12r = p12 & 255;
  p20r = p20 & 255;
  p21r = p21 & 255;
  p22r = p22 & 255;
  // sort rows
  sort3(p00r, p01r, p02r);
  sort3(p10r, p11r, p12r);
  sort3(p20r, p21r, p22r);
  //sort columns
  sort3(p00r, p10r, p20r);
  sort3(p01r, p11r, p21r);
  sort3(p02r, p12r, p22r);
  //sort diagonal
  sort3(p00r, p11r, p22r);

  res = p11r;

  // calculate g values
  unsigned p00g, p01g, p02g;
  unsigned p10g, p11g, p12g;
  unsigned p20g, p21g, p22g;
  
  p00g = (p00>>8) & 255;
  p01g = (p01>>8) & 255;
  p02g = (p02>>8) & 255;
  p10g = (p10>>8) & 255;
  p11g = (p11>>8) & 255;
  p12g = (p12>>8) & 255;
  p20g = (p20>>8) & 255;
  p21g = (p21>>8) & 255;
  p22g = (p22>>8) & 255;
  // sort rows
  sort3(p00g, p01g, p02g);
  sort3(p10g, p11g, p12g);
  sort3(p20g, p21g, p22g);
  //sort columns
  sort3(p00g, p10g, p20g);
  sort3(p01g, p11g, p21g);
  sort3(p02g, p12g, p22g);
  //sort diagonal
  sort3(p00g, p11g, p22g);

  res |= p11g<<8;


  // calculate b values
  unsigned p00b, p01b, p02b;
  unsigned p10b, p11b, p12b;
  unsigned p20b, p21b, p22b;
  
  p00b = (p00>>16) & 255;
  p01b = (p01>>16) & 255;
  p02b = (p02>>16) & 255;
  p10b = (p10>>16) & 255;
  p11b = (p11>>16) & 255;
  p12b = (p12>>16) & 255;
  p20b = (p20>>16) & 255;
  p21b = (p21>>16) & 255;
  p22b = (p22>>16) & 255;
  // sort rows
  sort3(p00b, p01b, p02b);
  sort3(p10b, p11b, p12b);
  sort3(p20b, p21b, p22b);
  //sort columns
  sort3(p00b, p10b, p20b);
  sort3(p01b, p11b, p21b);
  sort3(p02b, p12b, p22b);
  //sort diagonal
  sort3(p00b, p11b, p22b);

  res |= p11b << 16;

  out[x*rowLen+y] = res;
}
