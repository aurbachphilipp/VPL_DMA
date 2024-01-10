# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/selftest_phil_system/_ide/scripts/systemdebugger_selftest_phil_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/selftest_phil_system/_ide/scripts/systemdebugger_selftest_phil_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Cora Z7 - 7007S 210370A92FA7A" && level==0 && jtag_device_ctx=="jsn-Cora Z7 - 7007S-210370A92FA7A-13722093-0"}
fpga -file /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/selftest_phil/_ide/bitstream/dma_demo_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/dma_demo_wrapper/export/dma_demo_wrapper/hw/dma_demo_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/selftest_phil/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/aup41490/Documents/DMA_git/DMA/VDMA_selftest/vitis2/selftest_phil/Debug/selftest_phil.elf
configparams force-mem-access 0
bpadd -addr &main
