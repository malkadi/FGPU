#include "tm_esit.h"

/****************************************************************************
 * Macros
 ****************************************************************************/
/* Read from address */
#define REG_READ(addr) \
    ({int val;int a=addr; asm volatile ("ldr   %0,[%1]\n" : "=r"(val) : "r"(a)); val;})

/* Write to address */
#define REG_WRITE(addr,val) \
    ({int v = val; int a = addr; __asm volatile ("str  %1,[%0]\n" :: "r"(a),"r"(v)); v;})
    
/****************************************************************************
 * Function: timer_init
 * Description:  Initialize the ttc1 timer 1 to measure test duration.
 ****************************************************************************/
inline int timer_init(u32 baseaddr, u8 prescaler)
{
  // Set clock_control_1 at 0xf8002000:
  //   b6=0 ex_e
  //   b5=0 selects pclk
  //   b4:1 = TTC1_PRESCALAR prescalar 2^(N+1)
  //   b0=1 prescale enable
  REG_WRITE(baseaddr+0,  1 + (prescaler << 1));  // 0x1f

  // Set counter_control_1
  //   b6=0 wave_pol
  //   b5=1 wave_en active low
  //   b4=1 restarts counter
  //   b3=0 match mode
  //   b2=0 decr mode
  //   b1=0 overflow mode
  //   b0=0 disable counter
  REG_WRITE(baseaddr+0x0c,  (1 << 4) + (1 << 5));  // 0x30
  return 0;

}


/****************************************************************************
 * Function: timer_read
 * Description:  Read the timer
 ****************************************************************************/
inline int timer_read(u32 baseaddr)
{
  int a;
  a = REG_READ(baseaddr+0x18);
  return a;
}

/****************************************************************************
 * Function: timer_value
 * Description:  returns timer value in microseconds
          t in timer units
 ****************************************************************************/
inline double timer_value(int t,  u32 prescaler,  u32 clk_freq)
{
  double x;
  x = ((double) t) * ((float)(1<<(prescaler+1))) / ((double)clk_freq);
  return ((double)1000000)*x;
}
