vcom -reportprogress 300 -work work ../vhdl/SaturatorABS.vhd ../testbench/SaturatorABS_tb.vhd

vsim work.SaturatorABS_tb

add wave sim:/saturatorABS_tb/*

run 180 ns