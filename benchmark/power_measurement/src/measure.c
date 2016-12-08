/* measure.c
 *  Created on: 27.08.2015
 */

#include <stdio.h>		/* */
#include "xil_printf.h"	/* */
#include "pmbus_iic.h"	/* */
#include "pm_esit.h"


/** Structure for Voltage Rail Parameters**
 */
struct voltage_rail {
	char *name;
	unsigned char device;
	unsigned char page;
	double voltage;
	double average_current;
	double average_power;
	double temperature;
};

/** Array for ZC706 Voltage Rails **
 */
struct voltage_rail zc706_rails[] = {
			{
					name			: "VccInt     ",
					device			: DEV_U48_ADDRESS,
					page			: U48_VCCINT_PAGE,
					voltage 		: 0.0,
					average_current	: 0.0,
					average_power	: 0.0,
					temperature		: 0.0
			},
			{
					name			: "VccAux     ",
					device			: DEV_U48_ADDRESS,
					page			: U48_VCCAUX_PAGE,
					voltage 		: 0.0,
					average_current	: 0.0,
					average_power	: 0.0,
					temperature		: 0.0
			},
			{
					name			: "Vcc1V5_PL  ",
					device			: DEV_U48_ADDRESS,
					page			: U48_VCC1V5_PS_PAGE,
					voltage 		: 0.0,
					average_current	: 0.0,
					average_power	: 0.0,
					temperature		: 0.0
			},
			{
					name			: "Vadj_FPGA  ",
					device			: DEV_U48_ADDRESS,
					page			: U48_VADJ_PAGE,
					voltage 		: 0.0,
					average_current	: 0.0,
					average_power	: 0.0,
					temperature		: 0.0
			},
			{
					name			: "Vcc3V3_FPGA",
					device			: DEV_U48_ADDRESS,
					page			: U48_VCC3V3_PAGE,
					voltage 		: 0.0,
					average_current	: 0.0,
					average_power	: 0.0,
					temperature		: 0.0
			}
};


/** Array for ZC706 Voltage Rails **
 */
int measure(void)
{
	/** Initialize **
	 */
	xil_printf("pm: initialize\n");
	double power_total = 0.0f;
	double power_now = 0.0f;
	int num_measur = 1;
	int i;
	for(i = 0; i < (sizeof(zc706_rails) / sizeof(struct voltage_rail)); i++) {
		zc706_rails[i].average_power = 0;
		zc706_rails[i].average_current=0;
	}

	/** Read Values **
	 */
	xil_printf("pm: read values\n");
	float voltage;
	double current;
	for(i = 0; i < (sizeof(zc706_rails) / sizeof(struct voltage_rail)); i++) {
		voltage = readVoltage_real(zc706_rails[i].device, zc706_rails[i].page);
		current = readCurrent_real(zc706_rails[i].device, zc706_rails[i].page) ;

		/* ....
		 */
		switch(i) {
			case 0:
				zc706_rails[i].voltage = voltage * 0.00006103515625;	//VccInt	~1V		EXP=2^-14
				break;

			case 1:
				zc706_rails[i].voltage = voltage * 0.0001220703125;		//VccAux 	~1,8V	EXP=2^-13
				break;

			case 2:
				zc706_rails[i].voltage = voltage * 0.0001220703125; 	//Vcc1V5	~1,5V	EXP=2^-13
				break;

			case 3:
				zc706_rails[i].voltage = voltage * 0.0001220703125; 	//VADj		~2,5V	EXP=2^-13
				break;

			default:
				zc706_rails[i].voltage = voltage * 0.000244140625; 		//Vcc3V3 	~3,3V	EXP=2^-12
				break;
		}


		/* ...
		 */
		power_now = zc706_rails[i].voltage * current;
		power_total += power_now;

		zc706_rails[i].average_current += current / num_measur;
		zc706_rails[i].average_power += power_total / num_measur;

		printf("  \t%s - U[V]: %10.4f - I[A]: %10.4f - P[W]: %10.4f - P_avg[W]: %10.4f\n",zc706_rails[i].name, zc706_rails[i].voltage, current, power_now, zc706_rails[i].average_power);
	}

	/** Wait **
	 *//*
	int j,k;
	for(j=0;j<900000000;j++){
		for(k=0;k<100000000;k++){;}
	}*/
	xil_printf("\n");

	/** Exit **
	 */
	return 0;
}
