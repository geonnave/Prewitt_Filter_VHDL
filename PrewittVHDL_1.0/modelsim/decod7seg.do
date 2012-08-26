vcom -reportprogress 300 -work work ../vhdl/decod7seg.vhd ../testbench/decod7seg_tb.vhd

vsim work.decod7seg_tb

add wave sim:/decod7seg_tb/*

run 60 ns