/*
 * aux_functions.h
 *
 *  Created on: May 7, 2016
 *      Author: muhammed
 */

#ifndef AUX_FUNCTIONS_H_
#define AUX_FUNCTIONS_H_

#include "assert.h"
#include "xil_types.h"
#include "platform.h"
#include <complex.h>
#include <math.h>

typedef enum {  copy_word_kernel, copy_half_kernel, copy_byte_kernel,
        vec_add_kernel, vec_add_half_kernel, vec_add_byte_kernel,
        vec_mul_kernel, vec_mul_half_kernel, vec_mul_byte_kernel,
        transpose_kernel, transpose_half_kernel, transpose_byte_kernel,
        sra_half_kernel, srl_half_kernel, sra_byte_kernel, srl_byte_kernel,
        fir_kernel, fir_half_kernel, fir_byte_kernel,
        matrix_multiply_kernel, matrix_multiply_half_kernel, matrix_multiply_byte_kernel,
        cross_correlation_kernel, cross_correlation_half_kernel, cross_correlation_byte_kernel,
        sharpen_kernel, sharpen_half_kernel, sharpen_byte_kernel,
        parallel_selection_kernel, parallel_selection_half_kernel, parallel_selection_byte_kernel,
        median_kernel, median_half_kernel, median_byte_kernel, sum_kernel, sum_half_kernel, sum_byte_kernel,
        max_word_kernel, max_half_kernel, max_byte_kernel,
        compass_edge_detection_kernel, compass_edge_detection_half_kernel, compass_edge_detection_byte_kernel,
        sharpen5x5_kernel, sharpen5x5_half_kernel, sharpen5x5_byte_kernel,
        sum_power_kernel, sum_power_half_kernel, sum_power_byte_kernel,
        div_kernel,
        add_float_kernel, mul_float_kernel, div_float_kernel, float_int_float_kernel,
        bitonicSort_kernel, bitonicSort_float_kernel, fft_kernel, nbody_iter_kernel} kernel_name;



unsigned int set_dimensions(kernel_name);
void compute_on_MB(kernel_name kernel, unsigned int *target_ptr, unsigned int *target2_ptr, unsigned int *first_param_ptr, unsigned int *second_param_ptr, unsigned int size, unsigned int size_d0, unsigned int size_d1);
void wait_ms(unsigned int time);

#endif /* AUX_FUNCTIONS_H_ */
