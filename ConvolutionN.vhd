library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
use work.ConvolutionHV;

entity ConvolutionN is
	port
	(
		img_in						:	in	matrix_in;	--	image in
		mh							:	in	std_logic_vector(26 downto 0)	:=	"001001001000000000111111111";			--	horizontal filter mask 
		mv							:	in	std_logic_vector(26 downto 0)	:=	"001000111001000111001000111";			--	vertical filter mask 
		clk							:	in	std_logic;				--	the clock
		sload						:	in	std_logic;				--	--	
		counter						:	out	unsigned(3 downto 0);	
		img_out						:	out	matrix_out	-- image out
	);
end entity;

architecture rtl of ConvolutionN is

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
		count						:	out unsigned(3 downto 0)
	);
end component;

signal 	sin_x0y0, sin_x0y1, sin_x0y2,
		sin_x1y0, sin_x1y1, sin_x1y2,
		sin_x2y0, sin_x2y1, sin_x2y2	:	std_logic_vector(7 downto 0)		:= (others => '0');
signal 	smh_x0y0, smh_x0y1, smh_x0y2,
		smh_x1y0, smh_x1y1, smh_x1y2,
		smh_x2y0, smh_x2y1, smh_x2y2	:	signed(2 downto 0);
signal 	smv_x0y0, smv_x0y1, smv_x0y2,
		smv_x1y0, smv_x1y1, smv_x1y2,
		smv_x2y0, smv_x2y1, smv_x2y2	:	signed(2 downto 0);
signal	sig_clk							:	std_logic				:= '0';
signal	sig_sload						:	std_logic				:= '0';
signal	sig_pixel_out					:	std_logic_vector(7 downto 0);
signal	sig_count						:	unsigned(3 downto 0);


signal sig_img_out						:	matrix_out;


begin
	gen_lin: for i in 1 to rlin generate
		gen_col: for j in 1 to rcol generate
			con: ConvolutionHV port map (
				in_x0y0 => img_in(i-1, j-1),			in_x0y1 => img_in(i-1, j),				in_x0y2 => img_in(i-1, j+1),
				in_x1y0 => img_in(i  , j-1),			in_x1y1 => img_in(i  , j),				in_x1y2 => img_in(i  , j+1),
				in_x2y0 => img_in(i+1, j-1),			in_x2y1 => img_in(i+1, j),				in_x2y2 => img_in(i+1, j+1),
				
				mh_x0y0 => signed(mh(26 downto 24)),	mh_x0y1 => signed(mh(23 downto 21)),	mh_x0y2 => signed(mh(20 downto 18)),
				mh_x1y0 => signed(mh(17 downto 15)),	mh_x1y1 => signed(mh(14 downto 12)),	mh_x1y2 => signed(mh(11 downto 9)),
				mh_x2y0 => signed(mh(8 	downto 6)),		mh_x2y1 => signed(mh(5 	downto 3)),		mh_x2y2 => signed(mh(2 	downto 0)),
				
				mv_x0y0 => signed(mv(26 downto 24)),	mv_x0y1 => signed(mv(23 downto 21)), 	mv_x0y2 => signed(mv(20 downto 18)),
				mv_x1y0 => signed(mv(17 downto 15)),	mv_x1y1 => signed(mv(14 downto 12)),	mv_x1y2 => signed(mv(11 downto 9)),
				mv_x2y0 => signed(mv(8 	downto 6)),		mv_x2y1 => signed(mv(5 	downto 3)),		mv_x2y2 => signed(mv(2 	downto 0)),
				clk => sig_clk, sload => sig_sload, pixel_out => sig_img_out(i, j), count => sig_count
			);
		end generate gen_col;
	end generate gen_lin;
	
	counter <= sig_count;
	
	img_out <= sig_img_out;
	
	sig_clk <= clk;
	
	sig_sload <= sload;

end rtl;


