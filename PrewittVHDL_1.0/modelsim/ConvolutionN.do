vcom -reportprogress 300 -work work ../vhdl/ConvolutionN.vhd ../testbench/ConvolutionN_tb.vhd

vsim work.convolutionn_tb

add wave sim:/convolutionn_tb/*

run 2800 ns