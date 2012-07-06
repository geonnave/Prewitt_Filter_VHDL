library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mem_size.all;
use work.matrix_types.all;
use work.MemImgROM;

entity MemImgROM_tb is
end entity;


architecture rtl of MemImgROM_tb is

component MemImgROM is
	port
	(
		addr_i	:	in	natural		range 0 to lin;
		addr_j	:	in	natural		range 0 to col;
		clk		:	in std_logic;
		q		:	out matrix_in
	);
end component;


signal	sig_addr_i	:	natural		range 0 to lin;
signal	sig_addr_j	:	natural		range 0 to col;
signal	sig_clk		:	std_logic	:= '0';
signal	sig_q		:	matrix_in;

for dut: MemImgROM use entity work.MemImgROM;

begin
	
	dut: MemImgROM port map ( addr_i => sig_addr_i, addr_j => sig_addr_j, clk => sig_clk, q => sig_q );

	tb: process
	begin
		sig_addr_i <= 0;
		sig_addr_j <= 0;
		wait for 40 ns;
	end process tb;

	clock_gen : process
	begin
	   sig_clk <= '1';
	   wait for 20 ns;
	   sig_clk <= '0';
	   wait for 20 ns;
	end process clock_gen;
		
end rtl;
