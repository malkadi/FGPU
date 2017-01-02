#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include <assert.h>

XFloydwarshall floydwarshall_device;
int main()
{
  const unsigned size0 = 64;
  const unsigned n_runs = 10;
  init_platform();
  power_measurement_set_idle();

  if (XFloydwarshall_Initialize(&floydwarshall_device, 0) != XST_SUCCESS) {
    printf("\ndevice not initialized!\n\r");
    return 1;
  }
  print("FloydWarshall with Vivado HLS\n\r");
  
  
  float *mat = malloc(sizeof(float)*size0*size0);
  assert(mat);
  unsigned i, j;
  for(i = 0; i < size0; i++) {
    for(j = 0; j < size0; j++) {
      mat[i*size0 + j]  = rand() >> 24;
      if(i == j)
        mat[i*size0 + j]  = 0;
    }
  }

  XFloydwarshall_Set_mat(&floydwarshall_device, (unsigned) mat);
  XFloydwarshall_Set_n(&floydwarshall_device, size0);
  

  XTime tStart, tEnd;
  power_measurement_start();
  for(i = 0; i < n_runs; i++) {
    XTime_GetTime(&tStart);
    XFloydwarshall_Start(&floydwarshall_device);
    while (!XFloydwarshall_IsDone(&floydwarshall_device));
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
