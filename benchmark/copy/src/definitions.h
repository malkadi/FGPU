#ifndef DECLERATIONS_H_
#define DECLERATIONS_H_

// Control Registers of FGPU
#define STATUS_REG_ADDR         (FGPU_BASEADDR+ 0x8000)
#define START_REG_ADDR          (FGPU_BASEADDR+ 0x8004)
#define CLEAN_CACHE_REG_ADDR    (FGPU_BASEADDR+ 0x8008)
#define INITIATE_REG_ADDR       (FGPU_BASEADDR+ 0x800C)

#define MAX_MES_TIME_S          2 // maximum execution time of a kernel at any size.
                                  //The execution will not repeat if this number is exceeded

typedef struct {
  // basic parameters
  u32 size0, size1, size2;
  u32 offset0, offset1, offset2;
  u16 wg_size0, wg_size1, wg_size2;
  u8 nParams, nDim;
  //calculated parameters
  u32 size, n_wg0, n_wg1, n_wg2;
  u16 wg_size;
  u8 nWF_WG;
  u32 start_addr;
  //extra info
  unsigned problemSize, dataSize;
  unsigned *param1, *target;
} kernel_descriptor;

#endif /* DECLERATIONS_H_ */
