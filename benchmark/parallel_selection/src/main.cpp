#include "aux_functions.hpp"
using namespace std;

// #define TYPE  int 
// #define TYPE  short
#define TYPE  char

int main()
{
  // The correctness of all results will be checked at the end of each execution round
  const unsigned check_results = 1; 
  // The kernel will be executed for problem sizes of 64, 64*2, ... , 64*2^(test_vec_len-1)
  const unsigned test_vec_len = 3;
  // Executions & time measurements will be repeated nruns times 
  const unsigned nruns = 1;
  // use vector types:ushort2 instead of ushort OR uchar4 instead of byte
  const bool use_vector_types = 0;
  
  if(check_results)
    xil_printf("\n\r---Entering main (checking FGPU results is" ANSI_COLOR_GREEN" active" ANSI_COLOR_RESET ") ---\n\r");
  else
    xil_printf("\n\r---Entering main (checking FGPU results is" ANSI_COLOR_RED" inactive" ANSI_COLOR_RESET ") ---\n\r");
  


  unsigned i, size_index;

  unsigned *timer_val_fgpu = new unsigned[test_vec_len]();
  unsigned *timer_val_arm = new unsigned[test_vec_len]();

  // enable ARM caches
  Xil_ICacheEnable();
  Xil_DCacheEnable();
  // create kernel
  unsigned maxProblemSize = 64<<test_vec_len;
  kernel<TYPE> parallel_selection_kernel(maxProblemSize, use_vector_types);
  // download binary to FGPU
  parallel_selection_kernel.download_code();


  parallel_selection_kernel.print_name();
  xil_printf("Problem Sizes :\n\r");

  for(size_index = 0; size_index < test_vec_len; size_index++)
  {
    // initiate the kernel descriptor for the required problem size
    parallel_selection_kernel.prepare_descriptor(64 << size_index);
    xil_printf("%-8u", parallel_selection_kernel.get_problemSize());
    fflush(stdout);

    // break if the requested problem size is set too big by mistake
    if(parallel_selection_kernel.get_problemSize() > MAX_PROBLEM_SIZE){
      xil_printf("Problem size exceeds limit!\n\r");
      break;
    }
    // compute on ARM
    timer_val_arm[size_index] = parallel_selection_kernel.compute_on_ARM(nruns);

    // compute on FGPU
    timer_val_fgpu[size_index] = parallel_selection_kernel.compute_on_FGPU(nruns, check_results);

    
    xil_printf("\n\r");

  }

  // print execution times
  cout<<endl<<left<<setw(20)<<"Problem Size"<<setw(25)<<"Execution Time (us)"<<setw(25)<<           "Execution Time (us)"<<setw(25)<<"Speedup"<< endl;
  cout<<setw(32)<<ANSI_COLOR_GREEN  <<                  "FGPU"<<setw(27)<<ANSI_COLOR_RED<<setw(10)<<"ARM"<< ANSI_COLOR_RESET <<endl;
  for(i = 0; i < size_index; i++)
    cout<<setw(28) << (64<<i) <<
      setw(25) << timer_val_fgpu[i] <<
      setw(18) << timer_val_arm[i] <<
      setw(20)<< fixed << setprecision(2) << ((float)timer_val_arm[i]/(float)timer_val_fgpu[i])<<endl;
  

  xil_printf("---Exiting main---\n\r");
  fflush(stdout);

  delete[] timer_val_fgpu;
  delete[] timer_val_arm;

  return 0;
}


