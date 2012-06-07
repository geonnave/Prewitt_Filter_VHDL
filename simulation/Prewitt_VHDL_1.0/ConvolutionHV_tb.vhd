library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ConvolutionHV_tb is
end entity;

architecture test_bench of ConvolutionHV_tb is

component ConvolutionHV is
	port
	(
		in_x0y0, in_x0y1, in_x0y2,
		in_x1y0, in_x1y1, in_x1y2, 
		in_x2y0, in_x2y1, in_x2y2	:	in std_logic_vector(7 downto 0);
		mh_x0y0, mh_x0y1, mh_x0y2,
		mh_x1y0, mh_x1y1, mh_x1y2, 
		mh_x2y0, mh_x2y1, mh_x2y2	:	in signed(2 downto 0);
		mv_x0y0, mv_x0y1, mv_x0y2,
		mv_x1y0, mv_x1y1, mv_x1y2, 
		mv_x2y0, mv_x2y1, mv_x2y2	:	in signed(2 downto 0);
		clk							:	in std_logic;				--	the clock
		sload						:	in std_logic;				--	
		pixel_out					:	out std_logic_vector(7 downto 0);		--	the output pixel 
		count						:	out unsigned(3 downto 0);
		accumH						:	out signed(15 downto 0);		--just for test, to see the results
		accumV						:	out signed(15 downto 0)		--just for test, to see the results
	);
end component;

signal 	sin_x0y0, sin_x0y1, sin_x0y2,
		sin_x1y0, sin_x1y1, sin_x1y2,
		sin_x2y0, sin_x2y1, sin_x2y2	:	std_logic_vector(7 downto 0)		:= (others => '0');
signal 	smh_x0y0, smh_x0y1, smh_x0y2,
		smh_x1y0, smh_x1y1, smh_x1y2,
		smh_x2y0, smh_x2y1, smh_x2y2	:	signed(2 downto 0)		:= (others => '0');
signal 	smv_x0y0, smv_x0y1, smv_x0y2,
		smv_x1y0, smv_x1y1, smv_x1y2,
		smv_x2y0, smv_x2y1, smv_x2y2	:	signed(2 downto 0)		:= (others => '0');
signal	sig_clk							:	std_logic				:= '0';
signal	sig_sload						:	std_logic				:= '0';
signal	sig_pixel_out					:	std_logic_vector(7 downto 0);
signal	sig_count						:	unsigned(3 downto 0);
signal	sig_accumH						:	signed(15 downto 0);
signal	sig_accumV						:	signed(15 downto 0);

for dut: ConvolutionHV use entity work.ConvolutionHV;

begin
	dut: ConvolutionHV port map (
		in_x0y0 => sin_x0y0, in_x0y1 => sin_x0y1, in_x0y2 => sin_x0y2,
		in_x1y0 => sin_x1y0, in_x1y1 => sin_x1y1, in_x1y2 => sin_x1y2, 
		in_x2y0 => sin_x2y0, in_x2y1 => sin_x2y1, in_x2y2 => sin_x2y2,
		mh_x0y0 => smh_x0y0, mh_x0y1 => smh_x0y1, mh_x0y2 => smh_x0y2,
		mh_x1y0 => smh_x1y0, mh_x1y1 => smh_x1y1, mh_x1y2 => smh_x1y2, 
		mh_x2y0 => smh_x2y0, mh_x2y1 => smh_x2y1, mh_x2y2 => smh_x2y2,
		mv_x0y0 => smv_x0y0, mv_x0y1 => smv_x0y1, mv_x0y2 => smv_x0y2,
		mv_x1y0 => smv_x1y0, mv_x1y1 => smv_x1y1, mv_x1y2 => smv_x1y2, 
		mv_x2y0 => smv_x2y0, mv_x2y1 => smv_x2y1, mv_x2y2 => smv_x2y2,
		clk => sig_clk, sload => sig_sload, pixel_out => sig_pixel_out, count => sig_count, accumH => sig_accumH, accumV => sig_accumV
	);

	tb: process
	begin
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		smh_x0y0 <= "001"; smh_x0y1 <= "001"; smh_x0y2 <= "001";	--\
		smh_x1y0 <= "000"; smh_x1y1 <= "000"; smh_x1y2 <= "000";	---> horizontal filter mask
		smh_x2y0 <= "111"; smh_x2y1 <= "111"; smh_x2y2 <= "111";	--/
		smv_x0y0 <= "111"; smv_x0y1 <= "000"; smv_x0y2 <= "001";	--\
		smv_x1y0 <= "111"; smv_x1y1 <= "000"; smv_x1y2 <= "001";	---> vertical filter mask
		smv_x2y0 <= "111"; smv_x2y1 <= "000"; smv_x2y2 <= "001";	--/
		--
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000000";		-- 1
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 520 ns;
		assert ( sig_pixel_out = "00000000") report ("test convHV #1 failed");
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000001"; sin_x0y2 <= "00000001";		-- 2
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000001";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000001";
		wait for 520 ns;
		assert ( sig_pixel_out = "00000100") report ("test convHV #2 failed");
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000000"; sin_x0y2 <= "00000000";		-- 3
		sin_x1y0 <= "00000001"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000001"; sin_x2y1 <= "00000001"; sin_x2y2 <= "00000001";
		wait for 520 ns;
		assert ( sig_pixel_out = "00000000") report ("test convHV #3 failed");
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000000"; sin_x0y1 <= "11111111"; sin_x0y2 <= "11111111";		-- 4
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 520 ns;
		assert ( sig_pixel_out = "11111111") report ("test convHV #4 failed");
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00000001"; sin_x0y1 <= "00000001"; sin_x0y2 <= "11111111";		-- 5
		sin_x1y0 <= "00000000"; sin_x1y1 <= "00000000"; sin_x1y2 <= "00000000";
		sin_x2y0 <= "00000000"; sin_x2y1 <= "00000000"; sin_x2y2 <= "00000000";
		wait for 520 ns;
		assert ( sig_pixel_out = "11111111") report ("test convHV #5 failed");
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sin_x0y0 <= "00011001"; sin_x0y1 <= "11110101"; sin_x0y2 <= "11111101";		-- 6
		sin_x1y0 <= "00010110"; sin_x1y1 <= "11010010"; sin_x1y2 <= "11111010";
		sin_x2y0 <= "00010100"; sin_x2y1 <= "11001000"; sin_x2y2 <= "11101000";
		wait for 520 ns;
		assert ( sig_pixel_out = "11111111") report ("test convHV #6 failed");
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


