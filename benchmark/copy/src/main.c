#include "aux_functions.h"
#include "definitions.h"


const unsigned TEST_VEC_LEN = 4;         // The kernel will be executed for problem sizes of 64, 64*2, ... , 64*2^(TEST_VEC_LEN-1)
const unsigned NRUNS = 10;                // Executions & time measurements will be repeated NRUNS times 

int main()
{
  const unsigned check_results = 1;         // The correctness of all results will be checked at the end of each execution round
  
  if(check_results)
    xil_printf("\n\r---Entering main (checking FGPU results is" ANSI_COLOR_GREEN" active" ANSI_COLOR_RESET ") ---\n\r");
  else
    xil_printf("\n\r---Entering main (checking FGPU results is" ANSI_COLOR_RED" inactive" ANSI_COLOR_RESET ") ---\n\r");
  
  xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is copy_word\n\r" ANSI_COLOR_RESET);


  kernel_descriptor kdesc;
  kernel k(64<<TEST_VEC_LEN);
  unsigned i, size_index;

  unsigned *timer_val_fgpu = new unsigned[TEST_VEC_LEN]();
  unsigned *timer_val_arm = new unsigned[TEST_VEC_LEN]();
  kdesc.param1  = new unsigned[64<<TEST_VEC_LEN];
  kdesc.target = new unsigned[64<<TEST_VEC_LEN];


  Xil_ICacheEnable();
  Xil_DCacheEnable();
  k.download_code();
  kernel_code_download(&kdesc);


  xil_printf("Problem Sizes :\n\r");

  for(size_index = 0; size_index < TEST_VEC_LEN; size_index++)
  {
    kernel_descriptor_prepare(&kdesc, size_index);
    xil_printf("%-8u", (unsigned int)kdesc.problemSize);
    fflush(stdout);

    if(kdesc.problemSize > MAX_PROBLEM_SIZE){
      // break if the requested problem size is set too big by mistake
      xil_printf("Problem size exceeds limit!\n\r");
      break;
    }

    compute_on_FGPU(&kdesc,NRUNS, &timer_val_fgpu[size_index] , check_results);

    compute_on_ARM(&kdesc, NRUNS, &timer_val_arm[size_index]);
    
    xil_printf("\n\r");

  }

  xil_printf("\n\r");

  xil_printf("                   Execution time   Execution time   Speedup\n\r");
  xil_printf("Problem Size           " ANSI_COLOR_GREEN "FGPU" ANSI_COLOR_RESET "(us)         " 
              ANSI_COLOR_RED       "ARM" ANSI_COLOR_RESET "(us)\n\r");
  for(i = 0; i < size_index; i++)
    printf("%8d%18d%16d%16.2f\n\r", (64<<i), timer_val_fgpu[i],  timer_val_arm[i], ((float)timer_val_arm[i]/(float)timer_val_fgpu[i]));


  xil_printf("---Exiting main---\n\r\r");
  delete[] kdesc.param1;
  delete[] kdesc.target;
  delete[] timer_val_fgpu;
  delete[] timer_val_arm;

  return 0;
}


