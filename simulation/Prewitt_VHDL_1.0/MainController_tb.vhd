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
		enable		:	in	std_logic;
		c_sload		:	out	std_logic;
		count		:	out unsigned(3 downto 0);
		count_i		:	out natural range 0 to lin;
		count_j		:	out natural range 0 to col;
		m			:	out matrix_in;
		o			:	out matrix_out
	);
end component;

signal	sig_clk		:	std_logic;
signal	sig_sload	:	std_logic;
signal	sig_enable	:	std_logic;
signal	sig_c_sload	:	std_logic;
signal	sig_count	:	unsigned(3 downto 0);
signal	sig_count_i	:	natural range 0 to lin;
signal	sig_count_j	:	natural range 0 to col;
signal	sig_m		:	matrix_in;
signal	sig_o		:	matrix_out;

for dut: MainController use entity work.MainController;

begin
	
	dut: MainController port map (
		clk => sig_clk, sload => sig_sload, enable => sig_enable, count => sig_count, c_sload => sig_c_sload,
		count_i => sig_count_i, count_j => sig_count_j, m => sig_m, o => sig_o
	);
	
	
	tb : process 
--	variable	t	:	integer	:=	(560 * ((lin/elin)*(col/ecol)));
	begin
--		init <= '1';
--		wait for 40 ns;
--		init <= '0';
		wait for 27440 ns;
		wait for 560 ns;
		wait for 80 ns;
	end process tb;
	
	clock_gen : process
	begin
	   sig_clk <= '1';
	   wait for 20 ns;
	   sig_clk <= '0';
	   wait for 20 ns;
	end process clock_gen;
end;
