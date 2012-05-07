library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
use work.mem_size.all;
use work.filter_masks.all;
use work.MemImgROM;
use work.ConvolutionN;
use work.MainController;



entity MainController_tb is
end entity;

architecture rtl of MainController_tb is

component MainController is
	port
	(
		clk			:	in	std_logic;
		sload		:	in	std_logic
	);
end component;

begin
	
end;