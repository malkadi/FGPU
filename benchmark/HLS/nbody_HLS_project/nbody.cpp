#include "math.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SOLUTION		3

#if SOLUTION == 1
#define STREAM_W		0
#elif SOLUTION == 2
#define STREAM_W		4
#elif SOLUTION == 3
#define STREAM_W		6
#define UNROLL_W		6
#elif SOLUTION == 4
#define STREAM_W		6
#elif SOLUTION == 5
#define STREAM_W		5
#endif
void nbody_part(float *pos, unsigned numBodies, float myPosx, float myPosy, float myPosz,
		float &accx, float &accy, float &accz, float epsSqr)
{
	loop2:for(unsigned j = 0; j < (numBodies>>STREAM_W); j++)
	{
//#pragma HLS UNROLL factor=2
#pragma HLS LOOP_TRIPCOUNT min=32 max=64
#pragma HLS PIPELINE
		float posx, posy, posz, m;
		float posBuffer[4<<STREAM_W];
		loop_copy: for(unsigned l = 0; l < 4<<STREAM_W; l++)
			posBuffer[l] = pos[j*(1<<STREAM_W)+l];
		loop3: for(unsigned k = 0; k < (1<<STREAM_W); k++)
		{
			posx = posBuffer[k*4];
			posy = posBuffer[k*4+1];
			posz = posBuffer[k*4+2];
			m = posBuffer[k*4+3];
			float posDiffx, posDiffy, posDiffz;
			posDiffx = posx-myPosx;
			posDiffy = posx-myPosy;
			posDiffz = posx-myPosz;
			float distSqr;
			distSqr = posDiffx*posDiffx + posDiffy*posDiffy +posDiffz*posDiffz;
			float invDist;
			invDist = 1.0f/sqrtf(distSqr + epsSqr);
			float invDistCube = invDist * invDist * invDist;
			float s = m*invDistCube;
			// accumulate effect of all particles
			accx += s*posDiffx;
			accy += s*posDiffy;
			accz += s*posDiffz;
		}
	}
}

void nbody(
		float* pos,
		float* vel,
		float deltaTime,
		float epsSqr,
		unsigned numBodies,
		float* newPos,
		float* newVel) {
#pragma HLS INTERFACE m_axi port=pos depth=16 offset=slave bundle=AXI_LITE
#pragma HLS INTERFACE m_axi port=vel depth=16 offset=slave bundle=AXI_LITE
#pragma HLS INTERFACE m_axi port=newPos depth=16 offset=slave bundle=AXI_LITE
#pragma HLS INTERFACE m_axi port=newVel depth=16 offset=slave bundle=AXI_LITE

#pragma HLS INTERFACE s_axilite port=return bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=epsSqr bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=deltaTime bundle=AXI_LITE
#pragma HLS INTERFACE s_axilite port=numBodies bundle=AXI_LITE


#if SOLUTION == 3
	loop1:for(unsigned i = 0; i < numBodies>>UNROLL_W; i++)
	{
//#pragma HLS UNROLL factor=2
#pragma HLS PIPELINE
#pragma HLS LOOP_TRIPCOUNT min=512 max=1024
		loop4: for(unsigned u = 0; u < UNROLL_W; u++)
		{
			float myPosx, myPosy, myPosz;
			unsigned index = i<<UNROLL_W+u;
			myPosx = pos[index*4];
			myPosy = pos[index*4+1];
			myPosz = pos[index*4+2];
			float accx = 0, accy = 0, accz = 0;
			nbody_part(pos, numBodies, myPosx, myPosy, myPosz, accx, accy, accz, epsSqr);
			float myVelx, myVely, myVelz;
			myVelx = vel[index*4];
			myVely = vel[index*4+1];
			myVelz = vel[index*4+2];
			// updated position and velocity
			newPos[index*4] = myPosx + myVelx*deltaTime + accx*0.5f*deltaTime*deltaTime;
			newPos[index*4+1] = myPosy + myVely*deltaTime + accy*0.5f*deltaTime*deltaTime;
			newPos[index*4+2] = myPosz + myVelz*deltaTime + accz*0.5f*deltaTime*deltaTime;
			newVel[index*4] = myVelx + accx*deltaTime;
			newVel[index*4+1] = myVely + accy*deltaTime;
			newVel[index*4+2] = myVelz + accz*deltaTime;
		}

	}
#else
	loop1:for(unsigned i = 0; i < numBodies; i++)
	{
//#pragma HLS UNROLL factor=2
#pragma HLS PIPELINE
#pragma HLS LOOP_TRIPCOUNT min=512 max=1024
		float myPosx, myPosy, myPosz;
		myPosx = pos[i*4];
		myPosy = pos[i*4+1];
		myPosz = pos[i*4+2];
		float accx = 0, accy = 0, accz = 0;
		loop2:for(unsigned j = 0; j < (numBodies>>STREAM_W); j++)
		{
//#pragma HLS UNROLL factor=2
#pragma HLS LOOP_TRIPCOUNT min=32 max=64
#pragma HLS PIPELINE rewind
			float posx, posy, posz, m;
			float posBuffer[4<<STREAM_W];
			memcpy(posBuffer, &pos[j*(1<<STREAM_W)], 4*sizeof(float)<<STREAM_W);
			loop3: for(unsigned k = 0; k < (1<<STREAM_W); k++)
			{
				posx = posBuffer[k*4];
				posy = posBuffer[k*4+1];
				posz = posBuffer[k*4+2];
				m = posBuffer[k*4+3];
				float posDiffx, posDiffy, posDiffz;
				posDiffx = posx-myPosx;
				posDiffy = posx-myPosy;
				posDiffz = posx-myPosz;
				float distSqr;
				distSqr = posDiffx*posDiffx + posDiffy*posDiffy +posDiffz*posDiffz;
				float invDist;
				invDist = 1.0f/sqrtf(distSqr + epsSqr);
				float invDistCube = invDist * invDist * invDist;
				float s = m*invDistCube;
				// accumulate effect of all particles
				accx += s*posDiffx;
				accy += s*posDiffy;
				accz += s*posDiffz;
			}
		}
		float myVelx, myVely, myVelz;
		myVelx = vel[i*4];
		myVely = vel[i*4+1];
		myVelz = vel[i*4+2];
		// updated position and velocity
		newPos[i*4] = myPosx + myVelx*deltaTime + accx*0.5f*deltaTime*deltaTime;
		newPos[i*4+1] = myPosy + myVely*deltaTime + accy*0.5f*deltaTime*deltaTime;
		newPos[i*4+2] = myPosz + myVelz*deltaTime + accz*0.5f*deltaTime*deltaTime;
		newVel[i*4] = myVelx + accx*deltaTime;
		newVel[i*4+1] = myVely + accy*deltaTime;
		newVel[i*4+2] = myVelz + accz*deltaTime;

	}
#endif
}
