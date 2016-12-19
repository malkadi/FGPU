/* pm_zc706.c
 *  Created on: 27.08.2015
 */
#include <stdio.h>		/* */
#include <stdlib.h>
#include "platform.h"	/* */
#include "xil_printf.h"	/* */
#include "xstatus.h"	/* */
#include "pmbus_iic.h"	/* */
#include "xgpiops.h"	/* */
#include "xuartps.h"
#include "tm_esit.h"
#include "pm_esit.h"
#include "xil_cache.h"
#include <assert.h>

#define MEMADDR_SYNC  0x3fffff20
#define MEASURE_SYNC2 0x00000002
#define MEASURE_RESP  0x00000004
#define MEMADDR_RES   0x3Efff000
#define MEMADDR_DS1   0x30000000

#define MEASURE_REFERENCE	0
#define REFERENCE_SAMPLES	100
#define MAX_N_SAMPLES           1000


int main()
{
  /* init_platform(); */
  Xil_DCacheDisable();
  /* Xil_DCacheEnable(); */
  /* Xil_ICacheEnable(); */

  int status;
  /* Configure the IIC */
  status = setupIic();
  if(status != XST_SUCCESS) {
    xil_printf(" ERROR: Unable to configure IIC\n");
    return status;
  }

  /* Setup Memory */
  struct raw_uivalues_STR *raw_uivalues;
  struct raw_uivalues_STR *memaddr_ds1;
  volatile int *msync;
  memaddr_ds1=MEMADDR_DS1;
  assert(memaddr_ds1);
  msync = (void*)MEMADDR_SYNC;


  /* Wait */
#if !MEASURE_REFERENCE
  while (*msync != MEASURE_SYNC2){;};
#endif
  /* 1. Data Set */
  raw_uivalues = memaddr_ds1;
  unsigned sample_count = 0;
#if !MEASURE_REFERENCE
  for (; (*msync == MEASURE_SYNC2) && sample_count < MAX_N_SAMPLES; sample_count++)
#else
  for(sample_count= 0; sample_count < REFERENCE_SAMPLES; sample_count++)
#endif
  {
    /* Each measurement takes ~1.7ms */
    SaveUIValues(0, raw_uivalues);	//VccInt
    raw_uivalues += 1;
    SaveUIValues(1, raw_uivalues);	//VccAux
    raw_uivalues += 1;
    SaveUIValues(2, raw_uivalues);	//VADJ
    raw_uivalues += 1;
    SaveUIValues(3, raw_uivalues);	//VccADJ
    raw_uivalues += 1;
    SaveUIValues(4, raw_uivalues);	//Vcc3V3
    raw_uivalues += 1;
  }
  raw_uivalues = memaddr_ds1;
  wait_ms(20); // wait until the computation program on the other core exits to avoid simultaneous usage if the UART
  /* xil_printf("Output\n"); */

  float Ds_VccInt_SumVoltage = 0;
  double Ds_VccInt_SumCurrent = 0;
  double Ds_VccInt_SumPower   = 0;
  float Ds_VccAux_SumVoltage = 0;
  double Ds_VccAux_SumCurrent = 0;
  double Ds_VccAux_SumPower   = 0;
  float Ds_VccADJ_SumVoltage = 0;
  double Ds_VccADJ_SumCurrent = 0;
  double Ds_VccADJ_SumPower   = 0;
  float Ds_Vcc3V3_SumVoltage = 0;
  double Ds_Vcc3V3_SumCurrent = 0;
  double Ds_Vcc3V3_SumPower   = 0;  
  float Ds_Vcc1V5_SumVoltage = 0;
  double Ds_Vcc1V5_SumCurrent = 0;
  double Ds_Vcc1V5_SumPower   = 0;
  unsigned Ds_Number = 0;
  /*Calculate*/
  while (Ds_Number < sample_count)
  {
    SumUIValues(0, raw_uivalues, &Ds_VccInt_SumVoltage, &Ds_VccInt_SumCurrent, &Ds_VccInt_SumPower);	//VccInt
    raw_uivalues += 1;
    SumUIValues(1, raw_uivalues, &Ds_VccAux_SumVoltage, &Ds_VccAux_SumCurrent, &Ds_VccAux_SumPower);	//VccAux
    raw_uivalues += 1;
    SumUIValues(2, raw_uivalues, &Ds_Vcc1V5_SumVoltage, &Ds_Vcc1V5_SumCurrent, &Ds_Vcc1V5_SumPower);	//VADJ
    raw_uivalues += 1;
    SumUIValues(3, raw_uivalues, &Ds_VccADJ_SumVoltage, &Ds_VccADJ_SumCurrent, &Ds_VccADJ_SumPower);	//VccADJ
    raw_uivalues += 1;
    SumUIValues(4, raw_uivalues, &Ds_Vcc3V3_SumVoltage, &Ds_Vcc3V3_SumCurrent, &Ds_Vcc3V3_SumPower);	//Vcc3V3
    raw_uivalues += 1;
    Ds_Number += 1;
  }
  float  *res = (float*)MEMADDR_RES;
  res[0] = Ds_Number;
  res[1] = Ds_VccInt_SumVoltage / Ds_Number;
  res[2] = Ds_VccInt_SumCurrent / Ds_Number;
  res[3] = Ds_VccInt_SumPower / Ds_Number;
  res[4] = Ds_VccAux_SumVoltage / Ds_Number;
  res[5] = Ds_VccAux_SumCurrent / Ds_Number;
  res[6] = Ds_VccAux_SumPower / Ds_Number;
  res[7] = Ds_VccADJ_SumVoltage / Ds_Number;
  res[8] = Ds_VccADJ_SumCurrent / Ds_Number;
  res[9] = Ds_VccADJ_SumPower / Ds_Number;
  res[10] = Ds_Vcc3V3_SumVoltage / Ds_Number;
  res[11] = Ds_Vcc3V3_SumCurrent / Ds_Number;
  res[12] = Ds_Vcc3V3_SumPower / Ds_Number;
  res[13] = Ds_Vcc1V5_SumVoltage / Ds_Number;
  res[14] = Ds_Vcc1V5_SumCurrent / Ds_Number;
  res[15] = Ds_Vcc1V5_SumPower / Ds_Number;
  REG_WRITE(MEMADDR_SYNC, MEASURE_RESP);
  *msync = MEASURE_RESP;
  Xil_DCacheFlushRange((unsigned)MEMADDR_SYNC, 4);
  Xil_DCacheFlushRange((unsigned)res, 16*sizeof(float));
  Xil_DCacheFlush();

  /*Print*/
  /* xil_printf("\nAverage Values: Data Set 1 (#%d)\n",Ds_Number); */
  /* xil_printf("VccInt-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n\r", (Ds_VccInt_SumVoltage / Ds_Number), (Ds_VccInt_SumCurrent / Ds_Number), (Ds_VccInt_SumPower / Ds_Number)); */
  /* printf("VccAux-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccAux_SumVoltage / Ds_Number), (Ds_VccAux_SumCurrent / Ds_Number), (Ds_VccAux_SumPower / Ds_Number)); */
  /* printf("VccADJ-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccADJ_SumVoltage / Ds_Number), (Ds_VccADJ_SumCurrent / Ds_Number), (Ds_VccADJ_SumPower / Ds_Number)); */
  /* printf("Vcc3V3-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_Vcc3V3_SumVoltage / Ds_Number), (Ds_Vcc3V3_SumCurrent / Ds_Number), (Ds_Vcc3V3_SumPower / Ds_Number)); */
  /* printf("Vcc1V5-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_Vcc1V5_SumVoltage   / Ds_Number), (Ds_Vcc1V5_SumCurrent   / Ds_Number), (Ds_Vcc1V5_SumPower   / Ds_Number)); */
  /* printf("Total->                              P: %f W\n",((Ds_VccInt_SumPower / Ds_Number)+(Ds_VccAux_SumPower / Ds_Number)+(Ds_VccADJ_SumPower / Ds_Number)+(Ds_Vcc3V3_SumPower / Ds_Number)+(Ds_Vcc1V5_SumPower   / Ds_Number))); */

  /**** Exit ****/
  /* cleanup_platform(); */
  return 0;
}
