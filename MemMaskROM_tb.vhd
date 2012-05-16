library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MemMaskROM;

entity MemMaskROM_tb is
end entity;


architecture rtl of MemMaskROM_tb is

component MemMaskROM is
	port
	(
		addr	:	in	std_logic_vector(3 downto 0);
		clk		:	in std_logic;
		q		:	out std_logic_vector(26 downto 0)
	);
end component;

signal	sig_addr		:	std_logic_vector(3 downto 0);
signal	sig_clk			:	std_logic;
signal	sig_q			:	std_logic_vector(26 downto 0);

for dut: MemMaskROM use entity work.MemMaskROM;
	
begin
	dut: MemMaskROM port map ( addr => sig_addr, clk => sig_clk, q => sig_q );
	
	tb: process
	begin
		wait for 40 ns;
		sig_addr <= "0000";
		wait for 40 ns;
		assert (sig_q = "001001001000000000111111111") report "H-mask of Prewitt filter have failed";
		sig_addr <= "0001";
		wait for 40 ns;
		assert (sig_q = "001000111001000111001000111") report "V-mask of Prewitt filter have failed";
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
