vcom -reportprogress 300 -work work ../vhdl/Saturator.vhd ../testbench/Saturator_tb.vhd

vsim work.Saturator_tb

add wave sim:/saturator_tb/*

run 180 ns