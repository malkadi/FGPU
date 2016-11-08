/*
 * FGPU_functions.h
 *
 *  Created on: Jun 14, 2016
 *      Author: muhammed
 */

#ifndef FGPU_FUNCTIONS_H_
#define FGPU_FUNCTIONS_H_

#include "aux_functions.h"
#include "kernel_descriptor.h"


void compute_on_FGPU(kernel_descriptor * kdesc, unsigned int n_runs, unsigned int *exec_time);

#endif /* FGPU_FUNCTIONS_H_ */
