/*
 * kernel_descriptor.h
 *
 *  Created on: 14 Jun 2016
 *      Author: muhammed
 */

#ifndef KERNEL_DESCRIPTOR_H_
#define KERNEL_DESCRIPTOR_H_

#include "aux_functions.h"
#include "definitions.h"



void kernel_descriptor_compute_all_fields(kernel_descriptor *kdesc);
void kernel_descriptor_download(kernel_descriptor *kdesc);
void kernel_descriptor_prepare(kernel_descriptor *kdesc, unsigned int size_index);
void initialize_memory(kernel_descriptor *kdesc);
void kernel_code_download(kernel_descriptor *kdesc);


#endif /* KERNEL_DESCRIPTOR_H_ */
