#include "FGPUlib.c"

// The coding style of this kernel is developed and tested for best performance

__kernel void sharpen5x5(__global unsigned *in, __global unsigned *out){
  unsigned x = get_global_id(1);
  unsigned y = get_global_id(0);
  unsigned rowLen = get_global_size(0);
  unsigned res = 0;
  int r = 0, g = 0, b = 0;
  unsigned p00, p01, p02, p03, p04;
  unsigned p10, p11, p12, p13, p14;
  unsigned p20, p21, p22, p23, p24;
  unsigned p30, p31, p32, p33, p34;
  unsigned p40, p41, p42, p43, p44;

  bool border =  x < 2 | y < 2 | (x>rowLen-3) | (y>rowLen-3);
  if(border) 
    return;

  // 1st row
  p00 = in[(x-2)*rowLen+y-2];
  r += -(p00&0x0000FF);
  g += -(p00&0x00FF00);
  b += -(p00&0xFF0000);
  p01 = in[(x-2)*rowLen+y-1];
  r += -(p01&0x0000FF);
  g += -(p01&0x00FF00);
  b += -(p01&0xFF0000);
  p02 = in[(x-2)*rowLen+y-0];
  r += -(p02&0x0000FF);
  g += -(p02&0x00FF00);
  b += -(p02&0xFF0000);
  p03 = in[(x-2)*rowLen+y+1];
  r += -(p03&0x0000FF);
  g += -(p03&0x00FF00);
  b += -(p03&0xFF0000);
  p04 = in[(x-2)*rowLen+y+2];
  r += -(p04&0x0000FF);
  g += -(p04&0x00FF00);
  b += -(p04&0xFF0000);
  
  // 2nd row
  p10 = in[(x-1)*rowLen+y-2];
  r += -(p10&0x0000FF);
  g += -(p10&0x00FF00);
  b += -(p10&0xFF0000);
  p11 = in[(x-1)*rowLen+y-1];
  r += 2*(p11&0x0000FF);
  g += 2*(p11&0x00FF00);
  b += 2*(p11&0xFF0000);
  p12 = in[(x-1)*rowLen+y-0];
  r += 2*(p12&0x0000FF);
  g += 2*(p12&0x00FF00);
  b += 2*(p12&0xFF0000);
  p13 = in[(x-1)*rowLen+y+1];
  r += 2*(p13&0x0000FF);
  g += 2*(p13&0x00FF00);
  b += 2*(p13&0xFF0000);
  p14 = in[(x-1)*rowLen+y+2];
  r += -(p14&0x0000FF);
  g += -(p14&0x00FF00);
  b += -(p14&0xFF0000);
  
  // 3rd row
  p20 = in[(x-0)*rowLen+y-2];
  r += -(p20&0x0000FF);
  g += -(p20&0x00FF00);
  b += -(p20&0xFF0000);
  p21 = in[(x-0)*rowLen+y-1];
  r += 2*(p21&0x0000FF);
  g += 2*(p21&0x00FF00);
  b += 2*(p21&0xFF0000);
  p22 = in[(x-0)*rowLen+y-0];
  r += 8*(p22&0x0000FF);
  g += 8*(p22&0x00FF00);
  b += 8*(p22&0xFF0000);
  p23 = in[(x-0)*rowLen+y+1];
  r += 2*(p23&0x0000FF);
  g += 2*(p23&0x00FF00);
  b += 2*(p23&0xFF0000);
  p24 = in[(x-0)*rowLen+y+2];
  r += -(p24&0x0000FF);
  g += -(p24&0x00FF00);
  b += -(p24&0xFF0000);
  
  // 4th row
  p30 = in[(x+1)*rowLen+y-2];
  r += -(p30&0x0000FF);
  g += -(p30&0x00FF00);
  b += -(p30&0xFF0000);
  p31 = in[(x+1)*rowLen+y-1];
  r += 2*(p31&0x0000FF);
  g += 2*(p31&0x00FF00);
  b += 2*(p31&0xFF0000);
  p32 = in[(x+1)*rowLen+y-0];
  r += 2*(p32&0x0000FF);
  g += 2*(p32&0x00FF00);
  b += 2*(p32&0xFF0000);
  p33 = in[(x+1)*rowLen+y+1];
  r += 2*(p33&0x0000FF);
  g += 2*(p33&0x00FF00);
  b += 2*(p33&0xFF0000);
  p34 = in[(x+1)*rowLen+y+2];
  r += -(p34&0x0000FF);
  g += -(p34&0x00FF00);
  b += -(p34&0xFF0000);
  
  // 5th row
  p40 = in[(x+2)*rowLen+y-2];
  r += -(p40&0x0000FF);
  g += -(p40&0x00FF00);
  b += -(p40&0xFF0000);
  p41 = in[(x+2)*rowLen+y-1];
  r += -(p41&0x0000FF);
  g += -(p41&0x00FF00);
  b += -(p41&0xFF0000);
  p42 = in[(x+2)*rowLen+y-0];
  r += -(p42&0x0000FF);
  g += -(p42&0x00FF00);
  b += -(p42&0xFF0000);
  p43 = in[(x+2)*rowLen+y+1];
  r += -(p43&0x0000FF);
  g += -(p43&0x00FF00);
  b += -(p43&0xFF0000);
  p44 = in[(x+2)*rowLen+y+2];
  r += -(p44&0x0000FF);
  g += -(p44&0x00FF00);
  b += -(p44&0xFF0000);
  
  r = r<0 ? 0:r;
  g = g<0 ? 0:g;
  b = b<0 ? 0:b;
  
  r /= 8;
  b /= 8;
  g /= 8;

  r = r>0xFF ? 0xFF:r;
  g = g>0xFF00 ? 0xFF00:g;
  b = b>0xFF0000 ? 0xFF0000:b;
  res = r | g | b | 0xFF000000;


  out[x*rowLen+y] = res;
}
