/*******************************************************************************
 ** � Copyright 2012 - 2013 Xilinx, Inc. All rights reserved.
 ** This file contains confidential and proprietary information of Xilinx, Inc. and
 ** is protected under U.S. and international copyright and other intellectual property laws.
 *******************************************************************************
 **   ____  ____
 **  /   /\/   /
 ** /___/  \  /   Vendor: Xilinx
 ** \   \   \/
 **  \   \
**  /   /
 ** /___/    \
** \   \  /  \   7 Series FPGA AMS Targeted Reference Design
 **  \___\/\___\
**
 **  Device: xc7z020
 **  Version: 1.3
 **  Reference:
 **
 *******************************************************************************
 **
 **  Disclaimer:
 **
 **    This disclaimer is not a license and does not grant any rights to the materials
 **    distributed herewith. Except as otherwise provided in a valid license issued to you
 **    by Xilinx, and to the maximum extent permitted by applicable law:
 **    (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS,
 **    AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
 **    INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR
 **    FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether in contract
 **    or tort, including negligence, or under any other theory of liability) for any loss or damage
 **    of any kind or nature related to, arising under or in connection with these materials,
 **    including for any direct, or any indirect, special, incidental, or consequential loss
 **    or damage (including loss of data, profits, goodwill, or any type of loss or damage suffered
 **    as a result of any action brought by a third party) even if such damage or loss was
 **    reasonably foreseeable or Xilinx had been advised of the possibility of the same.


 **  Critical Applications:
 **
 **    Xilinx products are not designed or intended to be fail-safe, or for use in any application
 **    requiring fail-safe performance, such as life-support or safety devices or systems,
 **    Class III medical devices, nuclear facilities, applications related to the deployment of airbags,
 **    or any other applications that could lead to death, personal injury, or severe property or
 **    environmental damage (individually and collectively, "Critical Applications"). Customer assumes
 **    the sole risk and liability of any use of Xilinx products in Critical Applications, subject only
 **    to applicable laws and regulations governing limitations on product liability.

 **  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.

 *******************************************************************************/
/*****************************************************************************/

#include "pmbus_iic.h"

XIicPs iic;

int setupIic(void) {
    XIicPs_Config *config;
    int status;

    /* Initialize the IIC controller */
    config = XIicPs_LookupConfig(XPAR_XIICPS_0_DEVICE_ID);
    if(config == NULL) {
        return XST_FAILURE;
    }
    config->InputClockHz = XPAR_XIICPS_0_CLOCK_HZ;
    status = XIicPs_CfgInitialize(&iic, config, config->BaseAddress);
    if(status != XST_SUCCESS) {
        return status;
    }
    status = XIicPs_SelfTest(&iic);
    if(status != XST_SUCCESS) {
        xil_printf("\r\nERROR: IIC self test failed! 0x%08X\r\n", status);
        return status;
    }
    /* Increase the default timeout value to handle clock stretching from the PMBus controllers */
    XIicPs_WriteReg(config->BaseAddress, XIICPS_TIME_OUT_OFFSET, 0x0000007f);
    XIicPs_SetSClk(&iic, 100000);

    /* Reset the IIC mux and then configure it for PMBus access */
    status = iicMuxSetup(IIC_MUX_CHANNEL_MASK);
    if(status != XST_SUCCESS) {
        xil_printf("ERROR: Unable to configure IIC mux! 0x%08X\r\n", status);
        return status;
    }

    return XST_SUCCESS;
}

unsigned int pmBusWrite(unsigned char address, unsigned char command, unsigned char data) {
    unsigned char writeBuffer[2];
    unsigned int status;

    /* The register address is the first byte of data sent to the IIC device,
     * followed by the data
     */
    writeBuffer[0] = command;
    writeBuffer[1] = data;

    /* Wait until the bus is available */
    while(XIicPs_BusIsBusy(&iic)) {
        /* NOP */
    }

    /* Write the data at the specified address to the IIC device */
    status =  XIicPs_MasterSendPolled(&iic, writeBuffer, 2, address);

    if(status != XST_SUCCESS) {
        xil_printf("SEND ERROR: 0x%08X\r\n", status);
        return status;
    }

    while(XIicPs_BusIsBusy(&iic)) {
        /* NOP */
    }

    //myusleep(250000);

    return XST_SUCCESS;
}

