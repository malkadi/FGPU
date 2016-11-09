/*
 * FGPU_functions.c
 *
 *  Created on: Jun 14, 2016
 *      Author: muhammed
 */
#include "FGPU_functions.h"

extern const unsigned check_results;

void compute_on_FGPU(kernel_descriptor * kdesc, unsigned n_runs, unsigned *exec_time, bool check_results)
{
  unsigned int runs = 0;
  XTime tStart, tEnd;

  while(runs < n_runs)
  {
    initialize_memory(kdesc);
    kernel_descriptor_download(kdesc);
    REG_WRITE(INITIATE_REG_ADDR, 0xFFFF); // initiate FGPU when execution starts
    REG_WRITE(CLEAN_CACHE_REG_ADDR, 0xFFFF); // clean FGPU cache at end of execution
    
    XTime_GetTime(&tStart);
    REG_WRITE(START_REG_ADDR, 1);
    while(REG_READ(STATUS_REG_ADDR)==0);
    XTime_GetTime(&tEnd);
    *exec_time += elapsed_time_us(tStart, tEnd);
    
    if(check_results)
      check_FGPU_results(kdesc);

    xil_printf(ANSI_COLOR_GREEN "." ANSI_COLOR_RESET);
    fflush(stdout);
    runs++;

    if(*exec_time > 1000000*MAX_MES_TIME_S)// do not execute all required runs if it took too long
      break;
  }
  *exec_time /= runs;
}
