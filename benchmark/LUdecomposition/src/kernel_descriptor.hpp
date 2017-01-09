/*
 * kernel_descriptor.h
 *
 *  Created on: 14 Jun 2016
 *      Author: muhammed
 */

#ifndef KERNEL_DESCRIPTOR_H_
#define KERNEL_DESCRIPTOR_H_

#include "code.h"
#include "code_hard_float.h"
#include "code_fadd_fmul_hard_float.h"
#include "aux_functions.hpp"
#include <typeinfo>

template<typename T>
class kernel{
  volatile unsigned *lram_ptr;
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
  unsigned passIndx;
  T *param1, *target_arm, *L_arm;
  T *target_fgpu, *L_fgpu;
  void compute_descriptor();
  void update_and_download();
  bool use_hard_float, use_fdiv_support;
public:
  kernel(unsigned max_size, bool hard_float, bool fdiv_support);
  ~kernel();
  void download_code();
  void download_descriptor();
  void prepare_descriptor(unsigned int Size);
  unsigned get_problemSize();
  unsigned compute_on_ARM(unsigned int n_runs);
  void initialize_memory();
  unsigned compute_on_FGPU(unsigned n_runs, bool check_results);
  void check_FGPU_results();
  void print_name();

};




#endif /* KERNEL_DESCRIPTOR_H_ */
