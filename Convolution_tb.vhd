library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Convolution_tb is
end entity;

architecture test_bench of Convolution_tb is

component Convolution is
	port
	(
		in_x0y0, in_x0y1, in_x0y2,
		in_x1y0, in_x1y1, in_x1y2, 
		in_x2y0, in_x2y1, in_x2y2	:	in std_logic_vector(7 downto 0);
		mf_x0y0, mf_x0y1, mf_x0y2,
		mf_x1y0, mf_x1y1, mf_x1y2, 
		mf_x2y0, mf_x2y1, mf_x2y2	:	in signed(2 downto 0);
		clk							:	in std_logic;				--	the clock
		sload						:	in std_logic;				--	
		pixel_out					:	out std_logic_vector(7 downto 0);		--	the output pixel 
		count						:	out unsigned(3 downto 0);
		accum						:	out signed(15 downto 0)
	);
end component;

signal 	sin_x0y0, sin_x0y1, sin_x0y2,
		sin_x1y0, sin_x1y1, sin_x1y2,
		sin_x2y0, sin_x2y1, sin_x2y2	:	std_logic_vector(7 downto 0)		:= (others => '0');
signal 	smf_x0y0, smf_x0y1, smf_x0y2,
		smf_x1y0, smf_x1y1, smf_x1y2,
		smf_x2y0, smf_x2y1, smf_x2y2	:	signed(2 downto 0)		:= (others => '0');
signal	sig_clk							:	std_logic;
signal	sig_sload						:	std_logic;
signal	sig_pixel_out					:	std_logic_vector(7 downto 0);
signal	sig_count						:	unsigned(3 downto 0);
signal	sig_accum						:	signed(15 downto 0);

for dut: Convolution use entity work.Convolution;

begin
	dut: Convolution port map (
		in_x0y0 => sin_x0y0, in_x0y1 => sin_x0y1, in_x0y2 => sin_x0y2,
		in_x1y0 => sin_x1y0, in_x1y1 => sin_x1y1, in_x1y2 => sin_x1y2, 
		in_x2y0 => sin_x2y0, in_x2y1 => sin_x2y1, in_x2y2 => sin_x2y2,
		mf_x0y0 => smf_x0y0, mf_x0y1 => smf_x0y1, mf_x0y2 => smf_x0y2,
		mf_x1y0 => smf_x1y0, mf_x1y1 => smf_x1y1, mf_x1y2 => smf_x1y2, 
		mf_x2y0 => smf_x2y0, mf_x2y1 => smf_x2y1, mf_x2y2 => smf_x2y2,
		clk => sig_clk, sload => sig_sload, pixel_out => sig_pixel_out, count => sig_count, accum => sig_accum
	);

	tb: process
	begin
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000011";
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000011";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000011";
		smf_x0y0 <= "111"; smf_x0y1 <= "000"; smf_x0y2 <= "001";
		smf_x1y0 <= "111"; smf_x1y1 <= "000"; smf_x1y2 <= "001";
		smf_x2y0 <= "111"; smf_x2y1 <= "000"; smf_x2y2 <= "001";
		wait for 540 ns;
	end process tb;
	
	clock_gen : process
	begin
	   sig_clk <= '0';
	   wait for 20 ns;
	   sig_clk <= '1';
	   wait for 20 ns;
	end process clock_gen;
	
end test_bench;


