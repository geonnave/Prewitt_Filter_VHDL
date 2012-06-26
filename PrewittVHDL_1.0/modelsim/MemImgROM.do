vcom -reportprogress 300 -work work ../vhdl/MemImgROM.vhd ../testbench/MemImgROM_tb.vhd

vsim work.MemImgROM_tb

add wave sim:/MemImgROM_tb/*

run 280 ns