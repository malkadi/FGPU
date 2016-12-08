/* pm_zc706.c
 *  Created on: 27.08.2015
 */

#include <stdio.h>		/* */
#include "platform.h"	/* */
#include "xil_printf.h"	/* */
#include "xstatus.h"	/* */
#include "pmbus_iic.h"	/* */
#include "xgpiops.h"	/* */
#include "xuartps.h"
#include "tm_esit.h"
#include "pm_esit.h"
#include "xil_cache.h"

#define MEMADDR_DS1   0x30000000		//OCM [0x0...0 to 0x0002ffff --> 191k addresses]
#define MEMADDR_SYNC  0x3fffff20
#define MEMADDR_END   0x3fffff00
#define MEASURE_SYNC1 0x00000001
#define MEASURE_SYNC2 0x00000002

#define MEASURE_REFERENCE	1
#define REFERENCE_SAMPLES	1000
/* Global definitions for peripheral driver instances
 */
XGpioPs gpio;

int setupGpio(void) {
    int status;
    XGpioPs_Config *gpioConfig;

    gpioConfig = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    status = XGpioPs_CfgInitialize(&gpio, gpioConfig, gpioConfig->BaseAddr);
    if(status != XST_SUCCESS) {
        return status;
    }

    /* Enable the LED pin and ensure that the LED is off */
    XGpioPs_SetDirectionPin(&gpio, LED_PIN, 0);
    XGpioPs_SetDirectionPin(&gpio, LED_PIN, 1);
    XGpioPs_SetOutputEnablePin(&gpio, LED_PIN, 1);
    XGpioPs_WritePin(&gpio, LED_PIN, 0);

    return XST_SUCCESS;
}

XUartPs uart;

int setupUart(void) {
    int status;
    XUartPs_Config *uartConfig;

    /* Initialize the PS UART driver */
    uartConfig = XUartPs_LookupConfig(XPAR_PS7_UART_1_DEVICE_ID);
    if(uartConfig == NULL) {
        xil_printf("ERROR: Unable to look up UART configuration\r\n");
        return XST_FAILURE;
    }

    status = XUartPs_CfgInitialize(&uart, uartConfig, uartConfig->BaseAddress);
    if(status != XST_SUCCESS) {
        xil_printf("ERROR: Unable to initialize UART driver\r\n");
        return status;
    }

    return XST_SUCCESS;
}


