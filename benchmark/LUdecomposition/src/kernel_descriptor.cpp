#include "kernel_descriptor.hpp"

#define PRINT_ERRORS  0

extern unsigned *code; // binary storde in code.c as an array
extern unsigned *code_hard_float; // binary storde in code_hard_float.c as an array
extern unsigned *code_fadd_fmul_hard_float; // binary storde in code_fadd_fmul_hard_float.c as an array

template<typename T>
kernel<T>::kernel(unsigned maxDim, bool hard_float, bool fdiv_support)
{
  param1 = new T[maxDim*maxDim];
  target_fgpu = new T[maxDim*maxDim]();
  target_arm = new T[maxDim*maxDim]();
  L_fgpu = new T[maxDim*maxDim]();
  L_arm = new T[maxDim*maxDim]();
  assert(L_arm != 0);
  // param1= (float*) 0x11000000;
  // target_fgpu=  (float*)0x12000000;
  // target_arm=  (float*)0x13000000;
  // L_fgpu=  (float*)0x14000000;
  // L_arm=  (float*)0x15000000;
  lram_ptr = (unsigned*) FGPU_BASEADDR;
  use_hard_float = hard_float;
  use_fdiv_support = fdiv_support;
}
template<typename T>
kernel<T>::~kernel() 
{
  delete[] param1;
  delete[] target_arm;
  delete[] target_fgpu;
  delete[] L_fgpu;
  delete[] L_arm;
}
template<typename T>
void kernel<T>::download_code()
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = LUDECOMPOSITION_LEN;
  unsigned *code_ptr = code;
  if (typeid(T) == typeid(float)) {
    if(use_hard_float) {
      if(use_fdiv_support) {
        start_addr = LUDECOMPOSITION_PASS_HARD_FLOAT_POS;
        code_ptr = code_hard_float;
        size = LUDECOMPOSITION_HARD_FLOAT_LEN;
      } else {
        start_addr = LUDECOMPOSITION_L_PASS_FADD_FMUL_HARD_FLOAT_POS;
        code_ptr = code_fadd_fmul_hard_float;
        size = LUDECOMPOSITION_FADD_FMUL_HARD_FLOAT_LEN;
      }
    } else {
      start_addr = LUDECOMPOSITION_L_PASS_POS;
    }
  }
  else
    assert(0 && "unsupported type");

  for(unsigned i = 0; i < size; i++){
    cram_ptr[i] = code_ptr[i];
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
  lram_ptr[17] = (unsigned) L_fgpu;
  lram_ptr[18] = (unsigned) size0;
  lram_ptr[19] = (unsigned) passIndx;
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
  nDim = 2;
  size0 = size1 = Size;
  dataSize = sizeof(T) * problemSize;
  if(wg_size0 > Size)
    wg_size0 = wg_size1 = Size;
  
  compute_descriptor();

  passIndx = 0;
  offset0 = passIndx;// offset of k (the work-items @passIndx will write the L matrix), others will update U
  offset1 = passIndx+1;
  offset2 = 0;
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
  T *param_ptr = (T*) param1;
  for(unsigned i = 0; i < size0; i++)
    for(unsigned j = 0; j < size0; j++)
    {
      float tmpf = rand() >> 24;
      while(tmpf == 0)
        tmpf = rand() >> 24;
      param_ptr[i*size0 + j] = tmpf;
    }
  Xil_DCacheFlush(); 
}
void LUDecomposition(unsigned n, float *mat, float *L)
{
  unsigned i, j, k;
  for(k = 0; k < n-1; k++) {
    L[k*n + k] = 1;
    for(i = k+1; i < n; i++) {
      L[i*n + k] = mat[i*n + k] / mat[k*n + k];
      for(j = k+1; j < n; j++) {
        mat[i*n+j] -= L[i*n + k]*mat[k*n + j];
      }
    }
    // break;
  }
  // printf("LUDecomposition function result\n");
  // printf("U:\n");
  // for(i = 0; i < n; i++) {
  //   for(j = 0; j < n; j++) {
  //     printf("%9.2f", mat[i*n+j]);
  //   }
  //   printf("\n");
  // }
  // printf("L:\n");
  // for(i = 0; i < n; i++) {
  //   for(j = 0; j < n; j++) {
  //     printf("%9.2f", L[i*n+j]);
  //   }
  //   printf("\n");
  // }
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
    // Xil_DCacheInvalidate();
    
    XTime_GetTime(&tStart);
    LUDecomposition(size0, target_arm, L_arm);
    // flush the results to the global memory 
    Xil_DCacheFlushRange((unsigned)target_arm, dataSize);
    Xil_DCacheFlushRange((unsigned)L_arm, dataSize);
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
  unsigned nErrors = 0;
  // Xil_DCacheInvalidate();
  for (unsigned i = 0; i < size0; i++) {
    for(unsigned j = 0; j < size1; j++) {
      if(i >= j) {
        // L part
        if(L_arm[i*size0+j] != L_fgpu[i*size0+j])
        {
          #if PRINT_ERRORS
          if(nErrors < 10)
            cout << "L[" << i << "][" << j << "]=" << L_fgpu[i*size0+j] << " must be(" << L_arm[i*size0+j] << ")" << endl;
          #endif
          nErrors++;
        }
      } else {
        // U part
        if(target_arm[i*size0+j] != target_fgpu[i*size0+j])
        {
          #if PRINT_ERRORS
          if(nErrors < 10)
            cout << "U[" << i << "][" << j << "]=" << target_fgpu[i*size0+j] << " must be(" << target_arm[i*size0+j] << ")" << endl;
          #endif
          nErrors++;
        }
      }
    }
  }
  // printf("original = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%9.2F ", param1[i*size0+j]);
  //   printf("\n");
  // }
  // printf("target_fgpu = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%9.2f ", target_fgpu[i*size0+j]);
  //   printf("\n");
  // }
  // printf("target_arm = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%9.2F ", target_arm[i*size0+j]);
  //   printf("\n");
  // }
  // printf("L_fgpu = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%9.2F ", L_fgpu[i*size0+j]);
  //   printf("\n");
  // }
  // printf("L_arm = \n");
  // for(unsigned i = 0; i < size0; i++) {
  //   for(unsigned j = 0; j < size1; j++)
  //     printf("%9.2F ", L_arm[i*size0+j]);
  //   printf("\n");
  // }
  if(nErrors != 0)
    xil_printf("Memory check failed (nErrors = %d)!\n\r", nErrors);
}
template<typename T>
void kernel<T>::update_and_download()
{
  if ( 2 == size0) {
    passIndx = 0;
  } else {
    passIndx++;
    lram_ptr[4] = passIndx; // offset of k (the work-items @passIndx will write the L matrix), others will update U
    lram_ptr[5] = passIndx+1; 
    size0 -= 1; // no need to write this to lram_ptr
    size1 -= 1; // no need to write this to lram_ptr
    n_wg0 = size0 / wg_size0;
    if(size0 % wg_size0 != 0)
      n_wg0++;
    lram_ptr[8] = n_wg0-1;
    n_wg1 = size1 / wg_size1;
    if(size1 % wg_size1 != 0)
      n_wg1++;
    lram_ptr[9] = n_wg1-1;
    lram_ptr[19] = passIndx;
  }
  // Xil_DCacheFlushRange((unsigned) lram_ptr, 32*4);
}
template<typename T>
unsigned kernel<T>::compute_on_FGPU(unsigned n_runs, bool check_results)
{
  unsigned runs = 0;
  XTime tStart, tEnd;
  unsigned exec_time = 0;
  unsigned size0_buffer = size0;


  REG_WRITE(INITIATE_REG_ADDR, 0xFFFF); // initiate FGPU when execution starts
  REG_WRITE(CLEAN_CACHE_REG_ADDR, 1); // do not clean FGPU cache at end of execution
  while(runs < n_runs)
  {
    size0 = size1 = size0_buffer; // reset size0 and size1
    passIndx = 0;
    offset0 = passIndx;// offset of k (the work-items @passIndx will write the L matrix), others will update U
    offset1 = passIndx+1;
    compute_descriptor();
    download_descriptor();
    memcpy((void*)target_fgpu, param1, dataSize);
    Xil_DCacheFlush();
    // printf("original = \n");
    // for(unsigned i = 0; i < size0; i++) {
    //   for(unsigned j = 0; j < size1; j++)
    //     printf("%9.2F ", param1[i*size0+j]);
    //   printf("\n");
    // }
    XTime_GetTime(&tStart);

    if(use_hard_float && use_fdiv_support) {
      do
      {
        REG_WRITE(START_REG_ADDR, 1);
        while(REG_READ(STATUS_REG_ADDR)==0);
        update_and_download();
      }while(passIndx != 0);
    }
    else {
      do
      {
        nDim = 1;
        lram_ptr[7] = ((nDim-1) << 30) | (wg_size2 << 20) | (wg_size1 << 10) | (wg_size0);
        REG_WRITE(START_REG_ADDR, 1);
        while(REG_READ(STATUS_REG_ADDR)==0);
        if(use_hard_float && !use_fdiv_support)
          start_addr = LUDECOMPOSITION_U_PASS_FMUL_FADD_HARD_FLOAT_POS;
        else
          start_addr = LUDECOMPOSITION_U_PASS_POS;
        lram_ptr[0] = ((nWF_WG-1) << 28) | (0 << 14) | (start_addr);
        nDim = 2;
        lram_ptr[7] = ((nDim-1) << 30) |  (wg_size1 << 10) | (wg_size0);
        REG_WRITE(START_REG_ADDR, 1);
        while(REG_READ(STATUS_REG_ADDR)==0);
        if(use_hard_float && !use_fdiv_support)
          start_addr = LUDECOMPOSITION_L_PASS_FADD_FMUL_HARD_FLOAT_POS;
        else
          start_addr = LUDECOMPOSITION_L_PASS_POS;
        lram_ptr[0] = ((nWF_WG-1) << 28) | (0 << 14) | (start_addr);
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
        // Xil_DCacheFlush();
        // Xil_DCacheInvalidate();
        // printf("target_fgpu = \n");
        // for(unsigned i = 0; i < size0_buffer; i++) {
        //   for(unsigned j = 0; j < size0_buffer; j++)
        //     printf("%9.2f ", target_fgpu[i*size0_buffer+j]);
        //   printf("\n");
        // }
        // printf("L_fgpu = \n");
        // for(unsigned i = 0; i < size0_buffer; i++) {
        //   for(unsigned j = 0; j < size0_buffer; j++)
        //     printf("%9.2F ", L_fgpu[i*size0_buffer+j]);
        //   printf("\n");
        // }
        // printf("passIndx = %d\n", passIndx);
        // break;
      }while(passIndx != 0);
    }
    
    
    XTime_GetTime(&tEnd);
    exec_time += elapsed_time_us(tStart, tEnd);
    
    size0 = size1 = size0_buffer; // reset size0 and size1
    
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
  xil_printf("\n\r" ANSI_COLOR_YELLOW "Kernel is LU Decomposition");
  if(use_hard_float) {
    xil_printf(" (hard fadd&fmul, ");
    if(use_fdiv_support)
      xil_printf("hard div)\n\r" ANSI_COLOR_RESET);
    else
      xil_printf("soft div)\n\r" ANSI_COLOR_RESET);
  }
  else
    xil_printf(" (soft)\n\r" ANSI_COLOR_RESET);
}

template class kernel<float>;
