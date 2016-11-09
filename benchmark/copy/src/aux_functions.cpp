#include "aux_functions.hpp"
#include "xil_types.h"

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
