#include "kernel_descriptor.h"
extern unsigned int *copy_word;


extern unsigned *first_param_ptr;
extern unsigned *second_param_ptr;
extern unsigned *target_ptr;

void kernel_descriptor_prepare(kernel_descriptor *kdesc, unsigned int size_index)
{
  kdesc->wg_size0 = 64;
  kdesc->size0 = kdesc->wg_size0 << size_index;
  kdesc->problemSize = kdesc->size0;
  kdesc->offset0 = 0;
  kdesc->nDim = 1;
  kernel_descriptor_compute_all_fields(kdesc);
  kdesc->dataSize = 4 * kdesc->problemSize; // 4 bytes per word
  kdesc->offset0 = kdesc->offset1 = kdesc->offset2 = 0;
  kdesc->nParams = 2; // number of parameters
}
void kernel_descriptor_download(kernel_descriptor *kdesc)
{
  int i;
  volatile unsigned* hw_sch_ptr = (unsigned*)FGPU_BASEADDR;
  for(i = 0; i < 32; i++)
    hw_sch_ptr[i] = 0;
  hw_sch_ptr[0] = ((kdesc->nWF_WG-1) << 28) | (0 << 14) | kdesc->start_addr;
  hw_sch_ptr[1] = kdesc->size0;
  hw_sch_ptr[2] = kdesc->size1;
  hw_sch_ptr[3] = kdesc->size2;
  hw_sch_ptr[4] = kdesc->offset0;
  hw_sch_ptr[5] = kdesc->offset1;
  hw_sch_ptr[6] = kdesc->offset2;
  hw_sch_ptr[7] = ((kdesc->nDim-1) << 30) | (kdesc->wg_size2 << 20) | (kdesc->wg_size1 << 10) | (kdesc->wg_size0);
  hw_sch_ptr[8] = kdesc->n_wg0-1;
  hw_sch_ptr[9] = kdesc->n_wg1-1;
  hw_sch_ptr[10] = kdesc->n_wg2-1;
  hw_sch_ptr[11] = (kdesc->nParams << 28) | kdesc->wg_size;
  hw_sch_ptr[16] = (unsigned) first_param_ptr;
  hw_sch_ptr[17] = (unsigned) target_ptr;
}
void kernel_descriptor_compute_all_fields(kernel_descriptor *kdesc)
{
  assert(kdesc->wg_size0 > 0 && kdesc->wg_size0 <= 512);
  assert(kdesc->size0 % kdesc->wg_size0 == 0);
  kdesc->size = kdesc->size0;
  kdesc->wg_size = kdesc->wg_size0;
  kdesc->n_wg0 = kdesc->size0 / kdesc->wg_size0;
  if(kdesc->nDim > 1)
  {
    assert(kdesc->wg_size1 > 0 && kdesc->wg_size1 <= 512);
    assert(kdesc->size1 % kdesc->wg_size1 == 0);
    kdesc->size = kdesc->size0 * kdesc->size1;
    kdesc->wg_size = kdesc->wg_size0 * kdesc->wg_size1;
    kdesc->n_wg1 = kdesc->size1 / kdesc->wg_size1;
  }
  else
  {
    kdesc->wg_size1 = kdesc->n_wg1 = kdesc->size1 = 0;
  }
  if(kdesc->nDim > 2)
  {
    assert(kdesc->wg_size2 > 0 && kdesc->wg_size2 <= 512);
    assert(kdesc->size2 % kdesc->wg_size2 == 0);
    kdesc->size = kdesc->size0 * kdesc->size1 * kdesc->size2;
    kdesc->wg_size = kdesc->wg_size0 * kdesc->wg_size1 * kdesc->wg_size2;
    kdesc->n_wg2 = kdesc->size2 / kdesc->wg_size2;
  }
  else
  {
    kdesc->wg_size2 = kdesc->n_wg2 = kdesc->size2 = 0;
  }
  assert(kdesc->wg_size <= 512);
  kdesc->nWF_WG = kdesc->wg_size / 64;
  if(kdesc->wg_size % 64 != 0)
    kdesc->nWF_WG++;
}
void initialize_memory(kernel_descriptor *kdesc)
{
  unsigned i;
  for(i = 0; i < 3*kdesc->size; i++) // 2 for first and second parameter, 1 for some excess access
  {
    first_param_ptr[i] = i;
    target_ptr[i] = 0;
  }
  Xil_DCacheFlush(); // flush data to global memory
}
void kernel_code_download(kernel_descriptor *kdesc)
{
  volatile unsigned *cram_ptr = (unsigned *)(FGPU_BASEADDR+ 0x4000);
  unsigned int size = COPY_LEN;
  const unsigned int *code = copy_word;
  kdesc->start_addr = COPY_WORD_POS;
  unsigned i = 0;
  for(; i < size; i++){
    cram_ptr[i] = code[i];
  }
}

