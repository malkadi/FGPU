#include "FGPUlib.c"
__kernel void sharpen5x5(__global unsigned *in, __global unsigned *out){
  unsigned x = get_global_id(1);
  unsigned y = get_global_id(0);
  unsigned rowLen = get_global_size(0);
  unsigned res = 0;
  unsigned p[5][5];
  unsigned i, j;

  // bool border =  x < 2 | y < 2 | (x>rowLen-3) | (y>rowLen-3);
  // if(border) 
  //   return;

  // read pixels
  for(i = 0; i < 5; i++)
    for(j = 0; j < 5; j++)
      p[i][j] = in[(x+i-2)*rowLen+y+j-2];


  res = -1*p[0][0] -1*p[0][1] -1*p[0][2] -1*p[0][3] -1*p[0][4] +
        -1*p[1][0] +2*p[1][1] +2*p[1][2] +2*p[1][3] -1*p[1][4] +
        -1*p[2][0] +2*p[2][1] +8*p[2][2] +2*p[2][3] -1*p[2][4] +
        -1*p[3][0] +2*p[3][1] +2*p[3][2] +2*p[3][3] -1*p[3][4] +
        -1*p[4][0] -1*p[4][1] -1*p[4][2] -1*p[4][3] -1*p[4][4];

  // res = 8 * in[x*rowLen+y];
  // res += 2*in[x*rowLen+y-1];
  // res += 2*in[x*rowLen+y+1];
  // res += 2*in[(x-1)*rowLen+y];
  // res += 2*in[(x-1)*rowLen+y+1];
  // res += 2*in[(x-1)*rowLen+y-1];
  // res += 2*in[(x+1)*rowLen+y];
  // res += 2*in[(x+1)*rowLen+y-1];
  // res += 2*in[(x+1)*rowLen+y+1];
  // res -= in[(x-2)*rowLen+y-2];
  // res -= in[(x-2)*rowLen+y-1];
  // res -= in[(x-2)*rowLen+y];
  // res -= in[(x-2)*rowLen+y+1];
  // res -= in[(x-2)*rowLen+y+2];
  // res -= in[(x-1)*rowLen+y-2];
  // res -= in[(x-1)*rowLen+y+2];
  // res -= in[(x)*rowLen+y-2];
  // res -= in[(x)*rowLen+y+2];
  // res -= in[(x+1)*rowLen+y-2];
  // res -= in[(x+1)*rowLen+y+2];
  // res -= in[(x+2)*rowLen+y-2];
  // res -= in[(x+2)*rowLen+y-1];
  // res -= in[(x+2)*rowLen+y];
  // res -= in[(x+2)*rowLen+y+1];
  // res -= in[(x+2)*rowLen+y+2];
  out[x*rowLen+y] = res/8;
}
