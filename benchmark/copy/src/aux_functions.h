/*
 * aux_functions.h
 *
 *  Created on: 30.06.2015
 *      Author: muhammed
 */
#ifndef AUX_FUNCTIONS_H_
#define AUX_FUNCTIONS_H_

#define FGPU_BASEADDR         0x43C00000

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <complex.h>
#include <assert.h>
#include <sys/reent.h>
#include <xil_cache.h>
#include <xil_types.h>
#include <xtime_l.h>
#include "xparameters.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "assert.h"
#include "code.h"
#include "kernel_descriptor.h"
#include "definitions.h"
#include "FGPU_functions.h"

#define PRINT_ERRORS            0
#define MAX_PROBLEM_SIZE    256*1024

#define MAX(a, b)    ((a)>(b)?(a):(b))




// Macros
#define REG_READ(addr) \
    ({int val;int a=addr; asm volatile ("ldr   %0,[%1]\n" : "=r"(val) : "r"(a)); val;})

#define REG_WRITE(addr,val) \
    ({int v = val; int a = addr; __asm volatile ("str  %1,[%0]\n" :: "r"(a),"r"(v)); v;})



void check_FGPU_results(kernel_descriptor *kdesc);
void compute_on_ARM(kernel_descriptor *kdesc, unsigned int n_runs, unsigned int *exec_time);
void wait_ms(u64 time);
u64 elapsed_time_us(XTime tStart, XTime tEnd);



#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

#endif /* AUX_FUNCTIONS_H_ */