unsigned char pmBusWriteWord(unsigned char address, unsigned char command, unsigned char *data) {
    unsigned int status;
    unsigned char writeBuffer[3];

    /* The register address if the first byte of data to send to the IIC device,
     * followed by the data
     */
    writeBuffer[0] = command;
    writeBuffer[1] = data[0];
    writeBuffer[2] = data[1];

    /* Wait until the bus is available */
    while(XIicPs_BusIsBusy(&iic)) {
        /* NOP */
    }

    status = XIicPs_MasterSendPolled(&iic, writeBuffer, 3, address);

    if(status != XST_SUCCESS) {
        xil_printf("SEND ERROR: 0x%08X\r\n", status);
        return 0;
    }


    while(XIicPs_BusIsBusy(&iic)) {
        /* NOP */
    }

    //myusleep(250000);

    return 2;
}

unsigned int pmBusRead(unsigned char address, unsigned char command, unsigned char byteCount, unsigned char *buffer) {
    unsigned int status;

    status = XIicPs_SetOptions(&iic, XIICPS_REP_START_OPTION);
    if(status != XST_SUCCESS) {
        xil_printf("ERROR: Unable to set repeated start option: 0x%08X\r\n", status);
        return status;
    }
    /* Send the command byte to the IIC device */

    status = XIicPs_MasterSendPolled(&iic, &command, 1, address);
    if(status != XST_SUCCESS) {
        xil_printf("ERROR: RX send error: 0x%08X\r\n", status);
        return status;
    }

    //myusleep(10000);

    status = XIicPs_MasterRecvPolled(&iic, buffer, byteCount, address);
    if(status != XST_SUCCESS) {
        status = XIicPs_ReadReg(iic.Config.BaseAddress, XIICPS_ISR_OFFSET);
        xil_printf("ERROR: RX error: 0x%08X\r\n", status);
        return status;
    }

    status = XIicPs_ClearOptions(&iic, XIICPS_REP_START_OPTION);
    if(status != XST_SUCCESS) {
        xil_printf("ERROR: Unable to clear repeated start option: 0x%08X\r\n", status);
        return status;
    }


    return XST_SUCCESS;
}

unsigned char readVoltage(unsigned char deviceAddress, unsigned char pageAddress, unsigned char *receiveBuf) {
    unsigned int status;

    status = pmBusWrite(deviceAddress, CMD_PAGE, pageAddress);
    if(status != XST_SUCCESS) {
        return 0;
    }
    myusleep(10000);
    status = pmBusRead(deviceAddress, CMD_READ_VOUT, 2, receiveBuf);
    if(status != XST_SUCCESS) {
        return 0;
    }

    return 2;
}

unsigned char readCurrent(unsigned char deviceAddress, unsigned char pageAddress, unsigned char *receiveBuf) {
    unsigned int status;

    status = pmBusWrite(deviceAddress, CMD_PAGE, pageAddress);
    if(status != XST_SUCCESS) {
        return 0;
    }
    myusleep(10000);
    status = pmBusRead(deviceAddress, CMD_READ_IOUT, 2, receiveBuf);
    if(status != XST_SUCCESS) {
        return 0;
    }

    return 2;
}

float readVoltage_real(unsigned char deviceAddress, unsigned char pageAddress) {
    u8 SendArray[3];
    u16 data;
    float voltage;
    myusleep(10000);
    readVoltage(deviceAddress,pageAddress ,SendArray);
    data = (u16)((SendArray[0]) | (SendArray[1]) << 8);
    //voltage = (float)data*0.000244; //Done in measure.c
    voltage = (float)data;
    return voltage;
}


double readCurrent_real(unsigned char deviceAddress, unsigned char pageAddress) {
    double current;
    u8 SendArray[3];
    myusleep(10000);
    readCurrent(deviceAddress, pageAddress, SendArray);
    //printf("data = %x", data);
    current = linear11ToFloat((unsigned char)SendArray[1],(unsigned char)SendArray[0]);
    return current;
}


