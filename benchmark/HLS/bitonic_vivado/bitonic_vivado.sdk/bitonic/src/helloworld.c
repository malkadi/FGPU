#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include <assert.h>

XBitonic bitonic_device;
int main()
{
  const unsigned inputLen_w = 13;
  const unsigned inputLen = 1<<inputLen_w;
  const unsigned n_runs = 50;
  init_platform();
  power_measurement_set_idle();

  if (XBitonic_Initialize(&bitonic_device, 0) != XST_SUCCESS) {
    printf("\ndevice not initialized!\n\r");
    return 1;
  }
  print("Hello World\n\r");
  
  
  float *input = malloc(sizeof(float)*(inputLen));
  assert(input);
  unsigned i;
  for(i = 0; i < inputLen; i++) {
    input[i] = rand();
  }

  XBitonic_Set_array_r(&bitonic_device, (unsigned) input);
  XBitonic_Set_nStages(&bitonic_device, (unsigned) inputLen_w);
  XBitonic_Set_problemSize(&bitonic_device, (unsigned) inputLen);

  XTime tStart, tEnd;
  power_measurement_start();
  for(i = 0; i < n_runs; i++) {
    XTime_GetTime(&tStart);
    XBitonic_Start(&bitonic_device);
    while (!XBitonic_IsDone(&bitonic_device));
    XTime_GetTime(&tEnd);
  }
  power_measurement_stop();

  unsigned timer_count_hw = elapsed_time_us(tStart, tEnd);
    

  printf("Time = %d\n", timer_count_hw);

  power_measurement_wait_power_values();
  power_measurement_print_values();
  cleanup_platform();
  return 0;
}