int main()
{
    init_platform();
	Xil_DCacheDisable();


    /**** Setup ****/

    int status;
    /* Configure the GPIOs */
    status = setupGpio();
    if(status != XST_SUCCESS) {
        xil_printf(" ERROR: Unable to configure GPIO\n");
        return status;
    }
    /* Configure the IIC */
    status = setupIic();
    if(status != XST_SUCCESS) {
        xil_printf(" ERROR: Unable to configure IIC\n");
        return status;
    }

    /* Configure the UART */
    status = setupUart();
    if(status != XST_SUCCESS) {
        xil_printf(" ERROR: Unable to configure UART\n\r");
        return status;
    }

    /* Setup Memory */
	struct raw_uivalues_STR *raw_uivalues;
	struct raw_uivalues_STR *memaddr_ds1;
	struct raw_uivalues_STR *memaddr_ds2;
	volatile int *msync;

	memaddr_ds1 = (void*)MEMADDR_DS1;
	msync = (void*)MEMADDR_SYNC;


    /**** Measurements ****/
#if MEASURE_REFERENCE
	xil_printf("\n\rMeasuring reference power consumption\n\r");
#else
    xil_printf("\n\rMeasure\n\r");
#endif
    fflush(stdout);
    /* Wait */
#if !MEASURE_REFERENCE
    while (*msync != MEASURE_SYNC1){;};
#endif
	/* 1. Data Set */
	raw_uivalues = memaddr_ds1;
#if !MEASURE_REFERENCE
    while ((*msync == MEASURE_SYNC1) && ((int)raw_uivalues < MEMADDR_END))
#else
    int sample_count;
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
    memaddr_ds1 = raw_uivalues;
#if !MEASURE_REFERENCE
    /* Wait */
    while (*msync != MEASURE_SYNC2){;};
	/* 2. Data Set */
    while ((*msync == MEASURE_SYNC2) && ((int)raw_uivalues < MEMADDR_END))
    {
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
    memaddr_ds2 = raw_uivalues;

    /**** Results ****/
#endif
    wait_ms(20); // wait until the computation program on the other core exits to avoid simultaneous usage if the UART
    xil_printf("Output\n");
    /* Common */

	/** 1. Data Set **/
    /*Initialize*/
	raw_uivalues = (void*)MEMADDR_DS1;
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
	float Ds_VAdj_SumVoltage = 0;
	double Ds_VAdj_SumCurrent = 0;
	double Ds_VAdj_SumPower   = 0;
	int Ds_Number = 0;
    /*Calculate*/
    while (raw_uivalues < memaddr_ds1)
    {
    	SumUIValues(0, raw_uivalues, &Ds_VccInt_SumVoltage, &Ds_VccInt_SumCurrent, &Ds_VccInt_SumPower);	//VccInt
		raw_uivalues += 1;
		SumUIValues(1, raw_uivalues, &Ds_VccAux_SumVoltage, &Ds_VccAux_SumCurrent, &Ds_VccAux_SumPower);	//VccAux
		raw_uivalues += 1;
		SumUIValues(2, raw_uivalues, &Ds_VAdj_SumVoltage, &Ds_VAdj_SumCurrent, &Ds_VAdj_SumPower);	//VADJ
		raw_uivalues += 1;
		SumUIValues(3, raw_uivalues, &Ds_VccADJ_SumVoltage, &Ds_VccADJ_SumCurrent, &Ds_VccADJ_SumPower);	//VccADJ
		raw_uivalues += 1;
		SumUIValues(4, raw_uivalues, &Ds_Vcc3V3_SumVoltage, &Ds_Vcc3V3_SumCurrent, &Ds_Vcc3V3_SumPower);	//Vcc3V3
		raw_uivalues += 1;

		Ds_Number += 1;
    }
    /*Print*/
    printf("\nAverage Values: Data Set 1 (#%d)\n",Ds_Number);
    printf("VccInt-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccInt_SumVoltage / Ds_Number), (Ds_VccInt_SumCurrent / Ds_Number), (Ds_VccInt_SumPower / Ds_Number));
    printf("VccAux-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccAux_SumVoltage / Ds_Number), (Ds_VccAux_SumCurrent / Ds_Number), (Ds_VccAux_SumPower / Ds_Number));
    printf("VccADJ-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccADJ_SumVoltage / Ds_Number), (Ds_VccADJ_SumCurrent / Ds_Number), (Ds_VccADJ_SumPower / Ds_Number));
    printf("Vcc3V3-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_Vcc3V3_SumVoltage / Ds_Number), (Ds_Vcc3V3_SumCurrent / Ds_Number), (Ds_Vcc3V3_SumPower / Ds_Number));
    printf("Vcc1V5-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VAdj_SumVoltage   / Ds_Number), (Ds_VAdj_SumCurrent   / Ds_Number), (Ds_VAdj_SumPower   / Ds_Number));
    printf("Total->                              P: %f W\n",((Ds_VccInt_SumPower / Ds_Number)+(Ds_VccAux_SumPower / Ds_Number)+(Ds_VccADJ_SumPower / Ds_Number)+(Ds_Vcc3V3_SumPower / Ds_Number)+(Ds_VAdj_SumPower   / Ds_Number)));
#if !MEASURE_REFERENCE
	/** 2. Data Set **/
    /*Initialize*/
	Ds_VccInt_SumVoltage = 0;
	Ds_VccInt_SumCurrent = 0;
	Ds_VccInt_SumPower   = 0;
	Ds_VccAux_SumVoltage = 0;
	Ds_VccAux_SumCurrent = 0;
	Ds_VccAux_SumPower   = 0;
	Ds_VccADJ_SumVoltage = 0;
	Ds_VccADJ_SumCurrent = 0;
	Ds_VccADJ_SumPower   = 0;
	Ds_Vcc3V3_SumVoltage = 0;
	Ds_Vcc3V3_SumCurrent = 0;
	Ds_Vcc3V3_SumPower   = 0;
	Ds_VAdj_SumVoltage = 0;
	Ds_VAdj_SumCurrent = 0;
	Ds_VAdj_SumPower   = 0;
	Ds_Number = 0;
    /*Calculate*/
    while (raw_uivalues < memaddr_ds2)
    {
    	SumUIValues(0, raw_uivalues, &Ds_VccInt_SumVoltage, &Ds_VccInt_SumCurrent, &Ds_VccInt_SumPower);	//VccInt
		raw_uivalues += 1;
		SumUIValues(1, raw_uivalues, &Ds_VccAux_SumVoltage, &Ds_VccAux_SumCurrent, &Ds_VccAux_SumPower);	//VccAux
		raw_uivalues += 1;
		SumUIValues(2, raw_uivalues, &Ds_VAdj_SumVoltage, &Ds_VAdj_SumCurrent, &Ds_VAdj_SumPower);	//VADJ
		raw_uivalues += 1;
		SumUIValues(3, raw_uivalues, &Ds_VccADJ_SumVoltage, &Ds_VccADJ_SumCurrent, &Ds_VccADJ_SumPower);	//VccADJ
		raw_uivalues += 1;
		SumUIValues(4, raw_uivalues, &Ds_Vcc3V3_SumVoltage, &Ds_Vcc3V3_SumCurrent, &Ds_Vcc3V3_SumPower);	//Vcc3V3
		raw_uivalues += 1;

		Ds_Number += 1;
    }
    /*Print*/
    printf("\nAverage Values: Data Set 2 (#%d)\n",Ds_Number);
    printf("VccInt-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccInt_SumVoltage / Ds_Number), (Ds_VccInt_SumCurrent / Ds_Number), (Ds_VccInt_SumPower / Ds_Number));
    printf("VccAux-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccAux_SumVoltage / Ds_Number), (Ds_VccAux_SumCurrent / Ds_Number), (Ds_VccAux_SumPower / Ds_Number));
    printf("VccADJ-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VccADJ_SumVoltage / Ds_Number), (Ds_VccADJ_SumCurrent / Ds_Number), (Ds_VccADJ_SumPower / Ds_Number));
    printf("Vcc3V3-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_Vcc3V3_SumVoltage / Ds_Number), (Ds_Vcc3V3_SumCurrent / Ds_Number), (Ds_Vcc3V3_SumPower / Ds_Number));
    printf("Vcc1V5-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", (Ds_VAdj_SumVoltage   / Ds_Number), (Ds_VAdj_SumCurrent   / Ds_Number), (Ds_VAdj_SumPower   / Ds_Number));
    printf("Total->                              P: %f W\n",((Ds_VccInt_SumPower / Ds_Number)+(Ds_VccAux_SumPower / Ds_Number)+(Ds_VccADJ_SumPower / Ds_Number)+(Ds_Vcc3V3_SumPower / Ds_Number)+(Ds_VAdj_SumPower   / Ds_Number)));
#endif

    /**** Exit ****/
    cleanup_platform();
    return 0;
}
