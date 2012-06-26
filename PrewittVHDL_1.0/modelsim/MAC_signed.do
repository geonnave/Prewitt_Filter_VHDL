vcom -reportprogress 300 -work work ../vhdl/MAC_signed.vhd ../testbench/MAC_signed_tb.vhd

vsim work.MAC_signed_tb

add wave sim:/MAC_signed_tb/*

run 240 ns