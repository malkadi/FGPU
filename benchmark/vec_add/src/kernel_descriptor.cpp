#include "kernel_descriptor.hpp"

extern unsigned int *code; // binary storde in code.c as an array

template<typename T>
kernel<T>::kernel(unsigned max_size, bool vector_types)
{
  param1 = new T[max_size];
  param2 = new T[max_size];
  target = new T[max_size];
  use_vector_types = vector_types;
}
template<typename T>
kernel<T>::~kernel() 
{
  delete[] param1;
  delete[] param2;
  delete[] target;
}
template<typename T>
void kernel<T>::download_code()
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = VEC_ADD_LEN;
  if (typeid(T) == typeid(unsigned))
    start_addr = VEC_ADD_POS;
  else if (typeid(T) == typeid(unsigned short)) 
    if(use_vector_types)
      start_addr = VEC_ADD_HALF_IMPROVED_POS;
    else
      start_addr = VEC_ADD_HALF_POS;
  else if (typeid(T) == typeid(unsigned char))
    if(use_vector_types)
      start_addr = VEC_ADD_BYTE_IMPROVED_POS;
    else
      start_addr = VEC_ADD_BYTE_POS;
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
  lram_ptr[17] = (unsigned) param2;
  lram_ptr[18] = (unsigned) target;
}
template<typename T>
void kernel<T>::prepare_descriptor(unsigned int Size)
{
  wg_size0 = 64;
  problemSize = Size;
  offset0 = 0;
  nDim = 1;
  size0 = Size;
  if( typeid(T) == typeid(unsigned)) {
    dataSize = 4 * problemSize; // 4 bytes per word
  }
  else if (typeid(T) == typeid(unsigned short)) {
    dataSize = 2 * problemSize; // 2 bytes per word
    if(use_vector_types)
      size0 = Size / 2;
  }
  else if (typeid(T) == typeid(unsigned char)) {
    dataSize = 1 * problemSize; // 1 bytes per word
    if(use_vector_types)
      size0 = Size / 4;
  }

  if(size0 < 64)
    wg_size0 = size0;

  compute_descriptor();

  offset0 = offset1 = offset2 = 0;
  nParams = 3; // number of parameters
}
template<typename T>
void kernel<T>::initialize_memory()
{
  unsigned i;
  T *param1_ptr = (T*) param1;
  T *param2_ptr = (T*) param2;
  T *target_ptr = (T*) target;
  for(i = 0; i < problemSize; i++) 
  {
    param2_ptr[i] = (T)i;
    param1_ptr[i] = (T)i;
    target_ptr[i] = 0;
  }
  Xil_DCacheFlush(); // flush data to global memory
}
template<typename T>
unsigned kernel<T>::compute_on_ARM(unsigned int n_runs)
{
  unsigned i;
  unsigned exec_time = 0;
  unsigned runs = 0;

  XTime tStart, tEnd;
  while(runs < n_runs)
  {
    initialize_memory();
    Xil_DCacheFlush();
    Xil_DCacheInvalidate();

    // parametrs accessed during computations should be cashed
    T *target_ptr = target;
    T *param1_ptr = param1;
    T *param2_ptr = param2;
    unsigned Size = problemSize;

    XTime_GetTime(&tStart);
    for(i = 0; i < Size; i++)
      target_ptr[i] = param1_ptr[i] + param2_ptr[i];

    // flush the results to the global memory 
    // If the size of the data to be flushed exceeds half of the cache size, flush the whole cache. It is faster!
    if (dataSize > 16*1024)
      Xil_DCacheFlush();
    else
      Xil_DCacheFlushRange((unsigned)target, dataSize);
    
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
  
  for (i = 0; i < problemSize; i++)
    if(target[i] != (T)(i+i))
    {
      #if PRINT_ERRORS
        xil_printf("res[0x%x]=0x%x (must be 0x%x)\n\r", i, (unsigned)target[i], (unsigned) i+i);
      #endif
      nErrors++;
    }
  if(nErrors != 0)
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
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
  if( typeid(T) == typeid(unsigned) )
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is vec_add word\n\r" ANSI_COLOR_RESET);
  else if (typeid(T) == typeid(unsigned short))
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is vec_add half word\n\r" ANSI_COLOR_RESET);
  else if (typeid(T) == typeid(unsigned char))
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is vec_add byte\n\r" ANSI_COLOR_RESET);
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
template class kernel<unsigned short>;
template class kernel<unsigned char>;
