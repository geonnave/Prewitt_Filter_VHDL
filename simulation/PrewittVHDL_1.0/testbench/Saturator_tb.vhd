library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturator_tb is
end entity;

architecture sature of Saturator_tb is

component Saturator is
port
	(
		a		:	in std_logic_vector(15 downto 0);
		o		:	out std_logic_vector(7 downto 0)
	);
end component;

signal 	sig_a	:	std_logic_vector(15 downto 0);
signal 	sig_o	:	std_logic_vector(7 downto 0);

begin
	dut: Saturator port map (a=>sig_a, o=>sig_o);
	
	tb: process
	begin
		--normal cases
		sig_a <= "0000000000000001";
		wait for 20 ns;
		assert (sig_o = "00000001") report "normal case1 failed";
		wait for 10 ns;
		
		sig_a <= "0000000000011101";
		wait for 20 ns;
		assert (sig_o = "00011101") report "normal case2 failed";
		wait for 10 ns;
		
		--under cases
		sig_a <= "1111111111111110";
		wait for 20 ns;
		assert (sig_o = "00000000") report "under case1 failed";
		wait for 10 ns;
		
		sig_a <= "1111111111100010";
		wait for 20 ns;
		assert (sig_o = "00000000") report "under case2 failed";
		wait for 10 ns;
		
		--over cases
		sig_a <= "0000000100000000";
		wait for 20 ns;
		assert (sig_o = "11111111") report "over case1 failed";
		wait for 10 ns;
		
		sig_a <= "0000110000000000";
		wait for 20 ns;
		assert (sig_o = "11111111") report "over case2 failed";
		wait for 10 ns;
	end process tb;
		 
end sature;
