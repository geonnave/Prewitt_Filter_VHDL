library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SelectAC_tb is
end entity;

architecture test_bench of SelectAC_tb is

component SelectAC is
	port (
		a			:	in signed(8 downto 0);
		b			:	in signed(8 downto 0);
		clk			:	in std_logic;
		sload		:	in std_logic;
		accum_out	:	out signed(17 downto 0)
	);
end component;

signal 	sig_a			:	signed(8 downto 0);		--	:= (others => '0');
signal 	sig_b			:	signed(8 downto 0);		--	:= (others => '0');
signal 	sig_clk			:	std_logic;				--	:= '0';
signal 	sig_sload		:	std_logic					:= '1';
signal 	sig_accum_out	:	signed(17 downto 0);--	:= (others => '0');

for dut: SelectAC use entity work.SelectAC;

begin
	dut: SelectAC port map (
		a => sig_a, b => sig_b, clk => sig_clk, sload => sig_sload, accum_out => sig_accum_out
	);
	
	tb: process
	begin
--		sig_a <= "000000010";
--		sig_b <= "100000001";
		wait for 40 ns;
		sig_a <= "000000010";
		sig_b <= "100000001";
--		assert (sig_accum_out = "00000000000000010") report "tem algo errado" severity error;
--		wait for 100 ns;
	end process tb;
	
	clock_gen : process
	begin
		sig_clk <= '0' after 20 ns, '1' after 40 ns;
		wait for 40 ns;
	end process clock_gen;
	
	set_sload : process
	begin
		sig_sload <= '0' after 50 ns, '1' after 400 ns;
		wait for 400 ns;
	end process set_sload;
		
	
end test_bench;


