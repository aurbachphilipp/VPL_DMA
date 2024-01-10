#include "xparameters.h"
#include "xaxivdma.h"

#define VDMA_DEVICE_ID XPAR_AXIVDMA_0_DEVICE_ID
#define DDR_FRAME_STORE_ADDR  (XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x15000000) // DDR_BASEADDR + offset
#define FRAME_HORIZONTAL_LEN 480
#define FRAME_VERTICAL_LEN 480
#define NUMBER_OF_FRAMES 3

XAxiVdma AxiVdma;

int main()
{
    int Status;
    XAxiVdma_Config *Config;
    XAxiVdma_DmaSetup WriteCfg;

    Config = XAxiVdma_LookupConfig(VDMA_DEVICE_ID);
    if (!Config) {
        xil_printf("No VDMA found\r\n");
        return XST_FAILURE;
    }

    Status = XAxiVdma_CfgInitialize(&AxiVdma, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) {
        xil_printf("VDMA Configuration Initialization failed\r\n");
        return XST_FAILURE;
    }

    WriteCfg.VertSizeInput = FRAME_VERTICAL_LEN;
    WriteCfg.HoriSizeInput = FRAME_HORIZONTAL_LEN * (XPAR_AXI_VDMA_0_S_AXIS_S2MM_TDATA_WIDTH / 8);
    WriteCfg.Stride = FRAME_HORIZONTAL_LEN;
    WriteCfg.FrameDelay = 0;
    WriteCfg.EnableCircularBuf = 1;
    WriteCfg.EnableSync = 0;
    WriteCfg.PointNum = 0;
    WriteCfg.EnableFrameCounter = 0;
    WriteCfg.FixedFrameStoreAddr = 0;

    for (int i = 0; i < NUMBER_OF_FRAMES; i++) {
        WriteCfg.FrameStoreStartAddr[i] = DDR_FRAME_STORE_ADDR + (i * FRAME_HORIZONTAL_LEN * FRAME_VERTICAL_LEN);
    }

    Status = XAxiVdma_DmaConfig(&AxiVdma, XAXIVDMA_WRITE, &WriteCfg);
    if (Status != XST_SUCCESS) {
        xil_printf("Write channel configuration failed\r\n");
        return XST_FAILURE;
    }

    Status = XAxiVdma_DmaSetBufferAddr(&AxiVdma, XAXIVDMA_WRITE, WriteCfg.FrameStoreStartAddr);
    if (Status != XST_SUCCESS) {
        xil_printf("Write channel set buffer address failed\r\n");
        return XST_FAILURE;
    }

    Status = XAxiVdma_DmaStart(&AxiVdma, XAXIVDMA_WRITE);
    if (Status != XST_SUCCESS) {
        xil_printf("Start write transfer failed\r\n");
        return XST_FAILURE;
    }


    xil_printf("VDMA write channel started\r\n");

    while(1) {
    	;
    }

    return XST_SUCCESS;
}