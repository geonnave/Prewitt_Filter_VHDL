vcom -reportprogress 300 -work work ../packages/filter_masks.vhd ../packages/matrix_types.vhd ../packages/mem_size.vhd
vcom -reportprogress 300 -work work ../vhdl/Saturator.vhd ../vhdl/SelectAC.vhd ../vhdl/ConvolutionHV.vhd ../vhdl/ConvolutionN.vhd ../vhdl/MAC_signed.vhd ../vhdl/MemImgROM.vhd ../vhdl/MainController.vhd
vcom -reportprogress 300 -work work ../testbench/ConvolutionHV_tb.vhd ../testbench/ConvolutionN_tb.vhd ../testbench/MAC_signed_tb.vhd ../testbench/MainController_tb.vhd ../testbench/MemImgROM_tb.vhd ../testbench/Saturator_tb.vhd ../testbench/SelectAC_tb.vhd
