library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
use work.mem_size.all;
use work.filter_masks.all;
use work.MemImgROM;
use work.ConvolutionN;



entity MainController is
	port
	(
		clk			:	in	std_logic;
		sload		:	in	std_logic;
		enable		:	in	std_logic
	);
end entity;

architecture rtl of MainController is

component MemImgROM is
	port
	(
		addr_i	:	in	natural		range 0 to lin;
		addr_j	:	in	natural		range 0 to col;
		clk		:	in std_logic;
		q		:	out std_logic_vector(7 downto 0)
	);
end component;





begin
	
end;





