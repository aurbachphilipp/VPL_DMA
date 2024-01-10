# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/dma_demo_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/dma_demo_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {dma_demo_wrapper}\
-hw {/home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/dma_demo_wrapper.xsa}\
-fsbl-target {psu_cortexa53_0} -out {/home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {dma_demo_wrapper}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
