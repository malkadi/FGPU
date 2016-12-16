#include "kernel_descriptor.hpp"
using namespace std;
extern unsigned int *code; // binary storde in code.c as an array

#define PRINT_ERRORS    1

template<typename T>
kernel<T>::kernel(unsigned max_size, bool vector_types, bool atomics)
{
  // The FGPU read wrong data from the dynamically allocated arrays
  // param1 = (T*)new int [max_size];
  // target_fgpu = (T*) new int[max_size];
  param1 = (T*) 0x10000000;
  target_fgpu = (T*) 0x18000000;

  target_arm = (T*)new unsigned[32];
  assert(target_arm != 0);
  assert(target_fgpu != 0);
  assert(param1 != 0);
  use_vector_types = vector_types;
  use_atomics = atomics;
  minReduceSize = 32;
  lram_ptr = (unsigned*)FGPU_BASEADDR;
}
template<typename T>
kernel<T>::~kernel() 
{
  // delete[] param1;
  // delete[] target_fgpu;
  // delete[] target_arm;
}
template<typename T>
void kernel<T>::download_code()
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = MAX_LEN;
  if(typeid(T) == typeid(float)){
    start_addr = MAX_FLOAT_POS;
  } else if(use_atomics) {
    if (typeid(T) == typeid(int))
      start_addr = MAX_ATOMIC_POS;
    else if (typeid(T) == typeid(short)) 
      if(use_vector_types)
        start_addr = MAX_HALF_IMPROVED_ATOMIC_POS;
      else
        start_addr = MAX_HALF_ATOMIC_POS;
    else if (typeid(T) == typeid(signed char))
      if(use_vector_types)
        start_addr = MAX_BYTE_IMPROVED_ATOMIC_POS;
      else
        start_addr = MAX_BYTE_ATOMIC_POS;
    else
      assert(0 && "unsupported type");
  } else {
    if (typeid(T) == typeid(int))
      start_addr = MAX_WORD_POS;
    else if (typeid(T) == typeid(short)) 
      if(use_vector_types)
        start_addr = MAX_HALF_IMPROVED_POS;
      else
        start_addr = MAX_HALF_POS;
    else if (typeid(T) == typeid(signed char))
      if(use_vector_types)
        start_addr = MAX_BYTE_IMPROVED_POS;
      else
        start_addr = MAX_BYTE_POS;
    else
      assert(0 && "unsupported type");
  }
  unsigned i = 0;
  for(; i < size; i++){
    cram_ptr[i] = code[i];
  }
  Xil_DCacheFlush();
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
  lram_ptr[16] = (unsigned) param1;
  lram_ptr[17] = (unsigned) target_fgpu;
  lram_ptr[18] = (unsigned) reduce_factor;
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
  size0 = Size;
  reduce_factor = 1;
  dataSize = sizeof(T) * problemSize;
  
  if(size0 < 64)
    wg_size0 = size0;

  compute_descriptor();

  offset0 = offset1 = offset2 = 0;
  nParams = 3; // number of parameters
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
  T *target_ptr = (T*) target_fgpu;
  for(i = 0; i < problemSize; i++) 
  {
    param_ptr[i] = (T)i;
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
    XTime_GetTime(&tStart);

    // parametrs accessed during computations should be cashed
    T *target_ptr = target_arm;
    T *param1_ptr = param1;
    unsigned Size = problemSize;
    if(typeid(T) == typeid(float)) {
      float res = 0;
      for(i = 0; i < Size; i++)
        res = param1_ptr[i]>res ? param1_ptr[i]:res;
      target_ptr[0] = res;
    } else {
      int res = 0;
      for(i = 0; i < Size; i++)
        res = param1_ptr[i]>res ? param1_ptr[i]:res;
      target_ptr[0] = res;
    }

    // flush the results to the global memory 
    Xil_DCacheFlushRange((unsigned)target_arm, 4);
    
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
  unsigned int nErrors = 0;
  volatile T *res_fgpu = (T*)lram_ptr[17];
  
  // for(unsigned i = 0; i < problemSize; i++)
  //   printf("@%d: %f\n", i, (float) param1[i]);
  // printf("res=%6.2f (must be %6.2f)\n\r", (float)res_fgpu[0], (float)target_arm[0]);

  
  // For floating point operations:
  // The results of ARM and FGPU will not match when large data arrays are proccessed
  // Therefore, we will tolreate a mismatch of up to 0.01% 
  if(typeid(T) == typeid(float)) {
    float upper = target_arm[0]*1.0001;
    float lower = target_arm[0]*0.9999;
    if(res_fgpu[0] < lower || res_fgpu[0] > upper) {
      if(PRINT_ERRORS && typeid(T) == typeid(float))
        printf("res=%6.2f (must be %6.2f)\n\r", (float)res_fgpu[0], (float)target_arm[0]);
      nErrors++;
    }
  } else {
    if(res_fgpu[0] != target_arm[0]) {
      if(PRINT_ERRORS && typeid(T) == typeid(float))
        xil_printf("res=0x%x (must be 0x%x)\n\r", res_fgpu[0], target_arm[0]);
      nErrors++;
    }
  }

  if(nErrors != 0)
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
  // else
  //   xil_printf("Memory check succeeded!\n\r", nErrors);
}
template<typename T>
bool kernel<T>::update_atomic_reduce_factor_and_download(unsigned rfactor)
{
  if( rfactor == 0 ||
      (use_vector_types && typeid(T) == typeid(short) && (problemSize/2 < rfactor || rfactor < 2)) ||
      (use_vector_types && typeid(T) == typeid(signed char) && (problemSize/4 < rfactor || rfactor < 4)) ||
      problemSize < rfactor
      )
    return false;

  size0 = problemSize/rfactor;
  reduce_factor = rfactor;
  wg_size0 = size0<64 ? size0:64;
  assert(size0%wg_size0 == 0);
  compute_descriptor();
  download_descriptor();
  Xil_DCacheFlush(); // flush data to global memory
  return true;
}
template<typename T>
bool kernel<T>::update_reduce_factor_and_download(unsigned rfactor, bool swap_arrays)
{
  if (size0 == 1 || 
      rfactor == 1 || 
      (use_vector_types && (typeid(T) == typeid(signed char)) && rfactor < 4) ){
    return false;
  } else if(  size0 < minReduceSize || 
              size0 <= rfactor ||
              (use_vector_types && (typeid(T) == typeid(signed char) && size0/rfactor < 4)) || 
              (use_vector_types && (typeid(T) == typeid(short) && size0/rfactor < 2 ))) {
    reduce_factor = size0;
    size0 = 1;
  } else {
    size0 /= rfactor;
    reduce_factor = rfactor;
  }
  assert(typeid(T) != typeid(signed char) || !use_vector_types || (reduce_factor >= 4 && reduce_factor%4 == 0));
  assert(typeid(T) != typeid(short) || !use_vector_types || (reduce_factor >= 2 && reduce_factor%2 == 0));
  wg_size0 = size0>32?32:size0;
  wg_size = wg_size0;
  n_wg0 = size0 / wg_size0;
  nWF_WG = wg_size / 64;
  if(wg_size % 64 != 0)
    nWF_WG++;
  size = size0;
  lram_ptr[0] = ((nWF_WG-1) << 28) | (0 << 14) | start_addr;
  lram_ptr[1] = size0;
  lram_ptr[7] = ((nDim-1) << 30) | wg_size0;
  lram_ptr[8] = n_wg0-1;
  lram_ptr[11] = (nParams << 28) | wg_size;
  if(swap_arrays) {
    unsigned int tmp = lram_ptr[16];
    lram_ptr[16] = lram_ptr[17];
    lram_ptr[17] = tmp;
  }
  lram_ptr[18] = reduce_factor;
  return true;
}
template<typename T>
bool kernel<T>::compute_without_atomics(unsigned n_runs, unsigned rfactor, unsigned &exec_time, bool check_results)
{
  XTime tStart, tEnd;
  unsigned runs = 0;
  exec_time = 0;
  size0 = problemSize;
  bool rfactor_allowed = (size0 > 1 && rfactor > 1 && (typeid(signed char) != typeid(T) || rfactor >= 4));
  if(!rfactor_allowed) {
    exec_time = -1;
    return false;
  }
  while(runs < n_runs)
  {
    initialize_memory();
    prepare_descriptor(problemSize); // resets original index space size and target addresses for a new computation round
    download_descriptor();
    rfactor_allowed = update_reduce_factor_and_download(rfactor, false);
    XTime_GetTime(&tStart);
    do
    {
      REG_WRITE(START_REG_ADDR, 1);
      while(REG_READ(STATUS_REG_ADDR)==0);
      rfactor_allowed = update_reduce_factor_and_download(rfactor, true);
    } while(rfactor_allowed);
    XTime_GetTime(&tEnd);
    exec_time += elapsed_time_us(tStart, tEnd);
    xil_printf(ANSI_COLOR_GREEN "." ANSI_COLOR_RESET);
    fflush(stdout);
    if (check_results)
      check_FGPU_results();
    runs++;
    if(exec_time > 1000000*MAX_MES_TIME_S)
      break;
  }
  exec_time /= runs;
  return rfactor_allowed;
}
template<typename T>
bool kernel<T>::compute_with_atomics(unsigned n_runs, unsigned rfactor, unsigned &exec_time, bool check_results)
{
  XTime tStart, tEnd;
  unsigned runs = 0;
  exec_time = 0;
  bool rfactor_allowed = update_atomic_reduce_factor_and_download(rfactor);
  // xil_printf("compute_with_atomics entered, rfactor = %d, rfactor_allowed = %d\n\r", rfactor, rfactor_allowed);
  while(rfactor_allowed && runs < n_runs)
  {
    initialize_memory();
    XTime_GetTime(&tStart);
    REG_WRITE(START_REG_ADDR, 1);
    while(REG_READ(STATUS_REG_ADDR)==0);
    XTime_GetTime(&tEnd);
    exec_time += elapsed_time_us(tStart, tEnd);
    xil_printf(ANSI_COLOR_GREEN "." ANSI_COLOR_RESET);
    fflush(stdout);
    runs++;
    if (check_results)
      check_FGPU_results();
    if(exec_time > 1000000*MAX_MES_TIME_S)
      break;
  }
  if(rfactor_allowed)
    exec_time /= runs;
  else
    exec_time = -1;
  return rfactor_allowed;
}
template<typename T>
unsigned kernel<T>::compute_on_FGPU(unsigned n_runs, bool check_results, unsigned &best_param)
{
  unsigned exec_time = 0;

  const unsigned rfactor_vec_len = 10;
  const unsigned rfactor_begin = 1;
  
  unsigned int exec_times[rfactor_vec_len];
  unsigned param_index = 0;
  unsigned int rfactor = rfactor_begin;

  REG_WRITE(INITIATE_REG_ADDR, 1); // initiate FGPU when execution starts
  REG_WRITE(CLEAN_CACHE_REG_ADDR, 1); // clean FGPU cache at end of execution
  for(param_index = 0; param_index < rfactor_vec_len; param_index++)
  {
    if(use_atomics && typeid(T) != typeid(float))
      compute_with_atomics(n_runs, rfactor, exec_times[param_index], check_results);
    else
      compute_without_atomics(n_runs, rfactor, exec_times[param_index], check_results);
    rfactor *= 2;
  }
  exec_time = exec_times[0];
  best_param = rfactor_begin;
  for(param_index = 1; param_index < rfactor_vec_len; param_index++){
    if(exec_time > exec_times[param_index]){
      exec_time = exec_times[param_index];
      best_param = rfactor_begin<<param_index;
    }
  }
  return exec_time;
}
template<typename T>
void kernel<T>::print_name()
{
  if(typeid(T) == typeid(float)) {
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is max float\n\r" ANSI_COLOR_RESET);
    return;
  }
  if( typeid(T) == typeid(int) )
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is max word" ANSI_COLOR_RESET);
  else if (typeid(T) == typeid(short))
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is max half word" ANSI_COLOR_RESET);
  else if (typeid(T) == typeid(signed char))
    xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is max byte" ANSI_COLOR_RESET);
  if (use_vector_types)
    xil_printf(" (vector types activated -");
  else
    xil_printf(" (vector types deactivated -");
  if (use_atomics)
    xil_printf(" atomics activated)\n\r");
  else
    xil_printf(" atomics deactivated)\n\r");
  xil_printf( ANSI_COLOR_RESET);
}

template class kernel<int>;
template class kernel<float>;
template class kernel<short>;
template class kernel<signed char>;
