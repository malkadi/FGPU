#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include <assert.h>

XNbody nbody_device;
int main()
{
  const unsigned len = 8*1024;
  const unsigned n_runs = 1;
  init_platform();
  power_measurement_set_idle();

  if (XNbody_Initialize(&nbody_device, 0) != XST_SUCCESS) {
    printf("\ndevice not initialized!\n\r");
    return 1;
  }
  print("Hello World\n\r");
  
  
  float *pos = malloc(sizeof(float)*4*len);
  assert(pos);
  float *new_pos = malloc(sizeof(float)*4*len);
  assert(new_pos);
  float *new_vel = malloc(sizeof(float)*4*len);
  assert(new_vel);
  float *vel = malloc(sizeof(float)*4*len);
  assert(vel);
  float deltaTime = 0.005;
  float epsSqr = 500;
  unsigned i;
  for(i = 0; i < len*4; i++)
  {
    pos[i] = i;
    vel[i] = 0;
  }

  XNbody_Set_pos_r(&nbody_device, (unsigned)pos);
  XNbody_Set_newPos(&nbody_device, (unsigned)new_pos);
  XNbody_Set_vel(&nbody_device, (unsigned)vel);
  XNbody_Set_newVel(&nbody_device, (unsigned)new_vel);
  XNbody_Set_deltaTime(&nbody_device, toRep(deltaTime));
  XNbody_Set_epsSqr(&nbody_device, toRep(epsSqr));
  XNbody_Set_numBodies(&nbody_device, len);
  

  XTime tStart, tEnd;
  power_measurement_start();
  for(i = 0; i < n_runs; i++) {
    XTime_GetTime(&tStart);
    XNbody_Start(&nbody_device);
    while (!XNbody_IsDone(&nbody_device));
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
