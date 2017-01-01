#include "aux_functions.hpp"
using namespace std;

#define TYPE  float
// #define TYPE  int
// #define TYPE  short
// #define TYPE  signed char

int main()
{
  // The correctness of all results will be checked at the end of each execution round
  const unsigned check_results = 1; 
  // The kernel will be executed for problem sizes of 64, 64*2, ... , 64*2^(test_vec_len-1)
  const unsigned test_vec_len = 15;
  // Executions & time measurements will be repeated nruns times 
  const unsigned nruns = 10;
  // use the kernel with atomics or do iterative reduction
  const bool use_atomics = 1;
  // use vector types:short2 instead of short OR char4 instead of char
  const bool use_vector_types = 1;
  // use hard floating point units
  const bool use_hard_float = 1;
  // control power measurement
  const unsigned sync_power_measurement = 0;

  
  if(check_results)
    xil_printf("\n\r---Entering main (checking FGPU results is" ANSI_COLOR_GREEN" active" ANSI_COLOR_RESET ") ---\n\r");
  else
    xil_printf("\n\r---Entering main (checking FGPU results is" ANSI_COLOR_RED" inactive" ANSI_COLOR_RESET ") ---\n\r");
  


  unsigned i, size_index;

  unsigned *timer_val_fgpu = new unsigned[test_vec_len]();
  assert(timer_val_fgpu != 0);
  unsigned *timer_val_arm = new unsigned[test_vec_len]();
  assert(timer_val_arm != 0);
  unsigned *best_reduce_factor = new unsigned[test_vec_len]();
  assert(best_reduce_factor != 0);

  // enable ARM caches
  Xil_ICacheEnable();
  Xil_DCacheEnable();
  // create kernel
  kernel<TYPE> max_kernel(MAX_PROBLEM_SIZE, use_vector_types, use_atomics, use_hard_float);
  power_measure power;
  if( sync_power_measurement ) {
    power.set_idle();
  }

  // download binary to FGPU
  max_kernel.download_code();


  max_kernel.print_name();
  xil_printf("Problem Sizes :\n\r");

  if( sync_power_measurement ) {
    power.start();
  }
  for(size_index = 0; size_index < test_vec_len; size_index++)
  {
    // initiate the kernel descriptor for the required problem size
    max_kernel.prepare_descriptor(64 << (size_index+0));
    xil_printf("%-8u", max_kernel.get_problemSize());
    fflush(stdout);

    // break if the requested problem size is set too big by mistake
    if(max_kernel.get_problemSize() > MAX_PROBLEM_SIZE){
      xil_printf("Problem size exceeds limit!\n\r");
      break;
    }

    // compute on ARM
    if (!sync_power_measurement ) {
      timer_val_arm[size_index] = max_kernel.compute_on_ARM(nruns);
    }
    
    // compute on FGPU
    if (!sync_power_measurement )
      timer_val_fgpu[size_index] = max_kernel.compute_on_FGPU(nruns, check_results, best_reduce_factor[size_index]);
    else
      timer_val_fgpu[size_index] = max_kernel.compute_on_FGPU(nruns, false, best_reduce_factor[size_index]);

    xil_printf("\n\r");

  }
  if( sync_power_measurement ) {
    power.stop();
  }

  // print execution times
  cout<<endl<<left<<setw(15)<<"Problem Size"<<setw(22)<<"Execution Time (us)"<<setw(22)<<
                  "Execution Time (us)"<<setw(12)<<"Speedup"<<"Best reduce factor" <<  endl;
  cout<<setw(27)<<ANSI_COLOR_GREEN<<"FGPU"<<setw(24)<<ANSI_COLOR_RED<<setw(10)<<"ARM"<< ANSI_COLOR_RESET <<endl;
  for(i = 0; i < size_index; i++)
    cout<<setw(23) << (64<<i) <<
      setw(22) << timer_val_fgpu[i] <<
      setw(16) << timer_val_arm[i] <<
      setw(13) << fixed << setprecision(2) << ((float)timer_val_arm[i]/(float)timer_val_fgpu[i]) <<
      setw(10) << best_reduce_factor[i] << endl;
  
  if( sync_power_measurement ) {
    power.wait_power_values();
    power.print_values();
  }

  xil_printf("---Exiting main---\n\r");
  fflush(stdout);

  delete[] timer_val_fgpu;
  delete[] timer_val_arm;
  delete[] best_reduce_factor;

  return 0;
}


