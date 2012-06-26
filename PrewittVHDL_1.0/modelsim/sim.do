vcom -reportprogress 300 -work work D:/Faculdade/IC_VHDL/Developments/Prewitt_Filter_VHDL/simulation/Prewitt_VHDL_1.0/ConvolutionN.vhd D:/Faculdade/IC_VHDL/Developments/Prewitt_Filter_VHDL/simulation/Prewitt_VHDL_1.0/ConvolutionN_tb.vhd
vsim work.convolutionn_tb
add wave sim:/convolutionn_tb/*
run 2800 ns