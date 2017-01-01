/*
 * aux_functions.c
 *
 *  Created on: May 7, 2016
 *      Author: muhammed
 */
#include "aux_functions.hpp"
unsigned int set_dimensions(kernel_name kernel)
{
  switch (kernel) {
    case matrix_multiply_kernel:
    case median_kernel:
    case sharpen_kernel:
    case compass_edge_detection_kernel:
    case floydwarshall_kernel:
    case ludecomposition_kernel:
    case sobel_kernel:
      return 2;
    case copy_kernel:
    case fir_kernel:
    case cross_correlation_kernel:
    case vec_add_kernel:
    case vec_mul_kernel:
    case parallel_selection_kernel:
    case sum_kernel:
    case max_kernel:
    case sum_power_kernel:
    case div_kernel:
    case bitonicSort_kernel:
    case fft_kernel:
    case nbody_iter_kernel:
      return 1;
    default:
      assert(0);
      break;
  }
  return 1;
}
void bitReverse(float complex *src, unsigned len, unsigned  nStages)
{
  float complex *dst = &src[len];
  for(unsigned i = 0; i < len; i++)
  {
    unsigned j = i;
    j = (j & 0x55555555) << 1 | (j & 0xAAAAAAAA) >> 1;	
    j = (j & 0x33333333) << 2 | (j & 0xCCCCCCCC) >> 2;	
    j = (j & 0x0F0F0F0F) << 4 | (j & 0xF0F0F0F0) >> 4;	
    j = (j & 0x00FF00FF) << 8 | (j & 0xFF00FF00) >> 8;	
    j = (j & 0x0000FFFF) << 16 | (j & 0xFFFF0000) >> 16;
    j >>= (32-nStages);
    dst[j] = src[i];
  }
  for(unsigned i = 0; i < len; i++)
    src[i] = dst[i];
}
void FFT(float complex *array, float complex *twiddles, unsigned problemSize)
{
  unsigned i, iter;
  unsigned nStages = log2_int(problemSize);
  unsigned pairDistance, blockWidth, nGroups, groupOffset;
  unsigned leftIndx, rightIndx;
  float complex a, b, w;
  for(iter = 0; iter < nStages; iter++)
  {
    pairDistance = 1 << iter;
    blockWidth = 2 * pairDistance;
    nGroups = problemSize >> (iter+1);
    for(i = 0; i < problemSize/2; i++)
    {
      groupOffset = i & (pairDistance-1);	

      leftIndx = (i >> iter)*(blockWidth) + groupOffset;	
      rightIndx = leftIndx + pairDistance;	

      a = array[leftIndx];	
      b = array[rightIndx];	
      w = twiddles[nGroups*groupOffset];

      array[leftIndx] = a + w*b;
      array[rightIndx] = a - w*b;
    }
  }

}
void Nbody_iter(unsigned problemSize, float *initPos, float *newPos, float *initVel, float *newVel) 
{
  unsigned body, i;
  float x1, y1, z1, x2, y2, z2, m2;
  float xdiff, ydiff, zdiff, distSquared;
  float accx, accy, accz;
  float invDist, invDistCube, s;
  float oldVelx, oldVely, oldVelz;
  float deltaTime = 0.005;
  float softeningFactor = 500;

  for( body = 0; body < problemSize; body++) {
    x1 = initPos[body*4];
    y1 = initPos[body*4+1];
    z1 = initPos[body*4+2];
    accx = 0;
    accy = 0;
    accz = 0;
    for (i = 0; i < problemSize; i++) {
      x2 = initPos[i*4];
      y2 = initPos[i*4+1];
      z2 = initPos[i*4+2];
      m2 = initPos[i*4+3];
      xdiff = x2 - x1;
      ydiff = y2 - y1;
      zdiff = z2 - z1;
      distSquared = xdiff*xdiff + ydiff*ydiff + zdiff*zdiff;

      invDist = 1.0f / sqrtf(distSquared + softeningFactor);
      invDistCube = invDist * invDist * invDist;
      s = m2 * invDistCube;
      // accumulate effect of all particles
      accx += s * xdiff;
      accy += s * ydiff;
      accz += s * zdiff;
    }
    oldVelx = initVel[body*4];
    oldVely = initVel[body*4+1];
    oldVelz = initVel[body*4+2];
    // updated position and velocity
    newPos[body*4] = x1 + oldVelx*deltaTime + accx*0.5f*deltaTime*deltaTime;
    newPos[body*4+1] = y1 + oldVely*deltaTime + accy*0.5f*deltaTime*deltaTime;
    newPos[body*4+2] = z1 + oldVelz*deltaTime + accz*0.5f*deltaTime*deltaTime;

    newVel[body*4] = oldVelx + accx*deltaTime;
    newVel[body*4+1] = oldVely + accy*deltaTime;
    newVel[body*4+2] = oldVelz + accz*deltaTime;
  }
}
void set_initial_size(kernel_name kernel, unsigned *size_d0, unsigned *size_d1, unsigned offset)
{
  switch (kernel) {
    case median_kernel:
    case sharpen_kernel:
    case compass_edge_detection_kernel:
    case matrix_multiply_kernel:
    case floydwarshall_kernel:
    case sobel_kernel:
    case ludecomposition_kernel:
      *size_d0 = (1<<offset)*8;
      *size_d1 = (1<<offset)*8;
      break;
    case copy_kernel:
    case fir_kernel:
    case cross_correlation_kernel:
    case vec_add_kernel:
    case vec_mul_kernel:
    case parallel_selection_kernel:
    case sum_kernel:
    case max_kernel:
    case sum_power_kernel:
    case div_kernel:
    case bitonicSort_kernel:
    case fft_kernel:
    case nbody_iter_kernel:
      *size_d0 = 64*(1<<offset);
      break;
    default:
      assert(0);
      break;
  }
}
void power_measure::set_idle() 
{
  cur_state = idle;
  *msync = 1;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
void power_measure::start() 
{
  cur_state = running;
  *msync = 2;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
void power_measure::stop() 
{
  cur_state = finished;
  *msync = 3;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
void power_measure::print_values() 
{
  printf("\nAverage Values: (#%d samples)\n", (unsigned) res[0]);
  printf("VccInt-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[1], res[2], res[3]);
  printf("VccAux-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[4], res[5], res[6]);
  printf("VccADJ-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[7], res[8], res[9]);
  printf("Vcc3V3-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[10], res[11], res[12]);
  printf("Vcc1V5-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[13], res[14], res[15]);
  float total_power = res[3]+res[6]+res[9]+res[12]+res[15];
  printf("Total->                              P: %f W\n", total_power);
}
void power_measure::wait_power_values() 
{
  printf("Waiting for power values to be written from second core..\n");
  Xil_DCacheFlush();
  Xil_DCacheInvalidate();
  while(*msync != 4);
}
