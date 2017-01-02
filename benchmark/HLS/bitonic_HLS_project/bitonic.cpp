#include "math.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SOLUTION				2
#define UNROLL_W				6

void bitonic(float *array, unsigned problemSize, unsigned nStages) {
#pragma HLS INTERFACE m_axi port=array depth=16 offset=slave


#pragma HLS INTERFACE s_axilite port=return bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=problemSize bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=nStages bundle=AXI_LITE


#if SOLUTION == 1
	int pairDistance, blockWidth, leftIndex, rightIndex, sameDirectionBlock;
	float leftElement, rightElement;
	float greater, lesser;
	loop1: for(unsigned i = 0; i < nStages; i++) {
		sameDirectionBlock = 1 << i;
		loop2: for(unsigned j = 0; j < i+1; j++) {
			loop3: for(unsigned k = 0; k < problemSize/2; k++)
			{
				pairDistance = 1 << (i - j);
				blockWidth   = 2 * pairDistance;
				leftIndex = (k % pairDistance) + (k / pairDistance) * blockWidth;
				rightIndex = leftIndex + pairDistance;

				leftElement = array[leftIndex];
				rightElement = array[rightIndex];

				greater = leftElement>rightElement ? leftElement:rightElement;
				lesser = leftElement>rightElement ? rightElement:leftElement;

				unsigned flipDirection = (k/sameDirectionBlock) % 2 == 1;
				leftElement = flipDirection ? greater:lesser;
				rightElement = flipDirection ? lesser:greater;

				array[leftIndex] = leftElement;
				array[rightIndex] = rightElement;
			}
		}
	}
#elif SOLUTION == 2
int pairDistance, blockWidth, leftIndex, rightIndex, sameDirectionBlock;
	float leftElement, rightElement;
	float greater, lesser;
	unsigned subProblemSize = problemSize >> (UNROLL_W+1);
	loop1: for(unsigned i = 0; i < nStages; i++) {
		sameDirectionBlock = 1 << i;
		loop2: for(unsigned j = 0; j < i+1; j++) {
			loop3: for(unsigned k = 0; k < subProblemSize; k++) {
				loop4: for(unsigned m = 0; m < (1<<UNROLL_W); m++) {
					pairDistance = 1 << (i - j);
					blockWidth   = 2 * pairDistance;
					unsigned index = m+(k<<UNROLL_W);
					leftIndex = (index % pairDistance) + (index / pairDistance) * blockWidth;
					rightIndex = leftIndex + pairDistance;

					leftElement = array[leftIndex];
					rightElement = array[rightIndex];

					greater = leftElement>rightElement ? leftElement:rightElement;
					lesser = leftElement>rightElement ? rightElement:leftElement;

					unsigned flipDirection = (index/sameDirectionBlock) % 2 == 1;
					leftElement = flipDirection ? greater:lesser;
					rightElement = flipDirection ? lesser:greater;

					array[leftIndex] = leftElement;
					array[rightIndex] = rightElement;
				}
			}
		}
	}
#endif
}
