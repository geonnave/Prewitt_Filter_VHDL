library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ConvolutionN is
	generic	(
		x	:	integer	:=	5;
		y	:	integer	:=	5;
		n	:	integer	:=	20
	);
	port
	(
		a	: in	std_logic
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
		count						:	out unsigned(3 downto 0);
		accumH						:	out signed(15 downto 0);		--just for test, to see the results
		accumV						:	out signed(15 downto 0)		--just for test, to see the results
	);
end component;


begin

	
end rtl;


