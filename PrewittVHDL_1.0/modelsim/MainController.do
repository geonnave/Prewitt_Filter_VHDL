vcom -reportprogress 300 -work work ../vhdl/MainController.vhd ../testbench/MainController_tb.vhd

vsim work.MainController_tb

add wave sim:/MainController_tb/*

run 21040 ns