#include "FGPUlib.c"
__kernel void butterfly_hard(__global float2 *in, int iter, __global float2* twiddle)	
{	
  unsigned indx = get_global_id(0);
  unsigned size = get_global_size(0);
          
  int pairDistance = 1 << iter;
  int blockWidth = 2 * pairDistance;
  int nGroups = size >> iter;
  int butterflyGrpOffset = indx & (pairDistance-1);	
          
  int leftIndx = (indx >> iter)*(blockWidth) + butterflyGrpOffset;	
  int rightIndx = leftIndx + pairDistance;	
          
  int l = nGroups * butterflyGrpOffset;	
          
  float2 a, b, bxx, byy, w, wayx, wbyx, resa, resb;	
          
  a = in[leftIndx];	
  b = in[rightIndx];	
  bxx = b.xx;	
  byy = b.yy;	
  w = twiddle[l];

  wayx.x = -w.y ;
  wayx.y = w.x;
  wbyx.x = w.y;
  wbyx.y = -w.x;
          
  resa = a + bxx*w + byy*wayx;	
  resb = a - bxx*w + byy*wbyx;	
          
  in[leftIndx] = resa;	
  in[rightIndx] = resb;	
}	
