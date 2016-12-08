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

void power_measure::set_idle() {
  cur_state = idle;
  *msync = 1;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}

void power_measure::start() {
  cur_state = running;
  *msync = 2;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}

void power_measure::stop() {
  cur_state = finished;
  *msync = 3;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
