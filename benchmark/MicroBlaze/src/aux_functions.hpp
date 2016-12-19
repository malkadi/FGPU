/*
 * aux_functions.h
 *
 *  Created on: May 7, 2016
 *      Author: muhammed
 */
#ifndef AUX_FUNCTIONS_H_
#define AUX_FUNCTIONS_H_

#include <stdio.h>
#include <stdlib.h>
#include "assert.h"
#include "xil_types.h"
#include "platform.hpp"
#include <complex.h>
#include <math.h>
#include "xil_io.h"
#include "xil_cache.h"
#include <typeinfo>

typedef enum {  copy_kernel, vec_add_kernel, vec_mul_kernel, fir_kernel,
        matrix_multiply_kernel, cross_correlation_kernel, sharpen_kernel,
        parallel_selection_kernel, median_kernel, sum_kernel, max_kernel,
        compass_edge_detection_kernel, sum_power_kernel, div_kernel,
        bitonicSort_kernel, fft_kernel, nbody_iter_kernel, floydwarshall_kernel,
        ludecomposition_kernel
} kernel_name;

extern unsigned filter_len;
extern unsigned div_factor;
extern unsigned mean;

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

#define POWER_SYNC_ADDR       0x3FFFFF20  
#define POWER_RESULTS         0x3Efff000

