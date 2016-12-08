#ifndef TM_ESIT_H_
#define TM_ESIT_H_

#include <xil_types.h>   	/* u8, ... */

/****************************************************************************
 * Function: timer_init
 * Description:  Initialize the ttc1 timer 1 to measure test duration.
 ****************************************************************************/
inline int timer_init(u32 baseaddr, u8 prescaler);


/****************************************************************************
 * Function: timer_read
 * Description:  Read the timer
 ****************************************************************************/
inline int timer_read(u32 baseaddr);

/****************************************************************************
 * Function: timer_value
 * Description:  returns timer value in microseconds
          t in timer units
 ****************************************************************************/
inline double timer_value(int t,  u32 prescaler,  u32 clk_freq);

#endif /* TM_ESIT_H_ */
