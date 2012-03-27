library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAC_signed_tb is
end entity;

architecture test_bench of MAC_signed_tb is

component MAC_signed is
	port
	(
		a			:	in std_logic_vector(7 downto 0);		--	a and b are the in pixels
		b			:	in signed(2 downto 0);
		clk			:	in std_logic;				--	the clock
		sload		:	in std_logic;				--	
		accum_out	:	out signed(15 downto 0)		--	the output pixel 
	);
end component;

signal 	sig_a			:	std_logic_vector(7 downto 0)	:= (others => '0');
signal 	sig_b			:	signed(2 downto 0)		:= (others => '0');
signal 	sig_clk			:	std_logic				:= '0';
signal 	sig_sload		:	std_logic				:= '1';
signal 	sig_accum_out	:	signed(15 downto 0)		:= (others => '0');

for dut: MAC_signed use entity work.MAC_signed;

begin
	dut: MAC_signed port map (
		a => sig_a, b => sig_b, clk => sig_clk, sload => sig_sload, accum_out => sig_accum_out
	);

	tb: process
	begin
		sig_a <= "00000000";
		sig_b <= "000";
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sig_a <= "00000010";	-- 1
		sig_b <= "001";
		wait for 40 ns;
		sig_a <= "00000010";	-- 2
		sig_b <= "111";
		wait for 40 ns;
		assert (sig_accum_out = "000000000000000010") report "something wrong on #1 test";	-- 1
		sig_a <= "00000010";	-- 3
		sig_b <= "111";
		wait for 40 ns;
		assert (sig_accum_out = "000000000000000000") report "something wrong on #2 test";	-- 2
		sig_a <= "00000001";
		sig_b <= "111";
		wait for 40 ns;
		assert (sig_accum_out = "111111111111111110") report "something wrong on #3 test";	-- 3
		wait for 40 ns;
		assert (sig_accum_out = "111111111111111101") report "something wrong on #4 test";	-- 4
	end process tb;
	
	clock_gen : process
	begin
	   sig_clk <= '0';
	   wait for 20 ns;
	   sig_clk <= '1';
	   wait for 20 ns;
	end process clock_gen;
	
end test_bench;


