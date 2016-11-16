#include "kernel_descriptor.hpp"

#define PRINT_ERRORS            1

extern unsigned int *code; // binary storde in code.c as an array

template<typename T>
kernel<T>::kernel(unsigned maxDim)
{
  input = new T[maxDim*maxDim];
  amplitude_fgpu = new T[maxDim*maxDim];
  amplitude_arm = new T[maxDim*maxDim];
  angle_fgpu = new T[maxDim*maxDim];
  angle_arm = new T[maxDim*maxDim];
}
template<typename T>
kernel<T>::~kernel() 
{
  delete[] input;
  delete[] amplitude_fgpu;
  delete[] amplitude_arm;
  delete[] angle_fgpu;
  delete[] angle_arm;
}
template<typename T>
void kernel<T>::download_code()
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = COMPASS_EDGE_DETECTION_LEN;
  if (typeid(T) == typeid(unsigned))
    start_addr = COMPASS_EDGE_DETECTION_POS;
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
  lram_ptr[16] = (unsigned) input;
  lram_ptr[17] = (unsigned) amplitude_fgpu;
  lram_ptr[18] = (unsigned) angle_fgpu;
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
  nParams = 3; // number of parameters
}
template<typename T>
void kernel<T>::initialize_memory()
{
  unsigned i;
  T *input_ptr = (T*) input;
  T *amplitude_ptr = (T*) amplitude_fgpu;
  T *angle_ptr = (T*) angle_fgpu;
  srand(1);
  for(i = 0; i < problemSize; i++) 
  {
    // input_ptr[i] = i;
    input_ptr[i] = rand()&0x00FFFFFF;
    amplitude_ptr[i] = 0;
    angle_ptr[i] = 0;
  }
  Xil_DCacheFlush(); // flush data to global memory
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
    T *amplitude_ptr = amplitude_arm;
    T *angle_ptr = angle_arm;
    T *input_ptr = input;
    unsigned Size = size0;
    // printf("size0 = %d\n", Size);

    XTime_GetTime(&tStart);

    for(i = 1; i < Size-1; i++)
    {
      for(j = 1;j < Size-1; j++)
      {
          unsigned p00 = input_ptr[(i-1)*Size+j-1];
          unsigned p10 = input_ptr[i*Size+j-1];
          unsigned p20 = input_ptr[(i+1)*Size+j-1];
          unsigned p01 = input_ptr[(i-1)*Size+j];
          unsigned p11 = input_ptr[i*Size+j];
          unsigned p21 = input_ptr[(i+1)*Size+j];
          unsigned p02 = input_ptr[(i-1)*Size+j+1];
          unsigned p12 = input_ptr[i*Size+j+1];
          unsigned p22 = input_ptr[(i+1)*Size+j+1];
          
          int G[8] = {0};
          G[0] =  -1*p00 +0*p01 +1*p02 +
                  -2*p10 +0*p11 +2*p12 +
                  -1*p20 +0*p21 +1*p22;
          G[1] =  -2*p00 -1*p01 +0*p02 +
                  -1*p10 +0*p11 +1*p12 +
                  -0*p20 +1*p21 +2*p22;
          G[2] =  -1*p00 -2*p01 -1*p02 +
                  -0*p10 +0*p11 +0*p12 +
                  +1*p20 +2*p21 +1*p22;
          G[3] =  -0*p00 -1*p01 -2*p02 +
                  +1*p10 +0*p11 -1*p12 +
                  +2*p20 +1*p21 +0*p22;
          G[4] = -G[0];
          G[5] = -G[1];
          G[6] = -G[2];
          G[7] = -G[3];
          int max_index = 0, max_val = G[0], k;
          for(k = 1; k < 8; k++)
          {
            max_val = G[k] < max_val ? max_val:G[k];
            max_index = G[k] < max_val ? max_index:k;
          }

          amplitude_ptr[i*Size+j] = max_val;
          angle_ptr[i*Size+j] = max_index*45;
      }
    }

    // flush the results to the global memory 
    Xil_DCacheFlush();
    
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
  
  // xil_printf("\n\r");
  // for(i = 0; i < rowLen; i++){
  //   for(j = 0; j < rowLen; j++)
  //     xil_printf("%10x", param1[i*rowLen+j]);
  //   xil_printf("\n\r");
  // }


  for (i = 1; i < rowLen-1; i++) 
  {
    for (j = 1; j < rowLen-1; j++)
    {
      if(amplitude_arm[i*rowLen+j] != amplitude_fgpu[i*rowLen+j])
      {
        #if PRINT_ERRORS
        if(nErrors < 50)
          xil_printf("res[0x%x]=0x%x (must be 0x%x)\n\r", i*rowLen+j, (unsigned)amplitude_fgpu[i*rowLen + j], (unsigned) amplitude_arm[i*rowLen + j]);
        #endif
        nErrors++;
      }
      if(angle_arm[i*rowLen+j] != angle_fgpu[i*rowLen+j])
      {
        #if PRINT_ERRORS
        if(nErrors < 50)
          xil_printf("res[0x%x]=0x%x (must be 0x%x)\n\r", i*rowLen+j, (unsigned)angle_fgpu[i*rowLen + j], (unsigned) angle_arm[i*rowLen + j]);
        #endif
        nErrors++;
      }
    }
  }
  if(nErrors != 0) {
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
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
  xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is compass edge detection word\n\r" ANSI_COLOR_RESET);
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
