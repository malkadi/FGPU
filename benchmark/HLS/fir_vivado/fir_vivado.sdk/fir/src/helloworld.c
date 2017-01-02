#include "platform.h"

XFir fir_device;
int main()
{
  const unsigned inputLen = 8*1024;
  const unsigned filterLen = 12;
  const unsigned n_runs = 500;
  init_platform();
  power_measurement_set_idle();

  if (XFir_Initialize(&fir_device, 0) != XST_SUCCESS) {
    printf("\ndevice not initialized!\n\r");
    return 1;
  }
  print("Hello World\n\r");
  
  
  float *input = malloc(sizeof(float)*(inputLen+filterLen));
  assert(input);
  float *coeffs = malloc(sizeof(float)*filterLen);
  assert(coeffs);
  float *output = malloc(sizeof(float)*inputLen);
  assert(output);
  unsigned i;
  for(i = 0; i < filterLen; i++) {
    coeffs[i] = i;
  }
  for(i = 0; i < inputLen+filterLen; i++) {
    input[i] = i;
  }

  XFir_Set_input_r(&fir_device, (unsigned) input);
  XFir_Set_coeffs(&fir_device, (unsigned) coeffs);
  XFir_Set_output_r(&fir_device, (unsigned) output);
  XFir_Set_filterLen(&fir_device, (unsigned) filterLen);
  XFir_Set_inputLen(&fir_device, (unsigned) inputLen);

  XTime tStart, tEnd;
  power_measurement_start();
  for(i = 0; i < n_runs; i++) {
    XTime_GetTime(&tStart);
    XFir_Start(&fir_device);
    while (!XFir_IsDone(&fir_device));
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
