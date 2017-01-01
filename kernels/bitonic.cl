#include "FGPUlib.c"
#include "comparesf2.c"
__kernel void bitonicSort_float(__global float *a, unsigned stage, unsigned passOfStage, unsigned direction)
{
    unsigned sortIncreasing = direction;
    unsigned index = get_global_id(0);
    
    unsigned pairDistance = 1 << (stage - passOfStage);
    unsigned blockWidth   = 2 * pairDistance;

    unsigned leftIndex = (index % pairDistance) + (index / pairDistance) * blockWidth;

    unsigned rightIndex = leftIndex + pairDistance;
    
    float leftElement = a[leftIndex];
    float rightElement = a[rightIndex];
    
    unsigned sameDirectionBlockWidth = 1 << stage;
    
    if((index/sameDirectionBlockWidth) % 2 == 1)
        sortIncreasing = 1 - sortIncreasing;

    float greater;
    float lesser;
    unsigned leftBigger = leftElement > rightElement;

    greater = leftBigger?leftElement:rightElement;
    lesser = leftBigger?rightElement:leftElement;
    
    leftElement = sortIncreasing ? lesser:greater;
    rightElement = sortIncreasing ? greater:lesser;
    
    a[leftIndex] = leftElement;
    a[rightIndex] = rightElement;
}
__kernel void bitonicSort(__global int *a, unsigned stage, unsigned passOfStage, unsigned direction)
{
    unsigned sortIncreasing = direction;
    unsigned index = get_global_id(0);
    
    unsigned pairDistance = 1 << (stage - passOfStage);
    unsigned blockWidth   = 2 * pairDistance;

    unsigned leftIndex = (index % pairDistance) + (index / pairDistance) * blockWidth;

    unsigned rightIndex = leftIndex + pairDistance;
    
    int leftElement = a[leftIndex];
    int rightElement = a[rightIndex];
    
    unsigned sameDirectionBlockWidth = 1 << stage;
    
    if((index/sameDirectionBlockWidth) % 2 == 1)
        sortIncreasing = 1 - sortIncreasing;

    int greater, lesser;
    unsigned leftBigger = leftElement > rightElement;
    greater = leftBigger?leftElement:rightElement;
    lesser = leftBigger?rightElement:leftElement;
    
    leftElement = sortIncreasing ? lesser:greater;
    rightElement = sortIncreasing ? greater:lesser;
    
    a[leftIndex] = leftElement;
    a[rightIndex] = rightElement;
}
