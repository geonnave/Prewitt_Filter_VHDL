library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
	
entity ConvolutionN_tb is
end entity;

architecture rtl of ConvolutionN_tb is

component ConvolutionN is
	port
	(
		img_in						:	in	matrix_in;	--	image in
		img_test					:	out	matrix_in;
		mh							:	in	std_logic_vector(26 downto 0);			--	horizontal filter mask 
		mv							:	in	std_logic_vector(26 downto 0);			--	vertical filter mask 
		clk							:	in	std_logic;				--	the clock
		sload						:	in	std_logic;				--	
		count						:	out	unsigned(3 downto 0);
		img_out						:	out	matrix_out	-- image out
	);
end component;

signal	sig_img_in						:	matrix_in;	--	image in
signal	sig_img_test					:	matrix_in;
signal	sig_mh							:	std_logic_vector(26 downto 0);			--	horizontal filter mask 
signal	sig_mv							:	std_logic_vector(26 downto 0);			--	vertical filter mask 
signal	sig_clk							:	std_logic;				--	the clock
signal	sig_sload						:	std_logic;				--	
signal	sig_img_out						:	matrix_out;	-- image out
signal	sig_count						:	unsigned(3 downto 0);

for dut: ConvolutionN use entity work.ConvolutionN;

begin

	dut: ConvolutionN port map (
		img_in => sig_img_in, img_test => sig_img_test, mh => sig_mh, mv => sig_mv, clk => sig_clk, sload => sig_sload, count => sig_count
	);
	
	tb : process 
	begin
		sig_sload <= '1';
		wait for 40 ns;
		sig_sload <= '0';
		sig_mh <= "001001001000000000111111111";
		sig_mv <= "001000111001000111001000111";
		sig_img_in <=  (("00000000", "00000000", "00000000", "00000000"),
						("00000000", "00000001", "00000001", "00000000"),
						("00000000", "00000001", "00000001", "00000000"),
						("00000000", "00000000", "00000000", "00000000"));
		wait for 40 ns;
		sig_img_test(0, 0) <= sig_img_in(0, 0);
		wait for 1000 ns;
	end process tb;
		
	
	clock_gen : process
	begin
	   sig_clk <= '1';
	   wait for 20 ns;
	   sig_clk <= '0';
	   wait for 20 ns;
	end process clock_gen;

end rtl;