/*
 * This function programs a particular voltage on rail
 *  DevAdrs - 7-bit address of the device
 *  PageAdrs - Page address of the supply voltage rail
 *  SendBufPtr - value to be programmed - expected 2 bytes in LINEAR16 format with LS followed by MS
 *  Command - VOUT_MAX or VOUT_COMMAND for voltage programming
 */
int ProgramVoltage(u8 DevAdrs, u8 PageAdrs, u8 *SendBufPtr, u8 Command)
{
    pmBusWrite(DevAdrs, CMD_PAGE, PageAdrs);
    pmBusWriteWord(DevAdrs, Command, SendBufPtr);
    //- Enable VOUT as nominal voltage programmed by VOUT_COMMAND
    if (Command == CMD_VOUT_COMMAND) {
        pmBusWrite(DevAdrs, CMD_OPERATION, OP_MODE_NOM);
    }
    return XST_SUCCESS;
}

int iicMuxSetup(unsigned char channelMask) {
    int status;
    unsigned char buffer;

    buffer = channelMask;


    /* Wait until the IIC bus is idle */
    while(XIicPs_BusIsBusy(&iic)) {
        /* NOP */
    }

    status = XIicPs_MasterSendPolled(&iic, &buffer, 1, IIC_MUX_ADDRESS);
    if(status != XST_SUCCESS) {
        xil_printf("ERROR: Unable to configure IIC mux! 0x%08X\r\n", status);
        return status;
    }

    myusleep(10000);

    status = XIicPs_MasterRecvPolled(&iic, &buffer, 1, IIC_MUX_ADDRESS);

    if(buffer != channelMask) {
        xil_printf("ERROR: IIC mux read back 0x%02X expected 0x%02X\r\n", buffer, channelMask);
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

int myusleep(unsigned int useconds) {
    unsigned long tEnd, tCur;
    unsigned int reg;

    /* check requested delay for out of range */

    if (useconds == 0) {
        return 0;
    }

    if (((COUNTS_PER_SECOND1 / 1000000) > 0) &&
            (useconds > (0xFFFFFFFF / (COUNTS_PER_SECOND1 / 1000000)))) {
        return -1;
    }

    /* enable the counter */
    mtcp(XREG_CP15_PERF_MONITOR_CTRL, 1);
#ifdef __GNUC__
    reg = mfcp(XREG_CP15_COUNT_ENABLE_SET);
#else
    { register unsigned int Reg __asm(XREG_CP15_COUNT_ENABLE_SET);
    reg = Reg; }
#endif
    mtcp(XREG_CP15_COUNT_ENABLE_SET, reg | 0x80000000);

#ifdef __GNUC__
    tCur = mfcp(XREG_CP15_PERF_CYCLE_COUNTER);
#else
    { register unsigned int Reg __asm(XREG_CP15_PERF_CYCLE_COUNTER);
    tCur = Reg; }
#endif
    tEnd = tCur + (useconds * (COUNTS_PER_SECOND1 / 1000000));

    do {
#ifdef __GNUC__
        tCur = mfcp(XREG_CP15_PERF_CYCLE_COUNTER);
#else
        { register unsigned int Reg __asm(XREG_CP15_PERF_CYCLE_COUNTER);
        tCur = Reg; }
#endif
    } while (tCur < tEnd);

    return 0;
}

double linear11ToFloat(unsigned char highByte, unsigned char lowByte) {
	unsigned short combinedWord;
	signed char exponent;
	signed short mantissa;
	double current;


	combinedWord = highByte;
	combinedWord <<= 8;
	combinedWord += lowByte;

	exponent = combinedWord >> 11;
	mantissa = combinedWord & 0x7ff;


	/* Sign extend the exponent and the mantissa */
	/* Sign extend the exponent and the mantissa */

    if(exponent > 0x0f) {
		exponent |= 0xe0;
	}
	if(mantissa > 0x03ff) {
		mantissa |= 0xf800;
	}
    //xil_printf("%f--------%f",mantissa,exponent );
	current = mantissa * pow(2.0,exponent);
	return (float)current;
}
