/*
 * aux_functions.c
 *
 *  Created on: May 7, 2016
 *      Author: muhammed
 */
#include "aux_functions.hpp"



unsigned int set_dimensions(kernel_name kernel){
  switch (kernel) {
    case matrix_multiply_kernel:
    case median_kernel:
    case sharpen_kernel:
    case compass_edge_detection_kernel:
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
    /* printf("initPos[i].x = %f\n", initPos[4*body]); */
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
      /* printf("s = %f\n", s); */
      accy += s * ydiff;
      accz += s * zdiff;
    }
    /* xil_printf("."); */
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
void compute_on_MB(kernel_name kernel, unsigned int *target_ptr, unsigned int *target2_ptr, unsigned int *first_param_ptr, unsigned int *second_param_ptr, unsigned int size, unsigned int size_d0, unsigned int size_d1)
{
  // int i, j, k;
  // u16 *target_ptr_u16 = (u16*) target_ptr;
  // u16 *target2_ptr_u16 = (u16*) target2_ptr;
  // short *target_ptr_i16 = (short*) target_ptr;
  // float *target_ptr_float = (float*) target_ptr;
  // u16 *first_param_ptr_u16 = (u16*) first_param_ptr;
  // short *first_param_ptr_i16 = (short*) first_param_ptr;
  // short *second_param_ptr_i16 = (short*) second_param_ptr;
  // float *first_param_ptr_float = (float*) first_param_ptr;
  // float *second_param_ptr_float = (float*) second_param_ptr;
  // u8 *target_ptr_u8 = (u8*) target_ptr;
  // u8 *target2_ptr_u8 = (u8*) target2_ptr;
  // float *target2_ptr_float = (float*) target2_ptr;
  // u8 *first_param_ptr_u8 = (u8*) first_param_ptr;
  // char *target_ptr_i8 = (char*) target_ptr;
  // char *second_param_ptr_i8 = (char*) second_param_ptr;
  // char *first_param_ptr_i8 = (char*) first_param_ptr;
  // float complex *first_param_ptr_complex = (float complex*) first_param_ptr;
  // float complex *second_param_ptr_complex = (float complex*) second_param_ptr;

  // switch (kernel) {
//     case nbody_iter_kernel:
//       Nbody_iter(size, first_param_ptr_float, target_ptr_float, second_param_ptr_float, target2_ptr_float);
//       break;
//     case fft_kernel:
//       FFT(size, first_param_ptr_complex, second_param_ptr_complex);
//       break;
//     case bitonicSort_kernel:
//       bitonicSort(size, first_param_ptr);
//       break;
//     case bitonicSort_float_kernel:
//       bitonicSort_float(size, first_param_ptr_float);
//       break;
//     case float_int_float_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_float[i] = (float)((int)first_param_ptr_float[i]);
//       break;
//     case add_float_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_float[i] = first_param_ptr_float[i] + second_param_ptr_float[i];
//       break;
//     case mul_float_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_float[i] = first_param_ptr_float[i] * second_param_ptr_float[i];
//       break;
//     case div_float_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_float[i] = first_param_ptr_float[i] / second_param_ptr_float[i];
//       break;
//     case div_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr[i] = first_param_ptr[i]/div_factor;
//       break;
//     case vec_add_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr[i] = first_param_ptr[i] + second_param_ptr[i];
//       break;
//     case vec_add_half_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_i16[i] = first_param_ptr_i16[i] + second_param_ptr_i16[i];
//       break;
//     case vec_add_byte_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_i8[i] = first_param_ptr_i8[i] + second_param_ptr_i8[i];
//       break;
//     case vec_mul_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr[i] = first_param_ptr[i]*second_param_ptr[i];
//       break;
//     case vec_mul_half_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_i16[i] = first_param_ptr_i16[i]*second_param_ptr_i16[i];
//       break;
//     case vec_mul_byte_kernel:
//       for(i = 0; i < size; i++)
//         target_ptr_i8[i] = first_param_ptr_i8[i]*second_param_ptr_i8[i];
//       break;
//     case fir_kernel:
//       for(i = 0; i < size; i++)
//       {
//         u32 res = 0;
//         for(j = 0; j < filter_len; j++)
//         {
//           res += first_param_ptr[j] * first_param_ptr[j+i];
//         }
//         target_ptr[i] = res;
//       }
//       break;
//     case fir_half_kernel:
//       for(i = 0; i < size; i++)
//       {
//         u32 res = 0;
//         for(j = 0; j < filter_len; j++)
//         {
//           res += first_param_ptr_i16[j] * first_param_ptr_i16[j+i];
//         }
//         target_ptr_i16[i] = res;
//       }
//       break;
//     case fir_byte_kernel:
//       for(i = 0; i < size; i++)
//       {
//         u32 res = 0;
//         for(j = 0; j < filter_len; j++)
//         {
//           res += first_param_ptr_i8[j] * first_param_ptr_i8[j+i];
//         }
//         target_ptr_i8[i] = res;
//       }
//       break;
//     case matrix_multiply_kernel:
//       //printf("size_d0 = %d\n", size_d0);
//       for(j = 0; j < size_d0; j++)
//       {
//         for(i = 0; i < size_d0; i++)
//         {
//           u32 res = 0;
//           for(k = 0; k < size_d0; k++)
//             res += first_param_ptr[j*size_d0 + k] * first_param_ptr[i + k*size_d0];
//           target_ptr[i] = res;
//           //printf("res[%u] = %u\n", i, res);
//         }
//       }
//       break;
//     case matrix_multiply_half_kernel:
//       //printf("size_d0 = %d\n", size_d0);
//       for(j = 0; j < size_d0; j++)
//       {
//         for(i = 0; i < size_d0; i++)
//         {
//           u32 res = 0;
//           for(k = 0; k < size_d0; k++)
//             res += first_param_ptr_i16[j*size_d0 + k] * first_param_ptr_i16[i + k*size_d0];
//           target_ptr_i16[i] = res;
//           //printf("res[%u] = %u\n", i, res);
//         }
//       }
//       break;
//     case matrix_multiply_byte_kernel:
//       //printf("size_d0 = %d\n", size_d0);
//       for(j = 0; j < size_d0; j++)
//       {
//         for(i = 0; i < size_d0; i++)
//         {
//           u32 res = 0;
//           for(k = 0; k < size_d0; k++)
//             res += first_param_ptr_i8[j*size_d0 + k] * first_param_ptr_i8[i + k*size_d0];
//           target_ptr_i8[i] = res;
//           //printf("res[%u] = %u\n", i, res);
//         }
//       }
//       break;
//     case cross_correlation_kernel:
//       for(i = 0; i < size_d0; i++)
//       {
//         int res = 0;
//         #<{(|u32 timer_new;
//         timer_new = timer_read();
//         ov = timer_new < timer_old? ov+1:ov;
//         timer_old = timer_new;|)}>#
//         for(j = 0; j < size_d0; j++)
//         {
//           res += first_param_ptr[j] * second_param_ptr[j+i];
//         }
//         target_ptr[i] = res;
//
//       }
//       #<{(|if(ov)
//         printf("ov = %u\n", ov);|)}>#
//       break;
//     case cross_correlation_half_kernel:
// //      timer_old = timer_read();
// //      ov = 0;
//       for(i = 0; i < size_d0; i++)
//       {
//         int res = 0;
//         for(j = 0; j < size_d0; j++)
//         {
//           res += first_param_ptr_i16[j] * second_param_ptr_i16[j+i];
//         }
//         target_ptr_i16[i] = res;
//
// //        u32 timer_new;
// //        timer_new = timer_read();
// //        ov = timer_new < timer_old? ov+1:ov;
// //        timer_old = timer_new;
//
//       }
// //      if(ov)
// //        printf("ov = %u\n", ov);
//       break;
//     case cross_correlation_byte_kernel:
// //      timer_old = timer_read();
// //      ov = 0;
//       for(i = 0; i < size_d0; i++)
//       {
//         int res = 0;
//         for(j = 0; j < size_d0; j++)
//         {
//           res += first_param_ptr_i8[j] * second_param_ptr_i8[j+i];
//         }
//         target_ptr_i8[i] = res;
// //        u32 timer_new;
// //        timer_new = timer_read();
// //        ov = timer_new < timer_old? ov+1:ov;
// //        timer_old = timer_new;
//       }
// //      if(ov)
// //        printf("ov = %u\n", ov);
//       break;
//     case sharpen_kernel:
//       //for(i = 0; i <= size_d0; i++)
//       for(j = 1; j <= size_d1; j++)
//       {
//         //for(j = 1; j <= size_d1; j++)
//         for(i = 1; i <= size_d0; i++)
//         {
//           int res = 9*first_param_ptr[j*stride+i];
//           res -= first_param_ptr[j*stride+i+1];
//           res -= first_param_ptr[j*stride+i-1];
//           res -= first_param_ptr[(j+1)*stride+i];
//           res -= first_param_ptr[(j+1)*stride+i+1];
//           res -= first_param_ptr[(j+1)*stride+i-1];
//           res -= first_param_ptr[(j-1)*stride+i];
//           res -= first_param_ptr[(j-1)*stride+i+1];
//           res -= first_param_ptr[(j-1)*stride+i-1];
//           target_ptr[j*stride+i] = res;
// //          if((u8) res != (u8)(stride*j + i))
// //            printf("%u(%u),\n ", res, (unsigned int)stride*j+i);
//         }
//         //printf("\n");
//       }
//       break;
//     case sharpen_half_kernel:
//       //for(i = 0; i <= size_d0; i++)
//       for(j = 1; j <= size_d1; j++)
//       {
//         //for(j = 1; j <= size_d1; j++)
//         for(i = 1; i <= size_d0; i++)
//         {
//           int res = 9*first_param_ptr_u16[j*stride+i];
//           res -= first_param_ptr_u16[j*stride+i+1];
//           res -= first_param_ptr_u16[j*stride+i-1];
//           res -= first_param_ptr_u16[(j+1)*stride+i];
//           res -= first_param_ptr_u16[(j+1)*stride+i+1];
//           res -= first_param_ptr_u16[(j+1)*stride+i-1];
//           res -= first_param_ptr_u16[(j-1)*stride+i];
//           res -= first_param_ptr_u16[(j-1)*stride+i+1];
//           res -= first_param_ptr_u16[(j-1)*stride+i-1];
//           target_ptr_u16[j*stride+i] = res;
// //          if((u8) res != (u8)(stride*j + i))
// //            printf("%u(%u),\n ", res, (unsigned int)stride*j+i);
//         }
//       }
//       break;
//     case sharpen_byte_kernel:
//       //for(i = 0; i <= size_d0; i++)
//       for(j = 1; j <= size_d1; j++)
//       {
//         //for(j = 1; j <= size_d1; j++)
//         for(i = 1; i <= size_d0; i++)
//         {
//           int res = 9*first_param_ptr_u8[j*stride+i];
//           res -= first_param_ptr_u8[j*stride+i+1];
//           res -= first_param_ptr_u8[j*stride+i-1];
//           res -= first_param_ptr_u8[(j+1)*stride+i];
//           res -= first_param_ptr_u8[(j+1)*stride+i+1];
//           res -= first_param_ptr_u8[(j+1)*stride+i-1];
//           res -= first_param_ptr_u8[(j-1)*stride+i];
//           res -= first_param_ptr_u8[(j-1)*stride+i+1];
//           res -= first_param_ptr_u8[(j-1)*stride+i-1];
//           target_ptr_u8[j*stride+i] = res;
// //          if((u8) res != (u8)(stride*j + i))
// //            printf("%u(%u),\n ", res, (unsigned int)stride*j+i);
//         }
//       }
//       break;
//     case sharpen5x5_kernel:
//       //for(i = 0; i <= size_d0; i++)
//       for(j = 1; j <= size_d1; j++)
//       {
//         //for(j = 1; j <= size_d1; j++)
//         for(i = 1; i <= size_d0; i++)
//         {
//           int res = 8*first_param_ptr[j*stride+i];
//           res += 2*first_param_ptr[j*stride+i+1];
//           res += 2*first_param_ptr[j*stride+i-1];
//           res += 2*first_param_ptr[(j+1)*stride+i];
//           res += 2*first_param_ptr[(j+1)*stride+i+1];
//           res += 2*first_param_ptr[(j+1)*stride+i-1];
//           res += 2*first_param_ptr[(j-1)*stride+i];
//           res += 2*first_param_ptr[(j-1)*stride+i+1];
//           res += 2*first_param_ptr[(j-1)*stride+i-1];
//           res -= first_param_ptr[(j-2)*stride+i-2];
//           res -= first_param_ptr[(j-2)*stride+i-1];
//           res -= first_param_ptr[(j-2)*stride+i];
//           res -= first_param_ptr[(j-2)*stride+i+1];
//           res -= first_param_ptr[(j-2)*stride+i+2];
//           res -= first_param_ptr[(j-1)*stride+i-2];
//           res -= first_param_ptr[(j-1)*stride+i+2];
//           res -= first_param_ptr[(j)*stride+i-2];
//           res -= first_param_ptr[(j)*stride+i+2];
//           res -= first_param_ptr[(j+1)*stride+i-2];
//           res -= first_param_ptr[(j+1)*stride+i+2];
//           res -= first_param_ptr[(j+2)*stride+i-2];
//           res -= first_param_ptr[(j+2)*stride+i-1];
//           res -= first_param_ptr[(j+2)*stride+i];
//           res -= first_param_ptr[(j+2)*stride+i+1];
//           res -= first_param_ptr[(j+2)*stride+i+2];
//           target_ptr[j*stride+i] = res/8;
// //          if((u8) res != (u8)(stride*j + i))
// //            xil_printf("%u(%u),\n\r ", res, (unsigned int)stride*j+i);
//         }
//         //xil_printf("\n\r");
//       }
//       break;
//     case sharpen5x5_half_kernel:
// //      for(i = 0; i <= size_d0; i++)
//       for(j = 1; j <= size_d1; j++)
//       {
// //        for(j = 1; j <= size_d1; j++)
//         for(i = 1; i <= size_d0; i++)
//         {
//           int res = 8*first_param_ptr_u16[j*stride+i];
//           res += 2*first_param_ptr_u16[j*stride+i+1];
//           res += 2*first_param_ptr_u16[j*stride+i-1];
//           res += 2*first_param_ptr_u16[(j+1)*stride+i];
//           res += 2*first_param_ptr_u16[(j+1)*stride+i+1];
//           res += 2*first_param_ptr_u16[(j+1)*stride+i-1];
//           res += 2*first_param_ptr_u16[(j-1)*stride+i];
//           res += 2*first_param_ptr_u16[(j-1)*stride+i+1];
//           res += 2*first_param_ptr_u16[(j-1)*stride+i-1];
//           res -= first_param_ptr_u16[(j-2)*stride+i-2];
//           res -= first_param_ptr_u16[(j-2)*stride+i-1];
//           res -= first_param_ptr_u16[(j-2)*stride+i];
//           res -= first_param_ptr_u16[(j-2)*stride+i+1];
//           res -= first_param_ptr_u16[(j-2)*stride+i+2];
//           res -= first_param_ptr_u16[(j-1)*stride+i-2];
//           res -= first_param_ptr_u16[(j-1)*stride+i+2];
//           res -= first_param_ptr_u16[(j)*stride+i-2];
//           res -= first_param_ptr_u16[(j)*stride+i+2];
//           res -= first_param_ptr_u16[(j+1)*stride+i-2];
//           res -= first_param_ptr_u16[(j+1)*stride+i+2];
//           res -= first_param_ptr_u16[(j+2)*stride+i-2];
//           res -= first_param_ptr_u16[(j+2)*stride+i-1];
//           res -= first_param_ptr_u16[(j+2)*stride+i];
//           res -= first_param_ptr_u16[(j+2)*stride+i+1];
//           res -= first_param_ptr_u16[(j+2)*stride+i+2];
//           target_ptr_u16[j*stride+i] = res/8;
//         }
//       }
//       break;
//     case sharpen5x5_byte_kernel:
//       for(j = 1; j <= size_d1; j++)
//       {
//         for(i = 1; i <= size_d0; i++)
//         {
//           int res = 8*first_param_ptr_u8[j*stride+i];
//           res += 2*first_param_ptr_u8[j*stride+i+1];
//           res += 2*first_param_ptr_u8[j*stride+i-1];
//           res += 2*first_param_ptr_u8[(j+1)*stride+i];
//           res += 2*first_param_ptr_u8[(j+1)*stride+i+1];
//           res += 2*first_param_ptr_u8[(j+1)*stride+i-1];
//           res += 2*first_param_ptr_u8[(j-1)*stride+i];
//           res += 2*first_param_ptr_u8[(j-1)*stride+i+1];
//           res += 2*first_param_ptr_u8[(j-1)*stride+i-1];
//           res -= first_param_ptr_u8[(j-2)*stride+i-2];
//           res -= first_param_ptr_u8[(j-2)*stride+i-1];
//           res -= first_param_ptr_u8[(j-2)*stride+i];
//           res -= first_param_ptr_u8[(j-2)*stride+i+1];
//           res -= first_param_ptr_u8[(j-2)*stride+i+2];
//           res -= first_param_ptr_u8[(j-1)*stride+i-2];
//           res -= first_param_ptr_u8[(j-1)*stride+i+2];
//           res -= first_param_ptr_u8[(j)*stride+i-2];
//           res -= first_param_ptr_u8[(j)*stride+i+2];
//           res -= first_param_ptr_u8[(j+1)*stride+i-2];
//           res -= first_param_ptr_u8[(j+1)*stride+i+2];
//           res -= first_param_ptr_u8[(j+2)*stride+i-2];
//           res -= first_param_ptr_u8[(j+2)*stride+i-1];
//           res -= first_param_ptr_u8[(j+2)*stride+i];
//           res -= first_param_ptr_u8[(j+2)*stride+i+1];
//           res -= first_param_ptr_u8[(j+2)*stride+i+2];
//           target_ptr_u8[j*stride+i] = res/8;
//         }
//       }
//       break;
//     case parallel_selection_kernel:
//       for(i = 0; i < size_d0; i++)
//       {
//         u32 pos = 0;
//         unsigned  tmp = first_param_ptr[i];
//         for(j = 0; j < size_d0; j++)
//         {
// //          u32 smaller = first_param_ptr[j] < tmp;
// //          u32 equal_and_smaller = (first_param_ptr[j]==tmp && j < i);
// //          pos += smaller || equal_and_smaller;
//           pos += (first_param_ptr[j] < tmp) || (first_param_ptr[j]==tmp && j < i);
//
//         }
//         target_ptr[pos] = tmp;
//         //printf("pos(%u)=%u\n", i, pos);
//       }
//       break;
//     case parallel_selection_half_kernel:
//       for(i = 0; i < size_d0; i++)
//       {
//         u32 pos = 0;
//         u32 tmp = first_param_ptr_i16[i];
//         for(j = 0; j < size_d0; j++)
//         {
// //          u32 smaller = first_param_ptr[j] < tmp;
// //          u32 equal_and_smaller = (first_param_ptr[j]==tmp && j < i);
// //          pos += smaller || equal_and_smaller;
//
//
//         }
//         target_ptr_i16[pos] = tmp;
//       }
//       break;
//     case parallel_selection_byte_kernel:
//       for(i = 0; i < size_d0; i++)
//       {
//         u32 pos = 0;
//         int tmp = first_param_ptr_i8[i];
//         for(j = 0; j < size_d0; j++)
//         {
// //          u32 smaller = first_param_ptr[j] < tmp;
// //          u32 equal_and_smaller = (first_param_ptr[j]==tmp && j < i);
// //          pos += smaller || equal_and_smaller;
//           pos += (first_param_ptr_i8[j] < tmp) || (first_param_ptr_i8[j]==tmp && j < i);
//
//         }
//         target_ptr_i8[pos] = tmp;
//       }
//       break;
//     case median_kernel:
//       //for(i = 1;i <= size_d0; i++)
//       for(k = 1; k <= size_d1; k++)
//       {
//         for(i = 1;i <= size_d0; i++)
//         //for(k = 1; k <= size_d1; k++)
//         {
//             unsigned int p00 = first_param_ptr[(k-1)*stride+i-1];
//             unsigned int p01 = first_param_ptr[k*stride+i-1];
//             unsigned int p02 = first_param_ptr[(k+1)*stride+i-1];
//             unsigned int p10 = first_param_ptr[(k-1)*stride+i];
//             unsigned int p11 = first_param_ptr[k*stride+i];
//             unsigned int p12 = first_param_ptr[(k+1)*stride+i];
//             unsigned int p20 = first_param_ptr[(k-1)*stride+i+1];
//             unsigned int p21 = first_param_ptr[k*stride+i+1];
//             unsigned int p22 = first_param_ptr[(k+1)*stride+i+1];
// //            unsigned int pos_a, pos_b, pos_c, tmp_a, tmp_b;
// //            unsigned int a_bigger_b, a_bigger_c, b_bigger_c;
// //            sort3(p00, p01, p02);
// //            sort3(p10, p11, p12);
// //            sort3(p20, p21, p22);
// //            sort3(p00, p10, p20);
// //            sort3(p01, p11, p21);
// //            sort3(p02, p12, p22);
// //            sort3(p00, p11, p22);
//             sort3_if(&p00, &p01, &p02);
//             sort3_if(&p10, &p11, &p12);
//             sort3_if(&p20, &p21, &p22);
//             sort3_if(&p00, &p10, &p20);
//             sort3_if(&p01, &p11, &p21);
//             sort3_if(&p02, &p12, &p22);
//             sort3_if(&p00, &p11, &p22);
//             target_ptr[k*stride+i] = p11;
//         }
//       }
//       break;
//     case median_half_kernel:
//       //for(i = 1;i <= size_d0; i++)
//       for(k = 1; k <= size_d1; k++)
//       {
//         for(i = 1;i <= size_d0; i++)
//         //for(k = 1; k <= size_d1; k++)
//         {
//             unsigned int p00 = first_param_ptr_u16[(k-1)*stride+i-1];
//             unsigned int p01 = first_param_ptr_u16[k*stride+i-1];
//             unsigned int p02 = first_param_ptr_u16[(k+1)*stride+i-1];
//             unsigned int p10 = first_param_ptr_u16[(k-1)*stride+i];
//             unsigned int p11 = first_param_ptr_u16[k*stride+i];
//             unsigned int p12 = first_param_ptr_u16[(k+1)*stride+i];
//             unsigned int p20 = first_param_ptr_u16[(k-1)*stride+i+1];
//             unsigned int p21 = first_param_ptr_u16[k*stride+i+1];
//             unsigned int p22 = first_param_ptr_u16[(k+1)*stride+i+1];
// //            unsigned int pos_a, pos_b, pos_c, tmp_a, tmp_b;
// //            unsigned int a_bigger_b, a_bigger_c, b_bigger_c;
// //            sort3(p00, p01, p02);
// //            sort3(p10, p11, p12);
// //            sort3(p20, p21, p22);
// //            sort3(p00, p10, p20);
// //            sort3(p01, p11, p21);
// //            sort3(p02, p12, p22);
// //            sort3(p00, p11, p22);
//             sort3_if(&p00, &p01, &p02);
//             sort3_if(&p10, &p11, &p12);
//             sort3_if(&p20, &p21, &p22);
//             sort3_if(&p00, &p10, &p20);
//             sort3_if(&p01, &p11, &p21);
//             sort3_if(&p02, &p12, &p22);
//             sort3_if(&p00, &p11, &p22);
//             target_ptr_u16[k*stride+i] = p11;
//         }
//       }
//       break;
//     case median_byte_kernel:
//       //for(i = 1;i <= size_d0; i++)
//       for(k = 1; k <= size_d1; k++)
//       {
//         for(i = 1;i <= size_d0; i++)
//         //for(k = 1; k <= size_d1; k++)
//         {
//             unsigned int p00 = first_param_ptr_u8[(k-1)*stride+i-1];
//             unsigned int p01 = first_param_ptr_u8[k*stride+i-1];
//             unsigned int p02 = first_param_ptr_u8[(k+1)*stride+i-1];
//             unsigned int p10 = first_param_ptr_u8[(k-1)*stride+i];
//             unsigned int p11 = first_param_ptr_u8[k*stride+i];
//             unsigned int p12 = first_param_ptr_u8[(k+1)*stride+i];
//             unsigned int p20 = first_param_ptr_u8[(k-1)*stride+i+1];
//             unsigned int p21 = first_param_ptr_u8[k*stride+i+1];
//             unsigned int p22 = first_param_ptr_u8[(k+1)*stride+i+1];
// //            unsigned int pos_a, pos_b, pos_c, tmp_a, tmp_b;
// //            unsigned int a_bigger_b, a_bigger_c, b_bigger_c;
// //            sort3(p00, p01, p02);
// //            sort3(p10, p11, p12);
// //            sort3(p20, p21, p22);
// //            sort3(p00, p10, p20);
// //            sort3(p01, p11, p21);
// //            sort3(p02, p12, p22);
// //            sort3(p00, p11, p22);
//             sort3_if(&p00, &p01, &p02);
//             sort3_if(&p10, &p11, &p12);
//             sort3_if(&p20, &p21, &p22);
//             sort3_if(&p00, &p10, &p20);
//             sort3_if(&p01, &p11, &p21);
//             sort3_if(&p02, &p12, &p22);
//             sort3_if(&p00, &p11, &p22);
//             target_ptr_u8[k*stride+i] = p11;
//         }
//       }
//       break;
//     case sum_kernel:
//       j = 0;
//       for(i = 0; i < size_d0; i++)
//         j+= first_param_ptr[i];
//       target_ptr[0] = j;
//       break;
//     case sum_power_kernel:
//       j = 0;
//       for(i = 0; i < size_d0; i++)
//         j+= (first_param_ptr[i]-100)*(first_param_ptr[i]-100);
//       target_ptr[0] = j;
//       break;
//     case sum_power_half_kernel:
//     {
//       j = 0;
//       int c = 100;
//       for(i = 0; i < size_d0; i++){
//         int tmp = first_param_ptr_i16[i];
//         j+= (tmp-c)*(tmp-c);
//       }
//       target_ptr[0] = j;
//       break;
//     }
//   case sum_power_byte_kernel:
//     {
//       j = 0;
//       int c = 100;
//       for(i = 0; i < size_d0; i++){
//         int tmp = first_param_ptr_i8[i];
//         j+= (tmp-c)*(tmp-c);
//       }
//       target_ptr[0] = j;
//       break;
//     }
//     case sum_half_kernel:
//       j = 0;
//       for(i = 0; i < size_d0; i++)
//         j+= first_param_ptr_i16[i];
//       target_ptr_i16[0] = j;
//       break;
//     case sum_byte_kernel:
//       j = 0;
//       for(i = 0; i < size_d0; i++)
//         j+= first_param_ptr_i8[i];
//       target_ptr_i8[0] = j;
//       break;
//     case max_word_kernel:
//       j = first_param_ptr[0];
//       for(i = 1; i < size_d0; i++)
//         if(first_param_ptr[i]>j)
//           j = first_param_ptr[i];
//       target_ptr[0] = j;
//       break;
//     case max_half_kernel:
//       j = first_param_ptr_i16[0];
//       for(i = 1; i < size_d0; i++)
//         if(first_param_ptr_i16[i]>j)
//           j = first_param_ptr_i16[i];
//       target_ptr_i16[0] = j;
//       break;
//     case max_byte_kernel:
//       j = first_param_ptr_i8[0];
//       for(i = 1; i < size_d0; i++)
//         if(first_param_ptr_i8[i]>j)
//           j = first_param_ptr_i8[i];
//       target_ptr_i8[0] = j;
//       break;
//     case compass_edge_detection_kernel:
//       for(k = 1; k <= size_d1; k++)
//       {
//         for(i = 1;i <= size_d0; i++)
//         {
//             unsigned int p00 = first_param_ptr[(k-1)*stride+i-1];
//             unsigned int p01 = first_param_ptr[k*stride+i-1];
//             unsigned int p02 = first_param_ptr[(k+1)*stride+i-1];
//             unsigned int p10 = first_param_ptr[(k-1)*stride+i];
//             unsigned int p11 = first_param_ptr[k*stride+i];
//             unsigned int p12 = first_param_ptr[(k+1)*stride+i];
//             unsigned int p20 = first_param_ptr[(k-1)*stride+i+1];
//             unsigned int p21 = first_param_ptr[k*stride+i+1];
//             unsigned int p22 = first_param_ptr[(k+1)*stride+i+1];
//             int G[8] = {0};
//             G[0] =  -1*p00 +0*p01 +1*p02 +
//                 -2*p10 +0*p11 +2*p12 +
//                 -1*p20 +0*p21 +1*p22;
//             G[1] =  -2*p00 -1*p01 +0*p02 +
//                 -1*p10 +0*p11 +1*p12 +
//                 -0*p20 +1*p21 +2*p22;
//             G[2] =  -1*p00 -2*p01 -1*p02 +
//                 -0*p10 +0*p11 +0*p12 +
//                 +1*p20 +2*p21 +1*p22;
//             G[3] =  -0*p00 -1*p01 -2*p02 +
//                 +1*p10 +0*p11 -1*p12 +
//                 +2*p20 +1*p21 +0*p22;
//             G[4] = -G[0];
//             G[5] = -G[1];
//             G[6] = -G[2];
//             G[7] = -G[3];
//             int max_index = 0, max_val = G[0], index;
//             for(index = 1; index < 8; index++){
//               if(G[index] >= max_val)
//               {
//                 max_val = G[index];
//                 max_index = index;
//               }
//             }
//
//             target_ptr[k*stride+i] = max_val;
//             target2_ptr[k*stride+i] = max_index*45;
//         }
//
//       }
//       break;
//     case compass_edge_detection_half_kernel:
//       for(k = 1; k <= size_d1; k++)
//       {
//         for(i = 1;i <= size_d0; i++)
//         {
//             unsigned int p00 = first_param_ptr_u16[(k-1)*stride+i-1];
//             unsigned int p01 = first_param_ptr_u16[k*stride+i-1];
//             unsigned int p02 = first_param_ptr_u16[(k+1)*stride+i-1];
//             unsigned int p10 = first_param_ptr_u16[(k-1)*stride+i];
//             unsigned int p11 = first_param_ptr_u16[k*stride+i];
//             unsigned int p12 = first_param_ptr_u16[(k+1)*stride+i];
//             unsigned int p20 = first_param_ptr_u16[(k-1)*stride+i+1];
//             unsigned int p21 = first_param_ptr_u16[k*stride+i+1];
//             unsigned int p22 = first_param_ptr_u16[(k+1)*stride+i+1];
//             int G[8] = {0};
//             G[0] =  -1*p00 +0*p01 +1*p02 +
//                 -2*p10 +0*p11 +2*p12 +
//                 -1*p20 +0*p21 +1*p22;
//             G[1] =  -2*p00 -1*p01 +0*p02 +
//                 -1*p10 +0*p11 +1*p12 +
//                 -0*p20 +1*p21 +2*p22;
//             G[2] =  -1*p00 -2*p01 -1*p02 +
//                 -0*p10 +0*p11 +0*p12 +
//                 +1*p20 +2*p21 +1*p22;
//             G[3] =  -0*p00 -1*p01 -2*p02 +
//                 +1*p10 +0*p11 -1*p12 +
//                 +2*p20 +1*p21 +0*p22;
//             G[4] = -G[0];
//             G[5] = -G[1];
//             G[6] = -G[2];
//             G[7] = -G[3];
//             int max_index = 0, max_val = G[0], index;
//             for(index = 1; index < 8; index++){
//               if(G[index] >= max_val)
//               {
//                 max_val = G[index];
//                 max_index = index;
//               }
//             }
//
//             target_ptr_u16[k*stride+i] = max_val;
//             target2_ptr_u16[k*stride+i] = max_index*45;
//         }
//
//       }
//       break;
//     case compass_edge_detection_byte_kernel:
//       for(k = 1; k <= size_d1; k++)
//       {
//         for(i = 1;i <= size_d0; i++)
//         {
//             unsigned int p00 = first_param_ptr_u8[(k-1)*stride+i-1];
//             unsigned int p01 = first_param_ptr_u8[k*stride+i-1];
//             unsigned int p02 = first_param_ptr_u8[(k+1)*stride+i-1];
//             unsigned int p10 = first_param_ptr_u8[(k-1)*stride+i];
//             unsigned int p11 = first_param_ptr_u8[k*stride+i];
//             unsigned int p12 = first_param_ptr_u8[(k+1)*stride+i];
//             unsigned int p20 = first_param_ptr_u8[(k-1)*stride+i+1];
//             unsigned int p21 = first_param_ptr_u8[k*stride+i+1];
//             unsigned int p22 = first_param_ptr_u8[(k+1)*stride+i+1];
//             int G[8] = {0};
//             G[0] =  -1*p00 +0*p01 +1*p02 +
//                 -2*p10 +0*p11 +2*p12 +
//                 -1*p20 +0*p21 +1*p22;
//             G[1] =  -2*p00 -1*p01 +0*p02 +
//                 -1*p10 +0*p11 +1*p12 +
//                 -0*p20 +1*p21 +2*p22;
//             G[2] =  -1*p00 -2*p01 -1*p02 +
//                 -0*p10 +0*p11 +0*p12 +
//                 +1*p20 +2*p21 +1*p22;
//             G[3] =  -0*p00 -1*p01 -2*p02 +
//                 +1*p10 +0*p11 -1*p12 +
//                 +2*p20 +1*p21 +0*p22;
//             G[4] = -G[0];
//             G[5] = -G[1];
//             G[6] = -G[2];
//             G[7] = -G[3];
//             int max_index = 0, max_val = G[0], index;
//             for(index = 1; index < 8; index++){
//               if(G[index] >= max_val)
//               {
//                 max_val = G[index];
//                 max_index = index;
//               }
//             }
//
//             target_ptr_u8[k*stride+i] = max_val;
//             target2_ptr_u8[k*stride+i] = max_index*45;
//         }
//
//       }
//       break;
//     default:
//       assert(0);
//
//   }


}
void set_initial_size(kernel_name kernel, unsigned *size_d0, unsigned *size_d1, unsigned offset)
{
  switch (kernel) {
    case matrix_multiply_kernel:
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
    case median_kernel:
    case sharpen_kernel:
    case compass_edge_detection_kernel:
      *size_d0 = (1<<((offset+1)/2))*8;
      *size_d1 = (1<<(offset/2))*8;
      break;
    default:
      assert(0);
      break;
  }
}
