/******************************************************************************
*
* Copyright (C) 2010 - 2015 Xilinx, Inc.  All rights reserved.
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
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
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
#include "platform.h"
#include "platform_config.h"
volatile unsigned *msync = (unsigned* ) POWER_SYNC_ADDR;
volatile float *res = (float*) POWER_RESULTS;

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
void init_uart()
{
#ifdef STDOUT_IS_16550
    XUartNs550_SetBaud(STDOUT_BASEADDR, XPAR_XUARTNS550_CLOCK_HZ, UART_BAUD);
    XUartNs550_SetLineControlReg(STDOUT_BASEADDR, XUN_LCR_8_DATA_BITS);
#endif
    /* Bootrom/BSP configures PS7/PSU UART to 115200 bps */
}
void init_platform()
{
    /*
     * If you want to run this example outside of SDK,
     * uncomment one of the following two lines and also #include "ps7_init.h"
     * or #include "ps7_init.h" at the top, depending on the target.
     * Make sure that the ps7/psu_init.c and ps7/psu_init.h files are included
     * along with this example source files for compilation.
     */
    /* ps7_init();*/
    /* psu_init();*/
    enable_caches();
    init_uart();
}
unsigned toRep(float x) 
{
    const union { float f; unsigned i; } rep = {.f = x};
    return rep.i;
}
float fromRep(unsigned x) 
{
    const union { float f; unsigned i; } rep = {.i = x};
    return rep.f;
}
void
cleanup_platform()
{
    disable_caches();
}
u64 elapsed_time_us(XTime tStart, XTime tEnd)
{
  u64 time_elapsed = (tEnd - tStart)*1000000;
  time_elapsed /= COUNTS_PER_SECOND;
  return time_elapsed;
}

void power_measurement_set_idle() 
{
  *msync = 1;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
void power_measurement_start() 
{
  *msync = 2;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
void power_measurement_stop() 
{
  *msync = 3;
  Xil_DCacheFlushRange((unsigned) msync, 4);
}
void power_measurement_print_values() 
{
  printf("\nAverage Values: (#%d samples)\n", (unsigned) res[0]);
  printf("VccInt-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[1], res[2], res[3]);
  printf("VccAux-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[4], res[5], res[6]);
  printf("VccADJ-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[7], res[8], res[9]);
  printf("Vcc3V3-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[10], res[11], res[12]);
  printf("Vcc1V5-> U: %2.4fV ,  I: %2.4fA ,  P: %f W\n", res[13], res[14], res[15]);
  float total_power = res[3]+res[6]+res[9]+res[12]+res[15];
  printf("Total->                              P: %f W\n", total_power);
}
void power_measurement_wait_power_values() 
{
  xil_printf("\n\rWaiting for power values to be written from second core..\n\r");
  while(*msync != 4);
}
