#include "aux_functions.h"
#include "xil_types.h"

extern unsigned* const hw_sch_ptr;

extern unsigned* first_param_ptr;
extern unsigned* target_ptr;


void compute_on_ARM(kernel_descriptor *kdesc, unsigned int n_runs, unsigned int *exec_time)
{
  int i;
  unsigned *target_ptr = (unsigned*)TARGET_ADDR;
  unsigned *first_param_ptr = (unsigned*)FIRST_PARAM_ADDR;
  u32 size = kdesc->size;
  unsigned int runs = 0;
  XTime tStart, tEnd;
  *exec_time = 0;
  while(runs < n_runs)
  {
    initialize_memory(kdesc);
    Xil_DCacheFlush();
    Xil_DCacheInvalidate();
    XTime_GetTime(&tStart);

    for(i = 0; i < size; i++)
      target_ptr[i] = first_param_ptr[i];

    // flush the results to the global memory 
    // If the size of the data to be flushed exceeds half of the cache size, flush the whole cache. It is faster!
    if (kdesc->dataSize > 16*1024)
      Xil_DCacheFlush();
    else
      Xil_DCacheFlushRange((unsigned int)target_ptr, kdesc->dataSize);
    
    XTime_GetTime(&tEnd);
    *exec_time += elapsed_time_us(tStart, tEnd);
    xil_printf(ANSI_COLOR_RED "." ANSI_COLOR_RESET);
    fflush(stdout);
    runs++;
    if(*exec_time > 1000000*MAX_MES_TIME_S)
      break;
  }
  *exec_time /= runs;
}
void check_FGPU_results(u32 problemSize, u32 size, u32 size_d0, u32 size_d1)
{
  unsigned int i, nErrors = 0;
  for (i = 0; i < problemSize; i++)
    if(target_ptr[i] != i)
    {
      #if PRINT_ERRORS
        xil_printf("res[0x%x]=0x%x (must be 0x%x)\n\r", i, (unsigned int)target_ptr[i], i);
      #endif
      nErrors++;
    }
  if(nErrors != 0)
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
}
void wait_ms(u64 time)
{
  XTime tStart, tEnd, now;
  XTime_GetTime(&tStart);
  tEnd = tStart + (time*COUNTS_PER_SECOND)/1000;
  do{
    XTime_GetTime(&now);
  }
  while(now < tEnd);
}
u64 elapsed_time_us(XTime tStart, XTime tEnd)
{
  u64 time_elapsed = (tEnd - tStart)*1000000;
  time_elapsed /= COUNTS_PER_SECOND;
  return time_elapsed;
}
