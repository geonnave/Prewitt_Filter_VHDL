vcom -reportprogress 300 -work work ../vhdl/SelectAC.vhd ../testbench/SelectAC_tb.vhd

vsim work.SelectAC_tb

add wave sim:/SelectAC_tb/*

run 240 ns