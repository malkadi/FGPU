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

class kernel{
  // basic parameters
  unsigned size0, size1, size2;
  unsigned offset0, offset1, offset2;
  unsigned wg_size0, wg_size1, wg_size2;
  unsigned nParams, nDim;
  //calculated parameters
  unsigned size, n_wg0, n_wg1, n_wg2;
  unsigned wg_size;
  unsigned nWF_WG;
  unsigned start_addr;
  //extra info
  unsigned problemSize, dataSize;
  unsigned *param1, *target;
  public:
  kernel(unsigned max_size);
  ~kernel();
  void download_code();

};


void kernel_descriptor_compute_all_fields(kernel_descriptor *kdesc);
void kernel_descriptor_download(kernel_descriptor *kdesc);
void kernel_descriptor_prepare(kernel_descriptor *kdesc, unsigned int size_index);
void initialize_memory(kernel_descriptor *kdesc);
void kernel_code_download(kernel_descriptor *kdesc);


#endif /* KERNEL_DESCRIPTOR_H_ */
