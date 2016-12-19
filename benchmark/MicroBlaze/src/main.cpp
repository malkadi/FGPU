#include "aux_functions.hpp"

unsigned filter_len = 12;
unsigned div_factor = 10;
unsigned mean = 100;

#define TYPE float
// #define TYPE int
// #define TYPE short
// #define TYPE char

#define VEC_LEN           6
#define N_RUNS            4
#define TEST_VEC_OFFSET   0

int main()
{
  Xil_ICacheEnable();
  Xil_DCacheEnable();
  // kernel_name kernel = copy_kernel;
  // kernel_name kernel = vec_add_kernel;
  // kernel_name kernel = vec_mul_kernel;
  // kernel_name kernel = fir_kernel;
  // kernel_name kernel = matrix_multiply_kernel;
  // kernel_name kernel = cross_correlation_kernel;
  // kernel_name kernel = sharpen_kernel;
  // kernel_name kernel = parallel_selection_kernel;
  // kernel_name kernel = median_kernel;
  // kernel_name kernel = sum_kernel;
  // kernel_name kernel = max_kernel;
  // kernel_name kernel = compass_edge_detection_kernel;
  // kernel_name kernel = sum_power_kernel;
  // kernel_name kernel = div_kernel;
  // kernel_name kernel = bitonicSort_kernel;
  // kernel_name kernel = fft_kernel;
  // kernel_name kernel = nbody_iter_kernel;
  // kernel_name kernel = floydwarshall_kernel;
  kernel_name kernel = ludecomposition_kernel;
  
  // control power measurement
  const unsigned sync_power_measurement = 1;
  
  
  //check if the requested kernel is available for the requested data type  
  if(!check_kernel_type<TYPE>(kernel)) {
    xil_printf("\n\rchoose another type for the selected kernel\n\r");
    return 1;
  }
  
  print_name<TYPE>(kernel);
  power_measure power;
  if( sync_power_measurement ) {
    power.set_idle();
  }

  TYPE *param1_ptr = new TYPE[4*(64<<(TEST_VEC_OFFSET+VEC_LEN))];
  TYPE *param2_ptr = new TYPE[4*(64<<(TEST_VEC_OFFSET+VEC_LEN))];
  TYPE *target_ptr = new TYPE[4*(64<<(TEST_VEC_OFFSET+VEC_LEN))];
  TYPE *target2_ptr = new TYPE[4*(64<<(TEST_VEC_OFFSET+VEC_LEN))];
  assert(param1_ptr);
  assert(param2_ptr);
  assert(target_ptr);
  assert(target2_ptr);

  unsigned nDim;
  unsigned i, iter;
  unsigned size_d0, size_d1, size;  
  u64 time_us[VEC_LEN]={};
  int runs;
  
  set_initial_size(kernel, &size_d0, &size_d1, TEST_VEC_OFFSET);

  xil_printf("\nProblem Sizes:\n\r");

  timer_init();
  nDim = set_dimensions(kernel);


  iter = TEST_VEC_OFFSET;
  if( sync_power_measurement ) {
    power.start();
  }
  while(iter < VEC_LEN+TEST_VEC_OFFSET)
  {
    runs = N_RUNS;

    if(nDim == 1)
      size = size_d0;
    else
      size = size_d0*size_d1;

    xil_printf("%-8d ", size);

    while(runs--)
    {
      initialize_memory<TYPE>(kernel, size, param1_ptr, param2_ptr);

      tic();
      compute<TYPE>(kernel, target_ptr, target2_ptr, param1_ptr, param2_ptr, size, size_d0, size_d1);
      toc();

      time_us[iter-TEST_VEC_OFFSET] += elapsed_time_us();
      xil_printf(".");
      fflush(stdout);
    }
    iter++;
    size_d0 *= 2;
    size_d1 *= 2;
    xil_printf("\n\r");
  }
  if( sync_power_measurement ) {
    power.stop();
  }

  xil_printf("\nExecution times on MicroBlaze (in us)\n\r\n");
  printf("Problem Size                Execution Time(us)\n\r");
  if(nDim == 1)
    for(i = 0; i < VEC_LEN; i++)
      printf("%-35d%llu\n\r", 64<<i, time_us[i]/N_RUNS);
  else
    for(i = 0; i < VEC_LEN; i++)
      printf("%-35d%llu\n\r", (8<<i)*(8<<i), time_us[i]/N_RUNS);

  if( sync_power_measurement ) {
    power.wait_power_values();
    power.print_values();
  }

  xil_printf("Exiting...\n\r");

  Xil_ICacheDisable();
  Xil_DCacheDisable();

  return 0;

}
