#ifndef PM_ESIT_H_
#define PM_ESIT_H_


#define ENABLE_DBGTM 0
#define ENABLE_DBGPM 0


#include <xil_types.h>   	/* u8, ... */
#include <xil_assert.h>   	/* XST_SUCCESS, ... */
#include "tm_esit.h"		/* timing measurement */
#include "pmbus_iic.h"	    /* PMBUS and I2C */
#include "xil_printf.h"	  	/* xil_printf() */


/****************************************************************************
 * Macros
 ****************************************************************************/

/* Hardware */
#define TTC1_BASEADDRESS						0xf8002000
#define TTC1_PRESCALAR							15			//4 bit
#define XPAR_CPU_CORTEXA9_0_CLK_1X_FREQ_HZ		111111111

/* Read from address */
#define REG_READ(addr) \
    ({int val;int a=addr; asm volatile ("ldr   %0,[%1]\n" : "=r"(val) : "r"(a)); val;})

/* Write to address */
#define REG_WRITE(addr,val) \
    ({int v = val; int a = addr; __asm volatile ("str  %1,[%0]\n" :: "r"(a),"r"(v)); v;})


/****************************************************************************
 * Data Structures
 ****************************************************************************/

/* Measured Values */
struct raw_uivalues_STR {
	u8 voltage[2];
	u8 current[2];
};

/* Data Set */
struct zc706dataset_STR{
	float sum_voltage;
	double sum_current;
	int sum_datasets;
	float avg_voltage;
	double avg_current;
	double avg_power;
};

/* Raw Rail Parameters */
struct raw_rail_STR {
	const char *name;
	unsigned char device;
	unsigned char page;
};

/****************************************************************************
 * Function: SaveUIValues
 * Description:  Requests the page of the device and ready voltage and
 *              current.
 ****************************************************************************/
void SaveUIValues(u8 device_id, struct raw_uivalues_STR *raw_uivalues);


/****************************************************************************
 * Function: PrintUIValues
 * Description:
 ****************************************************************************/
void PrintUIValues(u8 device_id, struct raw_uivalues_STR *raw_uivalues);


/****************************************************************************
 * Function: SumUIValues
 * Description:
 ****************************************************************************/
void SumUIValues(u8 device_id, struct raw_uivalues_STR *raw_uivalues, float *Ds_SumVoltage, double *Ds_SumCurrent, double *Ds_SumPower);

#endif /* PM_ESIT_H_ */
