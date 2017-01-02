#include "math.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SOLUTION				3
#define MAXIMUM_FILTER_LEN		32
#define UNROLL_W				6

void fir(float *input, float *output, float *coeffs, unsigned filterLen, unsigned inputLen) {
#pragma HLS INTERFACE m_axi port=input depth=16 offset=slave
#pragma HLS INTERFACE m_axi port=output depth=16 offset=slave bundle=AXI_LITE
#pragma HLS INTERFACE m_axi port=coeffs depth=16 offset=slave bundle=AXI_LITE

#pragma HLS INTERFACE s_axilite port=return bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=filterLen bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=inputLen bundle=AXI_LITE

	float coeffs_buffered[MAXIMUM_FILTER_LEN];
	memcpy(coeffs_buffered, coeffs, sizeof(float)*filterLen);

#if SOLUTION == 1

	loop1: for(unsigned i = 0; i < inputLen; i++) {
		float acc = 0;
		loop2: for(unsigned j = 0; j < filterLen; j++) {
			acc += coeffs_buffered[j] * input[i+j];
		}
		output[i] = acc;
	}
#elif SOLUTION == 2

	loop1: for(unsigned i = 0; i < inputLen>>UNROLL_W; i++) {
		float input_buffered[(1<<UNROLL_W) + MAXIMUM_FILTER_LEN];
		memcpy(input_buffered, &input[i<<UNROLL_W], sizeof(float)*((1<<UNROLL_W)+filterLen));
		float output_buffered[1<<UNROLL_W];
		loop2: for(unsigned k = 0; k < (1<<UNROLL_W); k++) {
			float acc = 0;
			loop3: for(unsigned j = 0; j < filterLen; j++) {
				acc += coeffs_buffered[j] * input_buffered[k+j];
			}
			output_buffered[k] = acc;
		}
		memcpy(&output[i<<UNROLL_W], output_buffered, sizeof(float)<<UNROLL_W);
	}
#elif SOLUTION == 3
	//fixed filterLen and inputLen
	const unsigned constFilterLen = 12;
	const unsigned constInputLen = 8*1024;
	float input_buffered[constInputLen + constFilterLen];
	float output_buffered[constInputLen];
	float acc;
	memcpy(input_buffered, input, sizeof(float)*(constInputLen+constFilterLen));
	loop1: for(unsigned i = 0; i < constInputLen; i++) {
		loop2:for(unsigned j = 0; j < constFilterLen; j++) {
			if(j == 0)
				acc = 0;
			acc += coeffs_buffered[j] * input_buffered[i+j];
		}
		output_buffered[i] = acc;
	}
	memcpy(output, output_buffered, sizeof(float)*constInputLen);
#endif
}
