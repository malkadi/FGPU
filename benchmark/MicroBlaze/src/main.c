#include <stdio.h>
#include "aux_functions.h"
#include "xil_io.h"
#include "xil_cache.h"


const unsigned int filter_len = 12;
const unsigned int stride = 65;
const int div_factor = 3;

#define CHECK_RESULTS     0
#define USE_VOLATILE      0
#define VEC_LEN           13
#define N_RUNS            20
#define TEST_VEC_OFFSET   0
int main()
{
  microblaze_enable_icache();
  microblaze_enable_dcache();
  /* Xil_ICacheEnable(); */
  /* Xil_DCacheEnable(); */
  kernel_name kernel = vec_add_kernel;

  const unsigned int base = 0x2A000000;
  const unsigned int target = 0x2B000000;
  const unsigned int target2 = 0x2C000000;
  unsigned int size_d0 = 256*1024, size_d1 = 0;
  unsigned int size;



  volatile int *msync;
  msync = (int*) 0x3fffff20;
  *msync = 1;
  microblaze_flush_dcache();
  /* Xil_DCacheFlushRange((u32)msync, 4); */
  wait_ms(1000);

#if USE_VOLATILE
  volatile unsigned int* first_param_ptr = (unsigned int*)base;
  volatile unsigned int* second_param_ptr = (unsigned int*)(base+0x01000000);
  volatile unsigned int* target_ptr = (unsigned int*)  target;
#else
  unsigned int* first_param_ptr = (unsigned int*)base;
  unsigned int* second_param_ptr = (unsigned int*)(base+0x01000000);
  unsigned int* target_ptr = (unsigned int*)target;
  unsigned int* target2_ptr = (unsigned int*)target2;
#endif

  unsigned int nDim = 1;
  unsigned int i, iter;
  u64 time_us[VEC_LEN];
  float *first_param_ptr_float = (float*)first_param_ptr;
  float *second_param_ptr_float = (float*)second_param_ptr;

  int runs;
  switch (kernel) {
    case matrix_multiply_kernel:
    case matrix_multiply_half_kernel:
    case matrix_multiply_byte_kernel:
    case transpose_kernel:
    case transpose_half_kernel:
    case transpose_byte_kernel:
      size_d0 = (1<<TEST_VEC_OFFSET)*8;
      size_d1 = (1<<TEST_VEC_OFFSET)*8;
      break;
    case copy_word_kernel:
    case copy_half_kernel:
    case copy_byte_kernel:
    case fir_kernel:
    case fir_half_kernel:
    case fir_byte_kernel:
    case cross_correlation_kernel:
    case cross_correlation_half_kernel:
    case cross_correlation_byte_kernel:
    case vec_add_kernel:
    case vec_add_half_kernel:
    case vec_add_byte_kernel:
    case vec_mul_kernel:
    case vec_mul_half_kernel:
    case vec_mul_byte_kernel:
    case parallel_selection_kernel:
    case parallel_selection_half_kernel:
    case parallel_selection_byte_kernel:
    case sum_kernel:
    case sum_half_kernel:
    case sum_byte_kernel:
    case max_word_kernel:
    case max_half_kernel:
    case max_byte_kernel:
    case sum_power_kernel:
    case sum_power_half_kernel:
    case sum_power_byte_kernel:
    case div_kernel:
    case add_float_kernel:
    case mul_float_kernel:
    case div_float_kernel:
    case float_int_float_kernel:
    case bitonicSort_kernel:
    case bitonicSort_float_kernel:
    case fft_kernel:
    case nbody_iter_kernel:
      size_d0 = 64*(1<<TEST_VEC_OFFSET);
      break;
    case median_kernel:
    case median_half_kernel:
    case sharpen_kernel:
    case median_byte_kernel:
    case sharpen_half_kernel:
    case sharpen_byte_kernel:
    case sharpen5x5_kernel:
    case sharpen5x5_half_kernel:
    case sharpen5x5_byte_kernel:
    case compass_edge_detection_kernel:
    case compass_edge_detection_half_kernel:
    case compass_edge_detection_byte_kernel:
      size_d0 = (1<<((TEST_VEC_OFFSET+1)/2))*8;
      size_d1 = (1<<(TEST_VEC_OFFSET/2))*8;
      break;
    default:
      assert(0);
      break;
  }

  xil_printf("\n\nHello from MicroBlaze\n\r");
  xil_printf("\nSizes:\n\r");

  timer_init();
  nDim = set_dimensions(kernel);


  *msync = 2;
  microblaze_flush_dcache();
  /* Xil_DCacheFlushRange((u32)msync, 4); */
  iter = TEST_VEC_OFFSET;
  float tmpf;
  while(iter < VEC_LEN+TEST_VEC_OFFSET)
  {
    runs = N_RUNS;
    time_us[iter-TEST_VEC_OFFSET] = 0;


    if(nDim == 1)
      size = size_d0;
    else
      size = size_d0*size_d1;

    xil_printf("%-8d ", size);

    switch(kernel)
    {
      case fft_kernel:
        break;
      default:
        for(i = 0; i < 4*size; i++)
        {
          first_param_ptr[i] = i;
          second_param_ptr[i] = size+i;
        }
        break;
    }
    Xil_DCacheFlush();
    Xil_DCacheInvalidate();


    while(runs--)
    {
      switch(kernel)
      {
        case fft_kernel:
          for(i = 0; i < size; i++)
          {
            // calculate twiddles
            tmpf = 2*(float)i*M_PI/(float)size;
            second_param_ptr_float[2*i] = cosf(tmpf);
            second_param_ptr_float[2*i+1] = -sinf(tmpf);
            /* printf("w[%d] = %f + %fj\n\r", i, creal(second_param_ptr_complex[i]), cimag(second_param_ptr_complex[i])); */
            //input signal
            first_param_ptr_float[2*i] = (float) (i%4);
            first_param_ptr_float[2*i+1] = 0;
            /* first_param_ptr_float[2*i+1] = 0; */
            /* printf("first_param_ptr_complex[%d] = %f + %fj\n\r", i, creal(first_param_ptr_complex[i]), cimag(first_param_ptr_complex[i])); */
            /* xil_printf("first_param_ptr_float[%d] = %x\n\r", 2*i, (unsigned)first_param_ptr_float[2*i]); */
            /* xil_printf("first_param_ptr_float[%d] = %x\n\r", 2*i+1, (unsigned)first_param_ptr_float[2*i+1]); */
          }
          break;
        default:
          break;
      }
      XTmrCtr_Reset(&TimerCounter, 0);
      XTmrCtr_Reset(&TimerCounter, 1);
      XTmrCtr_Start(&TimerCounter, 0);

      compute_on_MB(kernel, target_ptr, target2_ptr, first_param_ptr, second_param_ptr, size, size_d0, size_d1);


      /* if(size < 16*1024) */
      /* { */
      /*   Xil_DCacheFlushRange((u32)target, size*4); */
      /* } */
      /* else */
      /* { */
      /*   Xil_DCacheFlush(); */
      /* } */

      XTmrCtr_Stop(&TimerCounter, 0);

      //Xil_DCacheInvalidate();

      time_us[iter-TEST_VEC_OFFSET] += elapsed_time_us();
      xil_printf(".");
      fflush(stdout);
    }
    iter++;
    switch (kernel){
      case copy_word_kernel:
      case copy_half_kernel:
      case copy_byte_kernel:
      case fir_kernel:
      case fir_half_kernel:
      case fir_byte_kernel:
      case cross_correlation_kernel:
      case cross_correlation_half_kernel:
      case cross_correlation_byte_kernel:
      case vec_add_kernel:
      case vec_add_half_kernel:
      case vec_add_byte_kernel:
      case vec_mul_kernel:
      case vec_mul_half_kernel:
      case vec_mul_byte_kernel:
      case matrix_multiply_kernel:
      case matrix_multiply_half_kernel:
      case matrix_multiply_byte_kernel:
      case transpose_kernel:
      case transpose_half_kernel:
      case transpose_byte_kernel:
      case parallel_selection_kernel:
      case parallel_selection_half_kernel:
      case parallel_selection_byte_kernel:
      case sum_kernel:
      case sum_power_kernel:
      case sum_half_kernel:
      case sum_byte_kernel:
      case max_word_kernel:
      case max_half_kernel:
      case max_byte_kernel:
      case sum_power_half_kernel:
      case sum_power_byte_kernel:
      case div_kernel:
      case add_float_kernel:
      case mul_float_kernel:
      case div_float_kernel:
      case float_int_float_kernel:
      case bitonicSort_kernel:
      case bitonicSort_float_kernel:
      case fft_kernel:
      case nbody_iter_kernel:
        size_d0 *= 2;
        size_d1 *= 2;
        break;
      case sharpen_kernel:
      case sharpen_half_kernel:
      case sharpen_byte_kernel:
      case median_kernel:
      case median_byte_kernel:
      case median_half_kernel:
      case sharpen5x5_kernel:
      case sharpen5x5_half_kernel:
      case sharpen5x5_byte_kernel:
      case compass_edge_detection_kernel:
      case compass_edge_detection_half_kernel:
      case compass_edge_detection_byte_kernel:
        size_d0 = (1<<((iter+1)/2))*8;
        size_d1 = (1<<(iter/2))*8;
        break;
      default:
        assert(0);
        break;
    }

    xil_printf("\n\r");

    Xil_DCacheFlush();
    Xil_DCacheInvalidate();
  }
  *msync = 3;
  microblaze_flush_dcache();
  /* Xil_DCacheFlushRange((u32)msync, 4); */
  //timer_new = XTmrCtr_ReadReg(TimerCounter.BaseAddress, 0, XTC_TCR_OFFSET);

  xil_printf("\nExecution times on MicroBlaze (in us)\n\r");
  for(i = 0; i < VEC_LEN; i++)
    printf("%llu\n\r", time_us[i]/N_RUNS);

  xil_printf("Exiting...\n\r");
  //printf("2=%d\n\r", kernelIndx);
  //ChangedPrint("down here\n\r");
  /*while(*flag != 0x55555555);
    size = *(flag+4);
    *(flag+8) = size;*/
  //*flag = 0;
  //Xil_DCacheFlush();

  /* Xil_DCacheDisable(); */
  /* Xil_ICacheDisable(); */

  //cleanup_platform();
  return 0;

}
