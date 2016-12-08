#include "pm_esit.h"
#include <stdio.h>

/*  */
/****************************************************************************
 * Variable: zc706rails
 * Description:  Data structure for ZC706 rails with PMBUS read values.
 ****************************************************************************/
struct raw_rail_STR zc706rails[] = {
			{
					name			      : "VccInt",
					device			    : DEV_U48_ADDRESS,
					page			      : U48_VCCINT_PAGE
			},
			{
					name			      : "VccAux",
					device			    : DEV_U48_ADDRESS,
					page			      : U48_VCCAUX_PAGE
			},
			{
					name			      : "Vcc1V5_PL",
					device			    : DEV_U48_ADDRESS,
					page			      : U48_VCC1V5_PS_PAGE
			},
			{
					name			      : "Vadj_FPGA",
					device			    : DEV_U48_ADDRESS,
					page			      : U48_VADJ_PAGE
			},
			{
					name			      : "Vcc3V3_FPGA",
					device			    : DEV_U48_ADDRESS,
					page			      : U48_VCC3V3_PAGE
			}
};
/****************************************************************************
 * Function: SaveUIValues
 * Description:  Requests the page of the device and ready voltage and
 *              current.
 *              The address for the value array is increased automatically.
 ****************************************************************************/
void SaveUIValues(u8 device_id, struct raw_uivalues_STR *raw_uivalues)
{
	#if ENABLE_DBGTM
	timer_init(TTC1_BASEADDRESS, TTC1_PRESCALAR);
	double timer_reading;
	#endif

	/* Voltage */
	int status;
	status = pmBusWrite(zc706rails[device_id].device, CMD_PAGE, zc706rails[device_id].page);
	if(status != XST_SUCCESS) {
		xil_printf("ERROR: pmBusWrite(voltage) failed.");
	}
	status = pmBusRead(zc706rails[device_id].device, CMD_READ_VOUT, 2, raw_uivalues->voltage);
	if(status != XST_SUCCESS) {
		xil_printf("ERROR: pmBusRead(voltage) failed.");
	}
	/* Current */
	status = pmBusWrite(zc706rails[device_id].device, CMD_PAGE, zc706rails[device_id].page);
	if(status != XST_SUCCESS) {
		xil_printf("ERROR: pmBusWrite(current) failed.");
	}
	status = pmBusRead(zc706rails[device_id].device, CMD_READ_IOUT, 2, raw_uivalues->current);
	if(status != XST_SUCCESS) {
		xil_printf("ERROR: pmBusRead(current) failed.");
	}

	#if ENABLE_DBGTM
	timer_reading = timer_read(TTC1_BASEADDRESS);
	timer_reading = timer_value(timer_reading, TTC1_PRESCALAR, XPAR_CPU_CORTEXA9_0_CLK_1X_FREQ_HZ);
	printf("T_measure = %f us\n", timer_reading);
	#endif
}


/****************************************************************************
 * Function: PrintUIValues
 * Description:
 ****************************************************************************/
void PrintUIValues(u8 device_id, struct raw_uivalues_STR *raw_uivalues)
{
	float voltage;
	double current;

	/* Calculate Voltage */
	voltage = (float)(u16)((raw_uivalues->voltage[0]) | (raw_uivalues->voltage[1]) << 8);

	switch(device_id) {
		case 0:
			voltage = voltage * 0.00006103515625;		//VccInt	~1V		EXP=2^-14
			printf("VccInt (1,0): U = %2.4f V ,  ",voltage);
			break;

		case 1:
			voltage = voltage * 0.0001220703125;		//VccAux 	~1,8V	EXP=2^-13
			printf("VccAux (1,8): U = %2.4f V ,  ",voltage);
			break;

		case 2:
			voltage = voltage * 0.0001220703125; 		//VADJ		~2,5V	EXP=2^-13
			printf("VADJ   (2,5): U = %2.4f V ,  ",voltage);
			break;

		case 3:
			voltage = voltage * 0.0001220703125; 		//Vcc1V5	~1,5V	EXP=2^-13
			printf("Vcc1V5 (1,5): U = %2.4f V ,  ",voltage);
			break;

		default:
			voltage = voltage * 0.000244140625; 		//Vcc3V3 	~3,3V	EXP=2^-12
			printf("Vcc3V3 (3,3): U = %2.4f V ,  ",voltage);
			break;
	}

	/* Calculate Current */
	current = linear11ToFloat((unsigned char)raw_uivalues->current[1],(unsigned char)raw_uivalues->current[0]);
	printf("I = %5.4f A",current);
	printf("\n");
}


/****************************************************************************
 * Function: SumUIValues
 * Description:
 ****************************************************************************/
void SumUIValues(u8 device_id, struct raw_uivalues_STR *raw_uivalues, float *Ds_SumVoltage, double *Ds_SumCurrent, double *Ds_SumPower)
{
	float voltage;
	double current;

	/* Calculate Voltage */
	voltage = (float)(u16)((raw_uivalues->voltage[0]) | (raw_uivalues->voltage[1]) << 8);
	switch(device_id) {
		case 0:
			voltage = voltage * 0.00006103515625;		//VccInt	~1V		EXP=2^-14
			break;

		case 1:
			voltage = voltage * 0.0001220703125;		//VccAux 	~1,8V	EXP=2^-13
			break;

		case 2:
			voltage = voltage * 0.0001220703125; 		//VADJ		~2,5V	EXP=2^-13
			break;

		case 3:
			voltage = voltage * 0.0001220703125; 		//Vcc1V5	~1,5V	EXP=2^-13
			break;

		default:
			voltage = voltage * 0.000244140625; 		//Vcc3V3 	~3,3V	EXP=2^-12
			break;
	}
	*Ds_SumVoltage = *Ds_SumVoltage + voltage;
	#if ENABLE_DBGPM
	printf("U = %2.4f V (%2.4f V),  ",voltage,*Ds_SumVoltage);
	#endif

	/* Calculate Current */
	current = linear11ToFloat((unsigned char)raw_uivalues->current[1],(unsigned char)raw_uivalues->current[0]);
	*Ds_SumCurrent = *Ds_SumCurrent + current;
	#if ENABLE_DBGPM
	printf("I = %2.4f A(%2.4f)",current,*Ds_SumCurrent);
	#endif

	/* Calculate Power */
	*Ds_SumPower = *Ds_SumPower + current * (double) voltage;
	#if ENABLE_DBGPM
	printf("P = %2.4f W\n",*Ds_SumPower);
	#endif
}
