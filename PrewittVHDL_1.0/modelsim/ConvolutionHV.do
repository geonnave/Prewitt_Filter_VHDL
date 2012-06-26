vcom -reportprogress 300 -work work ../vhdl/ConvolutionHV.vhd ../testbench/ConvolutionHV_tb.vhd

vsim work.convolutionhv_tb

add wave sim:/convolutionhv_tb/*

run 3520 ns