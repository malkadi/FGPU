#ifndef PMBUS_IIC_H_
#define PMBUS_IIC_H_

#include "xiicps.h"
#include "math.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "xgpiops.h"

/* PMBUS Commands */
#define CMD_PAGE            0x00
#define CMD_OPERATION       0x01
#define CMD_VOUT_COMMAND    0x21
#define CMD_VOUT_MAX        0x24
#define CMD_READ_VOUT       0x8B
#define CMD_READ_IOUT       0x8C

/* Operating modes for operation command */
#define OP_MODE_NOM         0x80
#define OP_MODE_MAR_LOW     0x94
#define OP_MODE_MAR_HIGH    0xA4

/* ZC706-specific addresses */
#define DEV_U48_ADDRESS     101

#define U48_VCCINT_PAGE     0
#define U48_VCCAUX_PAGE     1
#define U48_VCC1V5_PS_PAGE  2
#define U48_VADJ_PAGE    	3
#define U48_VCC3V3_PAGE     4

/* ZC702-specific addresses */
#define DEV_U32_ADDRESS     52
#define DEV_U33_ADDRESS     53
#define DEV_U34_ADDRESS     54

#define U32_VCCINT_PAGE     0
#define U32_VCCPINT_PAGE    1
#define U32_VCCAUX_PAGE     2
#define U32_VCCPAUX_PAGE    3

#define U33_VADJ_PAGE       0
#define U33_VCC1V5_PS_PAGE  1
#define U33_VCCMIO_PS_PAGE  2
#define U33_VCCBRAM_PAGE    3

#define U34_VCC3V3_PAGE     0
#define U34_VCC2V5_PAGE     1

/* Control values for the IIC mux */
#define IIC_MUX_RESET_B_PIN	    13
#define IIC_MUX_ADDRESS		    0x74
#define IIC_MUX_CHANNEL_MASK    0x80

#define LED_PIN 10

/* Temporary definitions for the new usleep implementation to work around
 * bugs in the Cortex A9 clock frequency specification in xparameters.h
 */

#define CPU_CORTEXA9_CORE_CLOCK_FREQ_HZ 667000000
#define COUNTS_PER_SECOND1               (CPU_CORTEXA9_CORE_CLOCK_FREQ_HZ / 64)


/* Function Declarations */
unsigned int pmBusWrite(unsigned char address, unsigned char command, unsigned char data);
unsigned char pmBusWriteWord(unsigned  char address, unsigned char command, unsigned char *data);
unsigned int pmBusRead(unsigned char address, unsigned char command, unsigned char byteCount, unsigned char *buffer);
double linear11ToFloat(unsigned char highByte, unsigned char lowByte);
unsigned char readVoltage(unsigned char deviceAddress, unsigned char pageAddress, unsigned char *receiveBuf);
unsigned char readCurrent(unsigned char deviceAddress, unsigned char pageAddress, unsigned char *receiveBuf);
float readVoltage_real(unsigned char deviceAddress, unsigned char pageAddress);
double readCurrent_real(unsigned char deviceAddress, unsigned char pageAddress);

int ProgramVoltage(u8 DevAdrs, u8 PageAdrs, u8 *SendBufPtr, u8 Command);
void iicMuxReset(void);
int iicMuxSetup(unsigned char channelMask);
int setupIic(void);
int myusleep(unsigned int useconds);

#endif /* PMBUS_IIC_H_ */
