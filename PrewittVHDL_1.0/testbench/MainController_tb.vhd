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
		sload		:	in	std_logic;
		init		:	buffer	std_logic;
		o			:	out matrix_out
	);
end component;

signal	sig_clk		:	std_logic;
signal	sig_sload	:	std_logic;
signal	sig_init	:	std_logic;
signal	sig_o		:	matrix_out;

for dut: MainController use entity work.MainController;

begin
	
	dut: MainController port map (
		clk => sig_clk, sload => sig_sload, init => sig_init, o => sig_o
	);
	
	
	tb : process 
--	variable	t	:	integer	:=	(560 * ((lin/elin)*(col/ecol)));
	begin
		sig_sload <= '0';
		sig_init <= '0';
		wait for 40 ns;
		sig_init <= '1';
		wait for 21000 ns;
	end process tb;
	
	clock_gen : process
	begin
	   sig_clk <= '1';
	   wait for 20 ns;
	   sig_clk <= '0';
	   wait for 20 ns;
	end process clock_gen;
end;
