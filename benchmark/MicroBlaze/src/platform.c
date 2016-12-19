/******************************************************************************
*
* Copyright (C) 2010 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* XILINX CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

#include "xparameters.h"
#include "xil_cache.h"
#include "assert.h"
#include "platform.h"

/*
 * Uncomment the following line if ps7 init source files are added in the
 * source directory for compiling example outside of SDK.
 */
/*#include "ps7_init.h"*/

#ifdef STDOUT_IS_16550
 #include "xuartns550_l.h"

 #define UART_BAUD 9600
#endif

void enable_caches()
{
#ifdef __PPC__
    Xil_ICacheEnableRegion(CACHEABLE_REGION_MASK);
    Xil_DCacheEnableRegion(CACHEABLE_REGION_MASK);
#elif __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheEnable();
#endif
#endif
}

void disable_caches()
{
    Xil_DCacheDisable();
    Xil_ICacheDisable();
}

void init_platform()
{
    /*
     * If you want to run this example outside of SDK,
     * uncomment the following line and also #include "ps7_init.h" at the top.
     * Make sure that the ps7_init.c and ps7_init.h files are included
     * along with this example source files for compilation.
     */
    /* ps7_init();*/
    enable_caches();
}

void cleanup_platform()
{
    disable_caches();
}


void XUartChanged_SendByte(u32 BaseAddress, u8 Data)
{
		/*
		 * Wait until there is space in TX FIFO
		 */
		while (XUartChanged_IsTransmitFull(BaseAddress));

		/*
		 * Write the byte into the TX FIFO
		 */
		X_mWriteReg(BaseAddress, 0x30, Data);
}

void outbyte(char c) {
	 XUartChanged_SendByte(0xE0001000, c);
}

void ChangedPrint(char *ptr)
{
  while (*ptr) {
    outbyte (*ptr++);
  }
}

u64 elapsed_time_us()
{
	u64 elapsed_time_us = 0;
	unsigned int timer_upper = XTmrCtr_GetValue(&TimerCounter, 1);
	unsigned int timer_lower = XTmrCtr_GetValue(&TimerCounter, 0);
	timer_upper = XTmrCtr_GetValue(&TimerCounter, 1);
	timer_lower = XTmrCtr_GetValue(&TimerCounter, 0);
	elapsed_time_us = timer_upper;
	elapsed_time_us <<= 32;
	elapsed_time_us += timer_lower;
	elapsed_time_us /= 180;
	return elapsed_time_us;
}

void timer_init(){
	int Status;
	Status = XTmrCtr_Initialize(&TimerCounter, 0);
	if (Status != XST_SUCCESS) {
		assert(0);
	}
	XTmrCtr_Stop(&TimerCounter, 0); //disable Timer 1
	XTmrCtr_Stop(&TimerCounter, 1); //disable Timer 1
	XTmrCtr_Reset(&TimerCounter, 0);
	XTmrCtr_Reset(&TimerCounter, 1);
	XTmrCtr_SetResetValue(&TimerCounter, 0, 0); //write the lower 32-bit in the load register
	XTmrCtr_SetResetValue(&TimerCounter, 1, 0); //write the higher 32-bit in the load register
	XTmrCtr_SetOptions(&TimerCounter, 0, XTC_CASCADE_MODE_OPTION); //enable cascade mode
}
