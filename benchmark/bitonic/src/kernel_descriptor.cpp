#include "kernel_descriptor.hpp"

#define PRINT_ERRORS  1
extern unsigned int *code; // binary storde in code.c as an array

template<typename T>
kernel<T>::kernel(unsigned max_size)
{
  param1 = new T[max_size];
  target_fgpu = new T[max_size];
  target_arm = new T[max_size];
  lram_ptr = (unsigned*) FGPU_BASEADDR;
}
template<typename T>
kernel<T>::~kernel() 
{
  delete[] param1;
  delete[] target_arm;
  delete[] target_fgpu;
}
template<typename T>
void kernel<T>::download_code()
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = BITONIC_LEN;
  if (typeid(T) == typeid(int))
    start_addr = BITONICSORT_POS;
  else
    assert(0 && "unsupported type");
  unsigned i = 0;
  for(; i < size; i++){
    cram_ptr[i] = code[i];
  }
}
template<typename T>
void kernel<T>::download_descriptor()
{
  int i;
  for(i = 0; i < 32; i++)
    lram_ptr[i] = 0;
  lram_ptr[0] = ((nWF_WG-1) << 28) | (0 << 14) | (start_addr);
  lram_ptr[1] = size0;
  lram_ptr[2] = size1;
  lram_ptr[3] = size2;
  lram_ptr[4] = offset0;
  lram_ptr[5] = offset1;
  lram_ptr[6] = offset2;
  lram_ptr[7] = ((nDim-1) << 30) | (wg_size2 << 20) | (wg_size1 << 10) | (wg_size0);
  lram_ptr[8] = n_wg0-1;
  lram_ptr[9] = n_wg1-1;
  lram_ptr[10] = n_wg2-1;
  lram_ptr[11] = (nParams << 28) | wg_size;
  lram_ptr[16] = (unsigned) target_fgpu;
  lram_ptr[17] = (unsigned) stageIndx;
  lram_ptr[18] = (unsigned) passIndx;
  lram_ptr[19] = 1; // sort increasing

}
template<typename T>
void kernel<T>::compute_descriptor()
{
  assert(wg_size0 > 0 && wg_size0 <= 512);
  assert(size0 % wg_size0 == 0);
  size = size0;
  wg_size = wg_size0;
  n_wg0 = size0 / wg_size0;
  if(nDim > 1)
  {
    assert(wg_size1 > 0 && wg_size1 <= 512);
    assert(size1 % wg_size1 == 0);
    size = size0 * size1;
    wg_size = wg_size0 * wg_size1;
    n_wg1 = size1 / wg_size1;
  }
  else
  {
    wg_size1 = n_wg1 = size1 = 0;
  }
  if(nDim > 2)
  {
    assert(wg_size2 > 0 && wg_size2 <= 512);
    assert(size2 % wg_size2 == 0);
    size = size0 * size1 * size2;
    wg_size = wg_size0 * wg_size1 * wg_size2;
    n_wg2 = size2 / wg_size2;
  }
  else
  {
    wg_size2 = n_wg2 = size2 = 0;
  }
  assert(wg_size <= 512);
  nWF_WG = wg_size / 64;
  if(wg_size % 64 != 0)
    nWF_WG++;
}
template<typename T>
void kernel<T>::prepare_descriptor(unsigned int Size)
{
  wg_size0 = 32;
  problemSize = Size;
  offset0 = 0;
  nDim = 1;
  size0 = Size/2;
  nStages = log2_int(problemSize);
  stageIndx = 0;
  passIndx = 0;
  if( typeid(T) == typeid(int)) {
    dataSize = 4 * problemSize; // 4 bytes per word
  }

  if(size0 < 32)
    wg_size0 = size0;

  compute_descriptor();

  offset0 = offset1 = offset2 = 0;
  nParams = 4; // number of parameters
}
template<typename T>
unsigned kernel<T>::get_problemSize() 
{
  return problemSize;
}
template<typename T>
void kernel<T>::initialize_memory()
{
  unsigned i;
  T *param_ptr = (T*) param1;
  T *target_fgpu_ptr = (T*) target_fgpu;
  T *target_arm_ptr = (T*) target_arm;
  for(i = 0; i < problemSize; i++) 
  {
    target_arm_ptr[i] = target_fgpu_ptr[i] = param_ptr[i] = (T)rand();
  }
  Xil_DCacheFlush(); // flush data to global memory
}
void bitonicSort(unsigned problemSize, int *array)
{
  unsigned i, j, k, nStages = 0;
  int pairDistance, blockWidth, leftIndex, rightIndex, leftElement, rightElement;
  unsigned sameDirectionBlock, greater, lesser;
  nStages = log2_int(problemSize);
  /* xil_printf("nStages = %d\n\r", nStages); */
  /* xil_printf("size = %d, problemSize = %d\n\r", size, problemSize); */
  /* for(i = 0; i < problemSize;  i++) */
  /*     xil_printf("first[%d]=%d, second[%d]=%d\n\r", i, first_param_ptr[i], i, second_param_ptr[i]); */
  for(i = 0; i < nStages; i++)
  {
    sameDirectionBlock = 1 << i;
    for(j = 0; j < i+1; j++) // #Passes = stage_index + 1
    {
      for(k = 0; k < problemSize/2; k++)
      {
        pairDistance = 1 << (i - j);
        blockWidth   = 2 * pairDistance;
        leftIndex = (k % pairDistance) + (k / pairDistance) * blockWidth;
        rightIndex = leftIndex + pairDistance;

        leftElement = array[leftIndex];
        rightElement = array[rightIndex];

        if(leftElement > rightElement)
        {
          greater = leftElement;
          lesser = rightElement;
        }
        else
        {
          greater = rightElement;
          lesser = leftElement;
        }
        if((k/sameDirectionBlock) % 2 == 1)
        { 
          //flip direction
          leftElement = greater;
          rightElement = lesser;
        }
        else
        {
          //same direction
          leftElement = lesser;
          rightElement = greater;
        }
        array[leftIndex] = leftElement;
        array[rightIndex] = rightElement;
      }
    }
  }
}
template<typename T>
unsigned kernel<T>::compute_on_ARM(unsigned int n_runs)
{
  unsigned exec_time = 0;
  unsigned runs = 0;

  XTime tStart, tEnd;
  while(runs < n_runs)
  {
    initialize_memory();
    Xil_DCacheFlush();
    Xil_DCacheInvalidate();
    XTime_GetTime(&tStart);

    bitonicSort(problemSize, target_arm);

    // flush the results to the global memory 
    Xil_DCacheFlushRange((unsigned)target_arm, dataSize);
    
    XTime_GetTime(&tEnd);
    exec_time += elapsed_time_us(tStart, tEnd);
    xil_printf(ANSI_COLOR_RED "." ANSI_COLOR_RESET);
    fflush(stdout);
    runs++;
    if(exec_time > 1000000*MAX_MES_TIME_S)
      break;
  }
  return exec_time/runs;
}
template<typename T>
void kernel<T>::check_FGPU_results()
{
  unsigned int i, nErrors = 0;
  // Xil_DCacheInvalidate();
  // xil_printf("problemSize = %d\n\r", problemSize);
  // for(i = 0; i < 8; i++) {
  //   printf("@%d: original = %d, arm = %d, fgpu = %d\n", i, param1[i], target_arm[i], target_fgpu[i]);
  // }
  for (i = 0; i < problemSize; i++)
    if(target_arm[i] != target_fgpu[i])
    {
      #if PRINT_ERRORS
        xil_printf("res[0x%x]=0x%x (must be 0x%x)\n\r", i, target_fgpu[i], target_arm[i]);
      #endif
      nErrors++;
    }
  if(nErrors != 0)
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
  // else
  //   xil_printf("Succeeded!\n\r");
}
template<typename T>
void kernel<T>::update_and_download()
{
  passIndx++;
  if(passIndx > stageIndx){
    passIndx = 0;
    stageIndx++;
  }
  if(stageIndx >= nStages) {
    size0 = 0;
  }
  lram_ptr[17] = stageIndx;
  lram_ptr[18] = passIndx;
  Xil_DCacheFlushRange((unsigned)lram_ptr, 32*4);
}
template<typename T>
unsigned kernel<T>::compute_on_FGPU(unsigned n_runs, bool check_results)
{
  unsigned runs = 0;
  XTime tStart, tEnd;
  unsigned exec_time = 0;

  REG_WRITE(INITIATE_REG_ADDR, 0xFFFF); // initiate FGPU when execution starts
  REG_WRITE(CLEAN_CACHE_REG_ADDR, 0); // do not clean FGPU cache at end of execution
  while(runs < n_runs)
  {
    download_descriptor();
    XTime_GetTime(&tStart);
    
    do
    {
      REG_WRITE(START_REG_ADDR, 1);
      while(REG_READ(STATUS_REG_ADDR)==0);
      update_and_download();
      REG_WRITE(INITIATE_REG_ADDR, 0); // do not initiate FGPU for next iterations
      if(stageIndx == nStages-1 && passIndx == nStages-1){
        REG_WRITE(CLEAN_CACHE_REG_ADDR, 1); // clean cache for the last iteration
      }
    }while(size0 > 0);
    
    XTime_GetTime(&tEnd);
    exec_time += elapsed_time_us(tStart, tEnd);
    
    if(check_results)
      check_FGPU_results();

    xil_printf(ANSI_COLOR_GREEN "." ANSI_COLOR_RESET);
    fflush(stdout);
    runs++;

    if(exec_time > 1000000*MAX_MES_TIME_S)// do not execute all required runs if it took too long
      break;
  }
  return exec_time/runs;
}
template<typename T>
void kernel<T>::print_name()
{
  if( typeid(T) == typeid(int) )
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is bitonic\n\r" ANSI_COLOR_RESET);
}

template class kernel<int>;
