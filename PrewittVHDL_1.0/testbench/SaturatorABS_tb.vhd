library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SaturatorABS_tb is
end entity;

architecture sature of SaturatorABS_tb is

component SaturatorABS is
port
	(
		a		:	in unsigned(15 downto 0);
		b		:	in unsigned(15 downto 0);
		o1		:	out unsigned(15 downto 0);
		o2		:	out unsigned(15 downto 0)
	);
end component;

signal 	sig_a	:	unsigned(15 downto 0);
signal 	sig_b	:	unsigned(15 downto 0);
signal 	sig_o1	:	unsigned(15 downto 0);
signal 	sig_o2	:	unsigned(15 downto 0);

begin
	dut: SaturatorABS port map (a=>sig_a, b=>sig_b, o1=>sig_o1, o2=>sig_o2);
	
	tb: process
	begin
		--normal cases
		sig_a <= "0000000000000001";
		sig_b <= "1111111111111111";
		wait for 20 ns;
--		assert (sig_o = "00000001") report "normal case1 failed";
--		wait for 10 ns;
		
		sig_a <= "0000000000011111";
		sig_b <= "1111111111100001";
		wait for 20 ns;
--		assert (sig_o = "00011101") report "normal case2 failed";
--		wait for 10 ns;
		
	end process tb;
	
end sature;
