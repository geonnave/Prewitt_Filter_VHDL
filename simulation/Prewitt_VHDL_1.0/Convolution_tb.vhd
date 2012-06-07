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
		pixel_out					:	out signed(15 downto 0);		--	the output pixel 
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
signal	sig_clk							:	std_logic				:= '0';
signal	sig_sload						:	std_logic				:= '0';
signal	sig_pixel_out					:	signed(15 downto 0);
signal	sig_accum						:	signed(15 downto 0);
signal	sig_count						:	unsigned(3 downto 0);

for dut: Convolution use entity work.Convolution;

begin
	dut: Convolution port map (
		in_x0y0 => sin_x0y0, in_x0y1 => sin_x0y1, in_x0y2 => sin_x0y2,
		in_x1y0 => sin_x1y0, in_x1y1 => sin_x1y1, in_x1y2 => sin_x1y2, 
		in_x2y0 => sin_x2y0, in_x2y1 => sin_x2y1, in_x2y2 => sin_x2y2,
		mf_x0y0 => smf_x0y0, mf_x0y1 => smf_x0y1, mf_x0y2 => smf_x0y2,
		mf_x1y0 => smf_x1y0, mf_x1y1 => smf_x1y1, mf_x1y2 => smf_x1y2, 
		mf_x2y0 => smf_x2y0, mf_x2y1 => smf_x2y1, mf_x2y2 => smf_x2y2,
		clk => sig_clk, sload => sig_sload, pixel_out => sig_pixel_out, accum => sig_accum, count => sig_count
	);

	tb: process
	begin
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		smf_x0y0 <= "111"; smf_x0y1 <= "000"; smf_x0y2 <= "001";	--\
		smf_x1y0 <= "111"; smf_x1y1 <= "000"; smf_x1y2 <= "001";	---> vertical filter mask tests
		smf_x2y0 <= "111"; smf_x2y1 <= "000"; smf_x2y2 <= "001";	--/
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000001"; sin_x0y2 <= "00000001";		-- 1
		sin_x1y0 <= "00000001"; sin_x1y1 <= "00000001"; sin_x1y2 <= "00000001";
		sin_x2y0 <= "00000001"; sin_x2y1 <= "00000001"; sin_x2y2 <= "00000001";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000000000") report ("test vertical #1 failed");		-- 1
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000001";		-- 2
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000001";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000001";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000000011") report ("test vertical #2 failed");		-- 2
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000000";		-- 3
		sin_x1y0 <= "00000001"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000001"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 480 ns;
		assert ( sig_pixel_out = "1111111111111101") report ("test vertical #3 failed");		-- 3
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000000";		-- 4
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000000000") report ("test vertical #4 failed");		-- 4
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000011";		-- 5
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000011";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000011";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000001001") report ("test vertical #5 failed");		-- 5
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00001000";		-- 6
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00001000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00010000";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000100000") report ("test vertical #6 failed");		-- 6
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		smf_x0y0 <= "001"; smf_x0y1 <= "001"; smf_x0y2 <= "001";	--\
		smf_x1y0 <= "000"; smf_x1y1 <= "000"; smf_x1y2 <= "000";	---> horizontal filter mask tests
		smf_x2y0 <= "111"; smf_x2y1 <= "111"; smf_x2y2 <= "111";	--/
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000001"; sin_x0y2 <= "00000001";		-- 1
		sin_x1y0 <= "00000001"; sin_x1y1 <= "00000001"; sin_x1y2 <= "00000001";
		sin_x2y0 <= "00000001"; sin_x2y1 <= "00000001"; sin_x2y2 <= "00000001";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000000000") report ("test horizontal #1 failed");		-- 1
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000001"; sin_x0y2 <= "00000001";		-- 2
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000000011") report ("test horizontal #2 failed");		-- 2
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000000";		-- 3
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000001"; sin_x2y1 <= "00000001"; sin_x2y2 <= "00000001";
		wait for 480 ns;
		assert ( sig_pixel_out = "1111111111111101") report ("test horizontal #3 failed");		-- 3
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000000";		-- 4
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000000000") report ("test horizontal #4 failed");		-- 4
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000011"; sin_x0y1 <= "00000011"; sin_x0y2 <= "00000011";		-- 5
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000001001") report ("test horizontal #5 failed");		-- 5
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00010000"; sin_x0y1 <= "00001000"; sin_x0y2 <= "00001000";		-- 6
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 480 ns;
		assert ( sig_pixel_out = "0000000000100000") report ("test horizontal #6 failed");		-- 6
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		wait for 80 ns;
	end process tb;
	
	clock_gen : process
	begin
	   sig_clk <= '1';
	   wait for 20 ns;
	   sig_clk <= '0';
	   wait for 20 ns;
	end process clock_gen;
	
end test_bench;


