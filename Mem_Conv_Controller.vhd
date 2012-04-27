library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
use work.MemImgROM;
use work.MemPrewittMaskROM;
use work.ConvolutionN;



entity Mem_Conv_Controller is
	port
	(
		clk			:	in	std_logic;
		sload		:	in	std_logic;
		img_out		:	out	matrix_out
	);
end entity;

architecture rtl of Mem_Conv_Controller is

begin
	
end;