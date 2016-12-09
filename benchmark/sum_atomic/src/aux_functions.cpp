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

void power_measure::print_values() {
  printf("\nAverage Values: (#%d samples)\n", (unsigned) res[0]);
  printf("VccInt-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[1], res[2], res[3]);
  printf("VccAux-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[4], res[5], res[6]);
  printf("VccADJ-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[7], res[8], res[9]);
  printf("Vcc3V3-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[10], res[11], res[12]);
  printf("Vcc1V5-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[13], res[14], res[15]);
  float total_power = res[3]+res[6]+res[9]+res[12]+res[15];
  printf("Total->                              P: %f W\n", total_power);
}

void power_measure::wait_power_values() {
  cout << endl << "Waiting for power values to be written from second core.." << endl;
  while(*msync != 4);
}
