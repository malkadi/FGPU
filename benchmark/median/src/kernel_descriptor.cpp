#include "kernel_descriptor.hpp"

extern unsigned int *code; // binary storde in code.c as an array

template<typename T>
kernel<T>::kernel(unsigned maxDim)
{
  param1 = new T[maxDim*maxDim];
  target_fgpu = new T[maxDim*maxDim];
  target_arm = new T[maxDim*maxDim];
}
template<typename T>
kernel<T>::~kernel() 
{
  delete[] param1;
  delete[] target_fgpu;
  delete[] target_arm;
}
template<typename T>
void kernel<T>::download_code()
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = MEDIAN_LEN;
  if (typeid(T) == typeid(unsigned))
    start_addr = MEDIAN_POS;
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
  volatile unsigned* lram_ptr = (unsigned*)FGPU_BASEADDR;
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
  lram_ptr[16] = (unsigned) param1;
  lram_ptr[17] = (unsigned) target_fgpu;
}
template<typename T>
void kernel<T>::prepare_descriptor(unsigned int Size)
{
  wg_size0 = 8;
  wg_size1 = 8;
  rowLen = Size;
  problemSize = Size*Size;
  offset0 = 0;
  offset1 = 0;
  nDim = 2;
  size0 = Size;
  size1 = Size;
  dataSize = 4 * problemSize; // 4 bytes per word

  if(size0 < 8)
    wg_size0 = size0;
  if(size1 < 8)
    wg_size1 = size1;

  compute_descriptor();

  offset0 = offset1 = offset2 = 0;
  nParams = 2; // number of parameters
}
template<typename T>
void kernel<T>::initialize_memory()
{
  unsigned i;
  T *param1_ptr = (T*) param1;
  T *target_ptr = (T*) target_fgpu;
  for(i = 0; i < problemSize; i++) 
  {
    param1_ptr[i] = (T)i;
    target_ptr[i] = 0;
  }
  Xil_DCacheFlush(); // flush data to global memory
}
inline void swap(unsigned *a, unsigned *b)
{
  unsigned tmp = *a;
  *a = *b;
  *b = tmp;
}
inline void sort3(unsigned *a, unsigned *b, unsigned *c)
{
  if(*a > *b)
    swap(a, b);
  if(*b > *c)
    swap(b, c);
  if(*a > *b)
    swap(a, b);
}
template<typename T>
unsigned kernel<T>::compute_on_ARM(unsigned int n_runs)
{
  unsigned i, j;
  unsigned exec_time = 0;
  unsigned runs = 0;

  XTime tStart, tEnd;
  while(runs < n_runs)
  {
    initialize_memory();
    Xil_DCacheFlush();
    Xil_DCacheInvalidate();

    // parametrs accessed during computations should be cashed
    T *target_ptr = target_arm;
    T *param1_ptr = param1;
    unsigned Size = size0;

    XTime_GetTime(&tStart);

    for(j = 1; j < Size-1; j++)
    {
      for(i = 1;i < Size-1; i++)
      {
          unsigned p00 = param1_ptr[(j-1)*Size+i-1];
          unsigned p01 = param1_ptr[j*Size+i-1];
          unsigned p02 = param1_ptr[(j+1)*Size+i-1];
          unsigned p10 = param1_ptr[(j-1)*Size+i];
          unsigned p11 = param1_ptr[j*Size+i];
          unsigned p12 = param1_ptr[(j+1)*Size+i];
          unsigned p20 = param1_ptr[(j-1)*Size+i+1];
          unsigned p21 = param1_ptr[j*Size+i+1];
          unsigned p22 = param1_ptr[(j+1)*Size+i+1];
          sort3(&p00, &p01, &p02);
          sort3(&p10, &p11, &p12);
          sort3(&p20, &p21, &p22);
          sort3(&p00, &p10, &p20);
          sort3(&p01, &p11, &p21);
          sort3(&p02, &p12, &p22);
          sort3(&p00, &p11, &p22);
          target_ptr[j*Size+i] = p11;
      }
    }

    // flush the results to the global memory 
    // If the size of the data to be flushed exceeds half of the cache size, flush the whole cache. It is faster!
    if (dataSize > 16*1024)
      Xil_DCacheFlush();
    else
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
  unsigned i, j, nErrors = 0;
  
  for (i = 1; i < rowLen-1; i++)
    for (j = 1; j < rowLen-1; j++)
      if(target_arm[i*rowLen+j] != target_fgpu[i*rowLen+j])
      {
        if( typeid(T) == typeid(unsigned) ) {
          #if PRINT_ERRORS
            xil_printf("res[0x%x]=0x%x (must be 0x%x)\n\r", i, (unsigned)target_fgpu[i], (unsigned) target_arm[i]);
          #endif
        }
        nErrors++;
      }
  if(nErrors != 0) {
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
      if( typeid(T) != typeid(int) )
        xil_printf("WARNING: Overflow may cause some mismatch between ARM and FGPU results\n");
    }
}
template<typename T>
unsigned kernel<T>::compute_on_FGPU(unsigned n_runs, bool check_results)
{
  unsigned runs = 0;
  XTime tStart, tEnd;
  unsigned exec_time = 0;

  while(runs < n_runs)
  {
    initialize_memory();
    download_descriptor();
    REG_WRITE(INITIATE_REG_ADDR, 0xFFFF); // initiate FGPU when execution starts
    REG_WRITE(CLEAN_CACHE_REG_ADDR, 0xFFFF); // clean FGPU cache at end of execution
    
    XTime_GetTime(&tStart);
    REG_WRITE(START_REG_ADDR, 1);
    while(REG_READ(STATUS_REG_ADDR)==0);
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
  xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is median word\n\r" ANSI_COLOR_RESET);
}
template<typename T>
unsigned kernel<T>::get_problemSize() 
{
  return problemSize;
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

template class kernel<unsigned>;
