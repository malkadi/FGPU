#include "FGPUlib.c"

__kernel void nbody_iter(__global float4* pos, __global float4* vel, float deltaTime, float epsSqr
		,__global float4* newPosition, __global float4* newVelocity) {

    unsigned int gid = get_global_id(0);
    unsigned numBodies = get_global_size(0);
    float4 myPos = pos[gid];
    float4 acc = (float4)0.0f;

    unsigned i = 0;
    do {
        float4 p = pos[i];

        float4 r;
        r.xyz = p.xyz - myPos.xyz;
        float distSqr = r.x * r.x  +  r.y * r.y  +  r.z * r.z;

        float invDist = 1.0f / sqrtf(distSqr + epsSqr);
        float invDistCube = invDist * invDist * invDist;
        float s = p.w * invDistCube;

        // accumulate effect of all particles
        acc.xyz += s * r.xyz;
        i++;
    } while(i < numBodies);

    float4 oldVel = vel[gid];

    // updated position and velocity
    float4 newPos;
    newPos.xyz = myPos.xyz + oldVel.xyz * deltaTime + acc.xyz * 0.5f * deltaTime * deltaTime;

    float4 newVel;
    newVel.xyz = oldVel.xyz + acc.xyz * deltaTime;

    // write to global memory
    newPosition[gid] = newPos;
    newVelocity[gid] = newVel;
}
