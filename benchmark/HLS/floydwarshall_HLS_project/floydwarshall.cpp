#include "math.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define PARALLEL		6
#define SOLUTION		1
void floydwarshall(
		float* mat,
		unsigned n) {
#pragma HLS INTERFACE m_axi port=mat depth=16 offset=slave bundle=AXI_LITE


#pragma HLS INTERFACE s_axilite port=return bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=n bundle=AXI_LITE

#if SOLUTION == 1


	loop1: for ( unsigned k = 0; k < n; k++) {
		loop2: for ( unsigned j = 0; j < n; j++) {
			unsigned jn = j*n;
			unsigned kn = k*n;
			float mat_jk = mat[j*n + k];
			loop3: for ( unsigned i = 0; i < n; i++) {
				float oldWeight = mat[jn + i];
				float tempWeight = mat_jk + mat[kn + i];
				if (tempWeight < oldWeight)
					mat[jn + i] = tempWeight;
			}
	    }
	}
#elif SOLUTION == 2

	loop1: for ( unsigned k = 0; k < n; k++) {
		loop2: for ( unsigned j = 0; j < n; j++) {
			unsigned jn = j*n;
			unsigned kn = k*n;
			float mat_jk = mat[j*n + k];
			unsigned innerBound = n>>PARALLEL;
			loop3: for ( unsigned i = 0; i < innerBound; i++) {
				float oldWeight[1<<PARALLEL];
				memcpy(oldWeight, &mat[jn], (1<<PARALLEL)*sizeof(float));
				float tempWeight[1<<PARALLEL];
				memcpy(tempWeight, &mat[kn], (1<<PARALLEL)*sizeof(float));
				loop4: for(unsigned x = 0; x < (1<<PARALLEL); x++) {
					float tmp = mat_jk + tempWeight[i];
					if (tmp < oldWeight[i])
						mat[jn + i] = tmp;
				}
			}
	    }
	}
#elif SOLUTION == 3

		loop1: for ( unsigned k = 0; k < n; k++) {
			loop2: for ( unsigned j = 0; j < n; j++) {
				unsigned jn = j*n;
				unsigned kn = k*n;
				float mat_jk = mat[j*n + k];
				unsigned innerBound = n>>PARALLEL;
				loop3: for ( unsigned i = 0; i < innerBound; i++) {
					float oldWeight[1<<PARALLEL];
					memcpy(oldWeight, &mat[jn], (1<<PARALLEL)*sizeof(float));
					float tempWeight[1<<PARALLEL];
					memcpy(tempWeight, &mat[kn], (1<<PARALLEL)*sizeof(float));
					float res[1<<PARALLEL];
					loop4: for(unsigned x = 0; x < (1<<PARALLEL); x++) {
						float tmp = mat_jk + tempWeight[i];
						res[x] = tmp<oldWeight[i] ? tmp:oldWeight[i];
					}
					memcpy(&mat[jn], res, sizeof(float)*(1<<PARALLEL));
				}
		    }
		}
#endif
}