class power_measure {
  enum state {uninitialized, idle, running, finished};
  state cur_state;
  volatile unsigned *msync;
  volatile float *res;
public:
  power_measure():msync((unsigned *)POWER_SYNC_ADDR), res((volatile float *)POWER_RESULTS){}
  void set_idle();
  void start();
  void stop();
  void print_values();
  void wait_power_values();
};
unsigned int set_dimensions(kernel_name);
void compute_on_MB(kernel_name kernel, unsigned int *target_ptr, unsigned int *target2_ptr, unsigned int *first_param_ptr, unsigned int *second_param_ptr, unsigned int size, unsigned int size_d0, unsigned int size_d1);
void set_initial_size(kernel_name kernel, unsigned *size_d0, unsigned *size_d1, unsigned offset);
void Nbody_iter(unsigned problemSize, float *initPos, float *newPos, float *initVel, float *newVel);
void bitReverse(float complex *src, unsigned len, unsigned  nStages);
void FFT(float complex *array, float complex *twiddles, unsigned problemSize);
inline unsigned log2_int(unsigned a) 
{
  unsigned i = 1, res = 0;
  for(i = 1; i < a; i <<=1)
    res++;
  return res;
}
template<typename T>
void bitonicSort(T *array, unsigned problemSize)
{
  unsigned nStages = 0;
  unsigned pairDistance, blockWidth, leftIndex, rightIndex, sameDirectionBlock;
  T leftElement, rightElement;
  T greater, lesser;
  nStages = log2_int(problemSize);
  for(unsigned i = 0; i < nStages; i++)
  {
    sameDirectionBlock = 1 << i;
    for(unsigned j = 0; j < i+1; j++) // #Passes = stage_index + 1
    {
      for(unsigned k = 0; k < problemSize/2; k++)
      {
        pairDistance = 1 << (i - j);
        blockWidth   = 2 * pairDistance;
        leftIndex = (k % pairDistance) + (k / pairDistance) * blockWidth;
        rightIndex = leftIndex + pairDistance;

        leftElement = array[leftIndex];
        rightElement = array[rightIndex];

        if(leftElement > rightElement)
        {
          greater = leftElement;
          lesser = rightElement;
        }
        else
        {
          greater = rightElement;
          lesser = leftElement;
        }
        if((k/sameDirectionBlock) % 2 == 1)
        { 
          //flip direction
          leftElement = greater;
          rightElement = lesser;
        }
        else
        {
          //same direction
          leftElement = lesser;
          rightElement = greater;
        }
        array[leftIndex] = leftElement;
        array[rightIndex] = rightElement;
      }
    }
  }
}
template<typename T> void matrix_multiply(T *dst, T *src1, T *src2, unsigned size)
{
  for(unsigned j = 0; j < size; j++)
  {
    for(unsigned i = 0; i < size; i++)
    {
      T res = 0;
      for(unsigned k = 0; k < size; k++)
        res += src1[j*size + k] * src2[i + k*size];
      dst[i] = res;
    }
  }
}
template<typename T> void cross_correlation(T *dst, T *src1, T *src2, unsigned size)
{
  for(unsigned i = 0; i < size; i++)
  {
    T res = 0;
    for(unsigned j = 0; j < size; j++)
    {
      res += src1[j] * src2[j+i];
    }
    dst[i] = res;

  }
}
template<typename T> void fir(T *dst, T *src1, T *src2, unsigned size, unsigned filter_len)
{
  for(unsigned i = 0; i < size; i++)
  {
    T res = 0;
    for(unsigned j = 0; j < filter_len; j++)
    {
      res += src1[i+j] * src2[j];
    }
    dst[i] = res;
  }
}
template<typename T> void vec_mul(T *dst, T *src1, T *src2, unsigned size)
{
  for(unsigned i = 0; i < size; i++)
    dst[i] = src1[i] * src2[i];
}
template<typename T> void div(T *dst, T *src1, T div_factor, unsigned size)
{
  for(unsigned i = 0; i < size; i++)
    dst[i] = src1[i]/div_factor;
}
template<typename T> void vec_add(T *dst, T *src1, T *src2, unsigned size)
{
  for(unsigned i = 0; i < size; i++)
    dst[i] = src1[i] + src2[i];
}
template<typename T> void compass_edge_detection(T *dst1, T *dst2, T *src, unsigned size)
{
  for(unsigned k = 1; k <= size; k++)
  {
    for(unsigned i = 1;i <= size; i++)
    {
      unsigned p00 = src[(k-1)*size+i-1];
      unsigned p01 = src[k*size+i-1];
      unsigned p02 = src[(k+1)*size+i-1];
      unsigned p10 = src[(k-1)*size+i];
      unsigned p11 = src[k*size+i];
      unsigned p12 = src[(k+1)*size+i];
      unsigned p20 = src[(k-1)*size+i+1];
      unsigned p21 = src[k*size+i+1];
      unsigned p22 = src[(k+1)*size+i+1];

      int G[8] = {0};
      G[0] =  -1*p00 +0*p01 +1*p02 +
          -2*p10 +0*p11 +2*p12 +
          -1*p20 +0*p21 +1*p22;
      G[1] =  -2*p00 -1*p01 +0*p02 +
          -1*p10 +0*p11 +1*p12 +
          -0*p20 +1*p21 +2*p22;
      G[2] =  -1*p00 -2*p01 -1*p02 +
          -0*p10 +0*p11 +0*p12 +
          +1*p20 +2*p21 +1*p22;
      G[3] =  -0*p00 -1*p01 -2*p02 +
          +1*p10 +0*p11 -1*p12 +
          +2*p20 +1*p21 +0*p22;
      G[4] = -G[0];
      G[5] = -G[1];
      G[6] = -G[2];
      G[7] = -G[3];
      int max_index = 0, max_val = G[0], index;
      for(index = 1; index < 8; index++){
        if(G[index] >= max_val)
        {
          max_val = G[index];
          max_index = index;
        }
      }

      dst1[k*size+i] = max_val;
      dst2[k*size+i] = max_index*45;
    }

  }
}
template<typename T> void sharpen(T *dst, T *src, unsigned size)
{
  for(unsigned i = 2; i < size-2; i++)
  {
    for(unsigned j = 2;j < size-2; j++)
    {
      unsigned res = 0;
      int r = 0, g = 0, b = 0;
      unsigned p00, p01, p02, p03, p04;
      unsigned p10, p11, p12, p13, p14;
      unsigned p20, p21, p22, p23, p24;
      unsigned p30, p31, p32, p33, p34;
      unsigned p40, p41, p42, p43, p44;

      // 1st row
      p00 = src[(i-2)*size+j-2];
      r += -(p00&0x0000FF);
      g += -(p00&0x00FF00);
      b += -(p00&0xFF0000);
      p01 = src[(i-2)*size+j-1];
      r += -(p01&0x0000FF);
      g += -(p01&0x00FF00);
      b += -(p01&0xFF0000);
      p02 = src[(i-2)*size+j-0];
      r += -(p02&0x0000FF);
      g += -(p02&0x00FF00);
      b += -(p02&0xFF0000);
      p03 = src[(i-2)*size+j+1];
      r += -(p03&0x0000FF);
      g += -(p03&0x00FF00);
      b += -(p03&0xFF0000);
      p04 = src[(i-2)*size+j+2];
      r += -(p04&0x0000FF);
      g += -(p04&0x00FF00);
      b += -(p04&0xFF0000);
      
      // 2nd row
      p10 = src[(i-1)*size+j-2];
      r += -(p10&0x0000FF);
      g += -(p10&0x00FF00);
      b += -(p10&0xFF0000);
      p11 = src[(i-1)*size+j-1];
      r += 2*(p11&0x0000FF);
      g += 2*(p11&0x00FF00);
      b += 2*(p11&0xFF0000);
      p12 = src[(i-1)*size+j-0];
      r += 2*(p12&0x0000FF);
      g += 2*(p12&0x00FF00);
      b += 2*(p12&0xFF0000);
      p13 = src[(i-1)*size+j+1];
      r += 2*(p13&0x0000FF);
      g += 2*(p13&0x00FF00);
      b += 2*(p13&0xFF0000);
      p14 = src[(i-1)*size+j+2];
      r += -(p14&0x0000FF);
      g += -(p14&0x00FF00);
      b += -(p14&0xFF0000);
      
      // 3rd row
      p20 = src[(i-0)*size+j-2];
      r += -(p20&0x0000FF);
      g += -(p20&0x00FF00);
      b += -(p20&0xFF0000);
      p21 = src[(i-0)*size+j-1];
      r += 2*(p21&0x0000FF);
      g += 2*(p21&0x00FF00);
      b += 2*(p21&0xFF0000);
      p22 = src[(i-0)*size+j-0];
      r += 8*(p22&0x0000FF);
      g += 8*(p22&0x00FF00);
      b += 8*(p22&0xFF0000);
      p23 = src[(i-0)*size+j+1];
      r += 2*(p23&0x0000FF);
      g += 2*(p23&0x00FF00);
      b += 2*(p23&0xFF0000);
      p24 = src[(i-0)*size+j+2];
      r += -(p24&0x0000FF);
      g += -(p24&0x00FF00);
      b += -(p24&0xFF0000);
      
      // 4th row
      p30 = src[(i+1)*size+j-2];
      r += -(p30&0x0000FF);
      g += -(p30&0x00FF00);
      b += -(p30&0xFF0000);
      p31 = src[(i+1)*size+j-1];
      r += 2*(p31&0x0000FF);
      g += 2*(p31&0x00FF00);
      b += 2*(p31&0xFF0000);
      p32 = src[(i+1)*size+j-0];
      r += 2*(p32&0x0000FF);
      g += 2*(p32&0x00FF00);
      b += 2*(p32&0xFF0000);
      p33 = src[(i+1)*size+j+1];
      r += 2*(p33&0x0000FF);
      g += 2*(p33&0x00FF00);
      b += 2*(p33&0xFF0000);
      p34 = src[(i+1)*size+j+2];
      r += -(p34&0x0000FF);
      g += -(p34&0x00FF00);
      b += -(p34&0xFF0000);
      
      // 5th row
      p40 = src[(i+2)*size+j-2];
      r += -(p40&0x0000FF);
      g += -(p40&0x00FF00);
      b += -(p40&0xFF0000);
      p41 = src[(i+2)*size+j-1];
      r += -(p41&0x0000FF);
      g += -(p41&0x00FF00);
      b += -(p41&0xFF0000);
      p42 = src[(i+2)*size+j-0];
      r += -(p42&0x0000FF);
      g += -(p42&0x00FF00);
      b += -(p42&0xFF0000);
      p43 = src[(i+2)*size+j+1];
      r += -(p43&0x0000FF);
      g += -(p43&0x00FF00);
      b += -(p43&0xFF0000);
      p44 = src[(i+2)*size+j+2];
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
      res = r | g | b;


      dst[i*size+j] = res;
    }
  }
}
template<typename T> void parallel_selection(T *dst, T *src, unsigned size)
{
  for(unsigned i = 0; i < size; i++)
  {
    unsigned pos = 0;
    T tmp = src[i];
    for(unsigned j = 0; j < size; j++)
    {
      pos += (src[j] < tmp) || (src[j]==tmp && j < i);
    }
    dst[pos] = tmp;
  }
}
inline void swap(unsigned *a, unsigned *b)
{
  unsigned int tmp = *a;
  *a = *b;
  *b = tmp;
}
inline void sort3(unsigned *a, unsigned *b, unsigned *c)
{
  if(*a > *b)
    swap(a, b);
  if(*b > *c)
    swap(b, c);
  if(*a > *b)
    swap(a, b);
}
template<typename T> void median(T *dst, T *src, unsigned size)
{
  for(unsigned i = 1; i < size-1; i++)
  {
    for(unsigned j = 1;j < size-1; j++)
    {
        unsigned p00 = src[(i-1)*size+j-1];
        unsigned p10 = src[i*size+j-1];
        unsigned p20 = src[(i+1)*size+j-1];
        unsigned p01 = src[(i-1)*size+j];
        unsigned p11 = src[i*size+j];
        unsigned p21 = src[(i+1)*size+j];
        unsigned p02 = src[(i-1)*size+j+1];
        unsigned p12 = src[i*size+j+1];
        unsigned p22 = src[(i+1)*size+j+1];
        
        // r channel
        unsigned p00r, p01r, p02r;
        unsigned p10r, p11r, p12r;
        unsigned p20r, p21r, p22r;
        p00r = p00 & 0xFF;
        p01r = p01 & 0xFF;
        p02r = p02 & 0xFF;
        p10r = p10 & 0xFF;
        p11r = p11 & 0xFF;
        p12r = p12 & 0xFF;
        p20r = p20 & 0xFF;
        p21r = p21 & 0xFF;
        p22r = p22 & 0xFF;
        sort3(&p00r, &p01r, &p02r);
        sort3(&p10r, &p11r, &p12r);
        sort3(&p20r, &p21r, &p22r);
        sort3(&p00r, &p10r, &p20r);
        sort3(&p01r, &p11r, &p21r);
        sort3(&p02r, &p12r, &p22r);
        sort3(&p00r, &p11r, &p22r);

        // g channel
        unsigned p00g, p01g, p02g;
        unsigned p10g, p11g, p12g;
        unsigned p20g, p21g, p22g;
        p00g = (p00>>8)  & 0xFF;
        p01g = (p01>>8)  & 0xFF;
        p02g = (p02>>8)  & 0xFF;
        p10g = (p10>>8)  & 0xFF;
        p11g = (p11>>8)  & 0xFF;
        p12g = (p12>>8)  & 0xFF;
        p20g = (p20>>8)  & 0xFF;
        p21g = (p21>>8)  & 0xFF;
        p22g = (p22>>8)  & 0xFF;
        sort3(&p00g, &p01g, &p02g);
        sort3(&p10g, &p11g, &p12g);
        sort3(&p20g, &p21g, &p22g);
        sort3(&p00g, &p10g, &p20g);
        sort3(&p01g, &p11g, &p21g);
        sort3(&p02g, &p12g, &p22g);
        sort3(&p00g, &p11g, &p22g);

        // b channel
        unsigned p00b, p01b, p02b;
        unsigned p10b, p11b, p12b;
        unsigned p20b, p21b, p22b;
        p00b = (p00>>16)  & 0xFF;
        p01b = (p01>>16)  & 0xFF;
        p02b = (p02>>16)  & 0xFF;
        p10b = (p10>>16)  & 0xFF;
        p11b = (p11>>16)  & 0xFF;
        p12b = (p12>>16)  & 0xFF;
        p20b = (p20>>16)  & 0xFF;
        p21b = (p21>>16)  & 0xFF;
        p22b = (p22>>16)  & 0xFF;
        
        sort3(&p00b, &p01b, &p02b);
        sort3(&p10b, &p11b, &p12b);
        sort3(&p20b, &p21b, &p22b);
        sort3(&p00b, &p10b, &p20b);
        sort3(&p01b, &p11b, &p21b);
        sort3(&p02b, &p12b, &p22b);
        sort3(&p00b, &p11b, &p22b);

        dst[i*size+j] = p11r | (p11g<<8) | (p11b<<16);
    }
  }
}
template<typename T> void max(T *dst, T *src, unsigned size)
{
  T res = 0;
  for(unsigned i = 0; i < size; i++)
    res = src[i]>res ? src[i]:res;
  dst[0] = res;
}
template<typename T> void sum_power(T *dst, T *src, unsigned size, unsigned mean)
{
  T res = 0;
  for(unsigned i = 0; i < size; i++)
    res += (src[i]-mean)*(src[i]-mean);
  dst[0] = res;
}
template<typename T> void sum(T *dst, T *src, unsigned size)
{
  T res = 0;
  for(unsigned i = 0; i < size; i++)
    res += src[i];
  dst[0] = res;
}
template<typename T> void copy(T *dst, T *src, unsigned size)
{
  for(unsigned i = 0; i < size; i++)
    dst[i] = src[i];
}
template<typename T> void FloydWarshall(T *mat, unsigned n) 
{
  T oldWeight, tempWeight;
  for (unsigned k = 0; k < n; k++) {
    for (unsigned i = 0; i < n; i++) {
      for (unsigned j = 0; j < n; j++) {
        oldWeight = mat[j*n + i];
        tempWeight = mat[j*n + k] + mat[k*n + i];
        if (tempWeight < oldWeight)
            mat[j*n + i] = tempWeight;
      }
    }
  }
}
template<typename T>
void initialize_memory(kernel_name kernel, unsigned size, T *first_param_ptr, T *second_param_ptr)
{
  unsigned i;
  // float *first_param_ptr_float = (float*)first_param_ptr;
  // float *second_param_ptr_float = (float*)second_param_ptr;
  switch(kernel)
  {
    case fft_kernel:
      for(i = 0; i < size; i++)
      {
        first_param_ptr[i] = (T)rand();
        // calculate twiddles
        float tmpf;
        tmpf = 2*(float)i*M_PI/(float)size;
        second_param_ptr[2*i] = cosf(tmpf);
        second_param_ptr[2*i+1] = -sinf(tmpf);
      }
      bitReverse((float complex*) first_param_ptr, size, log2_int(size));
      break;
    default:
      for(i = 0; i < 4*size; i++)
      {
        // first_param_ptr[i] = (T)rand();
        // second_param_ptr[i] = (T)rand();
        first_param_ptr[i] = (T)i;
        second_param_ptr[i] = (T)i;
      }
      break;
  }
  microblaze_flush_dcache();
  microblaze_invalidate_dcache();
  Xil_DCacheFlush();
  Xil_DCacheInvalidate();
}
template<typename T>void LUDecomposition(unsigned n, T *mat, T *L)
{
  for(unsigned k = 0; k < n-1; k++) {
    L[k*n + k] = 1;
    for(unsigned i = k+1; i < n; i++) {
      L[i*n + k] = mat[i*n + k] / mat[k*n + k];
      for(unsigned j = k+1; j < n; j++) {
        mat[i*n+j] -= L[i*n + k]*mat[k*n + j];
      }
    }
  }
}
template<typename T>
void compute(kernel_name kernel, T *target_ptr, T *target2_ptr, T *param1_ptr, T *param2_ptr, unsigned size, unsigned size_d0, unsigned size_d1)
{
  switch(kernel)
  {
    case copy_kernel:
      copy<T>(target_ptr, param1_ptr, size_d0);
      break;
    case vec_add_kernel:
      vec_add<T>(target_ptr, param1_ptr, param2_ptr, size_d0);
      break;
    case vec_mul_kernel:
      vec_mul<T>(target_ptr, param1_ptr, param2_ptr, size_d0);
      break;
    case median_kernel:
      median<T>(target_ptr, param1_ptr, size_d0);
      break;
    case sum_power_kernel:
      sum_power<T>(target_ptr, param1_ptr, size_d0, mean);
      break;
    case sum_kernel:
      sum<T>(target_ptr, param1_ptr, size_d0);
      break;
    case floydwarshall_kernel:
      FloydWarshall<T>(param1_ptr, size_d0);
      break;
    case bitonicSort_kernel:
      bitonicSort<T>(param1_ptr, size_d0);
      break;
    case div_kernel:
      div<T>(target_ptr, param1_ptr, div_factor, size_d0);
      break;
    case max_kernel:
      max<T>(target_ptr, param1_ptr, size_d0);
      break;
    case compass_edge_detection_kernel:
      compass_edge_detection<T>(target_ptr, target2_ptr, param1_ptr, size_d0);
      break;
    case sharpen_kernel:
      sharpen<T>(target_ptr, param1_ptr, size_d0);
      break;
    case parallel_selection_kernel:
      parallel_selection<T>(target_ptr, param1_ptr, size_d0);
      break;
    case fir_kernel:
      fir<T>(target_ptr, param1_ptr, param2_ptr, size_d0, filter_len);
      break;
    case cross_correlation_kernel:
      cross_correlation<T>(target_ptr, param1_ptr, param2_ptr, size_d0);
      break;
    case matrix_multiply_kernel:
      matrix_multiply<T>(target_ptr, param1_ptr, param2_ptr, size_d0);
      break;
    case fft_kernel:
      FFT((float complex*) param1_ptr, (float complex*) param2_ptr, size_d0);
      break;
    case ludecomposition_kernel:
      LUDecomposition(size_d0, param1_ptr, target_ptr);
      break;
    case nbody_iter_kernel:
      Nbody_iter(size_d0, (float*)param1_ptr, (float*)param2_ptr, (float*)target_ptr, (float*)target2_ptr);
      break;
    default:
      assert(0);
      break;
  }
  //flush results to global mem
  switch(kernel)
  {
    case copy_kernel:
    case vec_add_kernel:
    case vec_mul_kernel:
    case fir_kernel:
    case median_kernel:
    case parallel_selection_kernel:
    case sharpen_kernel:
    case cross_correlation_kernel:
    case matrix_multiply_kernel:
    case div_kernel:
      Xil_DCacheFlushRange((unsigned)target_ptr, size*sizeof(T));
      break;
    case bitonicSort_kernel:
    case floydwarshall_kernel:
      Xil_DCacheFlushRange((unsigned)param1_ptr, size*sizeof(T));
      break;
    case sum_kernel:
    case sum_power_kernel:
    case max_kernel:
      Xil_DCacheFlushRange((unsigned)target_ptr, 4);
      break;
    case compass_edge_detection_kernel:
      Xil_DCacheFlushRange((unsigned)target_ptr, size*sizeof(T));
      Xil_DCacheFlushRange((unsigned)target2_ptr, size*sizeof(T));
      break;
    case ludecomposition_kernel:
      Xil_DCacheFlushRange((unsigned)target_ptr, size*sizeof(T));
      Xil_DCacheFlushRange((unsigned)param1_ptr, size*sizeof(T));
      break;
    case fft_kernel:
      Xil_DCacheFlushRange((unsigned)param1_ptr, 2*size*sizeof(T));//2 for real and imaginary parts
      break;
    case nbody_iter_kernel:
      Xil_DCacheFlushRange((unsigned)target_ptr, 4*size*sizeof(T));
      Xil_DCacheFlushRange((unsigned)target2_ptr, 4*size*sizeof(T));
      break;
    default:
      assert(0);
      break;
  }
}
template<typename T>
bool check_kernel_type(kernel_name kernel)
{
  switch(kernel)
  { 
    case copy_kernel:
    case vec_add_kernel:
    case vec_mul_kernel:
    case fir_kernel:
    case sum_kernel:
    case max_kernel:
    case parallel_selection_kernel:
    case cross_correlation_kernel:
    case matrix_multiply_kernel:
      if(typeid(T) == typeid(float) || typeid(T) == typeid(int) || typeid(T) == typeid(short) || typeid(T) == typeid(char))
        return true;
      break;
    case sum_power_kernel:
    case div_kernel:
    case bitonicSort_kernel:
      if(typeid(T) == typeid(int) || typeid(float) == typeid(T))
        return true;
      break;
    case sharpen_kernel:
    case compass_edge_detection_kernel:
    case median_kernel:
      if(typeid(T) == typeid(int))
        return true;
      break;
    case fft_kernel:
    case ludecomposition_kernel:
    case floydwarshall_kernel:
    case nbody_iter_kernel:
      if(typeid(T) == typeid(float))
        return true;
      break;
    default:
      assert(0);
      break;
  }
  return false;
}
template <typename T>
void print_name(kernel_name kernel)
{
  xil_printf("\n\r" ANSI_COLOR_MAGENTA);
  switch(kernel)
  { 
    case copy_kernel:
      xil_printf("copy kernel");break;
    case vec_add_kernel:
      xil_printf("vec_add kernel");break;
    case vec_mul_kernel:
      xil_printf("vec_mul kernel");break;
    case sum_kernel:
      xil_printf("sum kernel");break;
    case sum_power_kernel:
      xil_printf("sum_power kernel");break;
    case bitonicSort_kernel:
      xil_printf("bitonicSort kernel");break;
    case div_kernel:
      xil_printf("div kernel");break;
    case max_kernel:
      xil_printf("max kernel");break;
    case floydwarshall_kernel:
      xil_printf("Floyd-Warshall kernel");break;
    case ludecomposition_kernel:
      xil_printf("LU decomposition kernel");break;
    case fft_kernel:
      xil_printf("fft kernel");break;
    case fir_kernel:
      xil_printf("fir kernel");break;
    case median_kernel:
      xil_printf("median kernel");break;
    case cross_correlation_kernel:
      xil_printf("cross_correlation kernel");break;
    case matrix_multiply_kernel:
      xil_printf("matrix_multiply kernel");break;
    case compass_edge_detection_kernel:
      xil_printf("compass_edge_detection kernel");break;
    case sharpen_kernel:
      xil_printf("sharpen kernel");break;
    case parallel_selection_kernel:
      xil_printf("parallel_selection kernel");break;
    case nbody_iter_kernel:
      xil_printf("Nbody_iter kernel");break;
    default:
      assert(0);
  }
  xil_printf(" (type is ");
  if(typeid(T) == typeid(float))
    xil_printf("float");
  else if(typeid(T) == typeid(int))
    xil_printf("int");
  else if(typeid(T) == typeid(short))
    xil_printf("short");
  else if(typeid(T) == typeid(char))
    xil_printf("char");
  
  xil_printf(")\n\r" ANSI_COLOR_RESET);
}
#endif /* AUX_FUNCTIONS_H_ */
