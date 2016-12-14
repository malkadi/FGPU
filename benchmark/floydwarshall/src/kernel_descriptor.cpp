#include "kernel_descriptor.hpp"

#define PRINT_ERRORS  1
extern unsigned int *code; // binary storde in code.c as an array

template<typename T>
kernel<T>::kernel(unsigned maxDim)
{
  param1 = new T[maxDim*maxDim];
  target_fgpu = new T[maxDim*maxDim];
  target_arm = new T[maxDim*maxDim];
  // param1= (float*) 0x10000000;
  // target_fgpu=  (float*)0x18000000;
  // target_arm=  (float*)0x1C000000;
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
  unsigned int size = FLOYDWARSHALL_LEN;
  if (typeid(T) == typeid(float))
    start_addr = FLOYDWARSHALLPASS_POS;
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
  lram_ptr[17] = (unsigned) passIndx;

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
  wg_size0 = 8;
  wg_size1 = 8;
  problemSize = Size*Size;
  offset0 = 0;
  nDim = 2;
  size0 = size1 = Size;
  passIndx = 0;
  dataSize = sizeof(T) * problemSize;

  compute_descriptor();

  offset0 = offset1 = offset2 = 0;
  nParams = 2; // number of parameters
}
template<typename T>
unsigned kernel<T>::get_problemSize() 
{
  return problemSize;
}
template<typename T>
void kernel<T>::initialize_memory()
{
  T *param_ptr = (T*) param1;
  for(unsigned i = 0; i < size0; i++)
    for(unsigned j = 0; j < size0; j++)
    {
      param_ptr[i*size0 + j]  = rand() >> 24;
      if(i == j)
        param_ptr[i*size0 + j]  = 0;
    }
  Xil_DCacheFlush(); // flush data to global memory
}
void FloydWarshall(unsigned n, float *mat) 
{
  unsigned i, j, k;
  float oldWeight, tempWeight;
  for ( k = 0; k < n; k++) {
    for ( i = 0; i < n; i++) {
      for ( j = 0; j < n; j++) {
        oldWeight = mat[j*n + i];
        tempWeight = mat[j*n + k] + mat[k*n + i];
        if (tempWeight < oldWeight)
            mat[j*n + i] = tempWeight;
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
    memcpy(target_arm, param1, dataSize);
    Xil_DCacheFlush();
    Xil_DCacheInvalidate();
    
    XTime_GetTime(&tStart);
    // for(unsigned i = 0; i < problemSize; i++) {
    //   printf("twiddles[%d]= %F + %Fj \n\r", i, creal(twiddles[i]), cimag(twiddles[i]));
    // }
    FloydWarshall(size0, target_arm);
    // for(unsigned i = 0; i < problemSize; i++) {
    //   printf("output[%d]= %F + %Fj \n\r", i, creal(target_arm[i]), cimag(target_arm[i]));
    // }
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
  Xil_DCacheInvalidate();
  // printf("original = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%4.0F ", param1[i*size0+j]);
  //   printf("\n");
  // }
  // printf("target_fgpu = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%4.0F ", target_fgpu[i*size0+j]);
  //   printf("\n");
  // }
  // printf("target_arm = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%4.0F ", target_arm[i*size0+j]);
  //   printf("\n");
  // }
  for (i = 0; i < problemSize; i++)
    if(target_arm[i] != target_fgpu[i])
    {
      #if PRINT_ERRORS
      if(nErrors < 10)
        cout << "res[" << i << "]=" << target_fgpu[i] << " must be(" << target_arm[i] << ")" << endl;
      #endif
      nErrors++;
    }
  if(nErrors != 0)
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
}
template<typename T>
void kernel<T>::update_and_download()
{
  if ( passIndx == size0-1) {
    passIndx = 0;
  } else {
    passIndx++;
  }
  lram_ptr[17] = passIndx;
  Xil_DCacheFlushRange((unsigned)lram_ptr, 32*4);
}
template<typename T>
unsigned kernel<T>::compute_on_FGPU(unsigned n_runs, bool check_results)
{
  unsigned runs = 0;
  XTime tStart, tEnd;
  unsigned exec_time = 0;


  REG_WRITE(INITIATE_REG_ADDR, 0xFFFF); // initiate FGPU when execution starts
  REG_WRITE(CLEAN_CACHE_REG_ADDR, 1); // do not clean FGPU cache at end of execution
  while(runs < n_runs)
  {
    passIndx = 0;
    download_descriptor();
    memcpy(target_fgpu, param1, dataSize);
    // for(unsigned i = 0; i < problemSize; i++) {
    //   printf("input[%d]= %F + %Fj \n\r", i, creal(target_fgpu[i]), cimag(target_fgpu[i]));
    // }
    // printf("After bitReverse:\n");
    // for(unsigned i = 0; i < problemSize; i++) {
    //   printf("input[%d]= %F + %Fj \n\r", i, creal(target_fgpu[i]), cimag(target_fgpu[i]));
    // }
    // printf("Before processing\n");
    // for(unsigned i = 0; i < problemSize; i++) {
    //   printf("target_fgpu[%d]= %F + %Fj \n\r", i, creal(target_fgpu[i]), cimag(target_fgpu[i]));
    // }
    // for(unsigned i = 0; i < problemSize; i++) {
    //   printf("twiddles[%d]= %F + %Fj \n\r", i, creal(twiddles[i]), cimag(twiddles[i]));
    // }
    // printf("\n");
    Xil_DCacheFlush();
    XTime_GetTime(&tStart);
    
    do
    {
      REG_WRITE(START_REG_ADDR, 1);
      while(REG_READ(STATUS_REG_ADDR)==0);
      update_and_download();
      // Xil_DCacheInvalidate();
      // for(unsigned i = 0; i < problemSize; i++) {
      //   printf("target_fgpu[%d]= %F + %Fj \n\r", i, creal(target_fgpu[i]), cimag(target_fgpu[i]));
      // }
      // printf("\n");
      // REG_WRITE(INITIATE_REG_ADDR, 0); // do not initiate FGPU for next iterations
      // if(stageIndx == nStages-1 && passIndx == nStages-1){
      //   REG_WRITE(CLEAN_CACHE_REG_ADDR, 1); // clean cache for the last iteration
      // }
    }while(passIndx != 0);
    
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
  xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is Floyd Warshall\n\r" ANSI_COLOR_RESET);
}

template class kernel<float>;
