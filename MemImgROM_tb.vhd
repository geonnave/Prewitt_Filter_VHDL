library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mem_size.all;
use work.ROM_Module;

entity MemImgROM_tb is
end entity;


architecture rtl of MemImgROM_tb is

component MemImgROM is
	port
	(
		addr_i	:	in	natural		range 0 to lin;
		addr_j	:	in	natural		range 0 to col;
		clk		:	in std_logic;
		q		:	out std_logic_vector(7 downto 0)
	);
end component;


signal	sig_addr_i	:	natural		range 0 to lin;
signal	sig_addr_j	:	natural		range 0 to col;
signal	sig_clk		:	std_logic	:= '0';
signal	sig_q		:	std_logic_vector(7 downto 0);

for dut: MemImgROM use entity work.MemImgROM;

begin
	
	dut: MemImgROM port map ( addr_i => sig_addr_i, addr_j => sig_addr_j, clk => sig_clk, q => sig_q );

	tb: process
	begin
		wait for 40 ns;
		sig_addr_i <= 0;
		sig_addr_j <= 0;
		if (lin >= 14 and col >= 14) then
			wait for 40 ns;
			assert (sig_q = "00010000") report " (0, 0) = 00010000 --failed";
			sig_addr_i <= 1;
			sig_addr_j <= 1;
			wait for 40 ns;
			assert (sig_q = "00010000") report " (1, 1) = 00010000 --failed";
			sig_addr_i <= 5;
			sig_addr_j <= 5;
			wait for 40 ns;
			assert (sig_q = "01000000") report " (5, 5) = 01000000 --failed";
			sig_addr_i <= 16;
			sig_addr_j <= 16;
			wait for 40 ns;
			assert (sig_q = "00010000") report " (16, 16) = 00010000 --failed";
		else 
			wait for 160 ns;
			assert (sig_q = "00000000") report " (0, 0) = 00000000 --failed";
		end if;
	end process tb;

	clock_gen : process
	begin
	   sig_clk <= '1';
	   wait for 20 ns;
	   sig_clk <= '0';
	   wait for 20 ns;
	end process clock_gen;
		
end rtl;
