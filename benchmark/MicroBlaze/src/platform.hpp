#ifndef __PLATFORM_H_
#define __PLATFORM_H_


#define STDOUT_IS_PS7_UART
#define UART_DEVICE_ID 0

#include "xil_io.h"
#include "xtmrctr.h"
#include "assert.h"
/* Write to memory location or register */
#define X_mWriteReg(BASE_ADDRESS, RegOffset, data) \
           *(unsigned volatile int *)(BASE_ADDRESS + RegOffset) =  ((unsigned volatile int) data);
/* Read from memory location or register */
#define X_mReadReg(BASE_ADDRESS, RegOffset) \
           *(unsigned volatile int *)(volatile)(BASE_ADDRESS + RegOffset);


#define XUartChanged_IsTransmitFull(BaseAddress)			 \
	((Xil_In32((BaseAddress) + 0x2C) & 	\
	 0x10) == 0x10)


void wait_ms(unsigned int time);
void init_platform();
void cleanup_platform();
void ChangedPrint(char *ptr);
void timer_init();
void tic();
void toc();
u64 elapsed_time_us();

#endif
