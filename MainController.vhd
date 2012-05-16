library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
use work.mem_size.all;
use work.filter_masks.all;
use work.MemImgROM;
use work.MemMaskROM;
use work.ConvolutionN;



entity MainController is
	port
	(
		clk			:	in	std_logic;
		sload		:	in	std_logic;
		enable		:	in	std_logic
	);
end entity;

architecture rtl of MainController is

component MemImgROM is
	port
	(
		addr_i	:	in	natural		range 0 to lin;
		addr_j	:	in	natural		range 0 to col;
		clk		:	in std_logic;
		q		:	out std_logic_vector(7 downto 0)
	);
end component;
component MemMaskROM is
	port
	(
		addr	:	in	std_logic_vector(3 downto 0);
		clk		:	in std_logic;
		q		:	out std_logic_vector(26 downto 0)
	);
end component;
component ConvolutionN is
	port
	(
		img_in						:	in	matrix_in;	--	image in
		mh							:	in	std_logic_vector(26 downto 0);			--	horizontal filter mask 
		mv							:	in	std_logic_vector(26 downto 0);			--	vertical filter mask 
		clk							:	in	std_logic;				--	the clock
		sload						:	in	std_logic;				--	
		img_out						:	out	matrix_out	-- image out
	);
end component;

signal	si_addr_i	:	natural	range 0 to lin;
signal	si_addr_j	:	natural	range 0 to col;
signal	si_clk		:	std_logic;
signal	si_q		:	std_logic_vector(7 downto 0);

signal	sm_addr		:	std_logic_vector(3 downto 0);
signal	sm_clk		:	std_logic;
signal	sm_q		:	std_logic_vector(26 downto 0);

signal	sc_img_in	:	matrix_in;	
signal	sc_mh		:	std_logic_vector(26 downto 0);
signal	sc_mv		:	std_logic_vector(26 downto 0);
signal	sc_clk		:	std_logic;
signal	sc_sload	:	std_logic;
signal	sc_img_out	:	matrix_out;

signal	count_i		:	natural range 0 to lin;
signal	count_j		:	natural range 0 to col;

begin
	
	imgROM: MemImgROM port map (
		addr_i => si_addr_i, addr_j => si_addr_j, clk => si_clk, q => si_q
	);
	maskROM: MemMaskROM port map (
		addr => sm_addr, clk => sm_clk, q => sm_q
	);
	convN: ConvolutionN port map (
		img_in => sc_img_in, mh => sc_mh, mv => sc_mv, clk => sc_clk, sload => sc_sload, img_out => sc_img_out
	);
	
	

	
	
end;





