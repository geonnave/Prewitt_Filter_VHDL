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
		enable		:	in	std_logic;
		count		:	out unsigned(3 downto 0);
		o			:	out matrix_out
	);
end entity;

architecture rtl of MainController is

component MemImgROM is
	port
	(
		addr_i	:	in	natural		range 0 to lin;
		addr_j	:	in	natural		range 0 to col;
		clk		:	in std_logic;
		q		:	out matrix_in
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
		counter						:	out	unsigned(3 downto 0);	
		img_out						:	out	matrix_out	-- image out
	);
end component;

signal	si_addr_i	:	natural	range 0 to lin;
signal	si_addr_j	:	natural	range 0 to col;
signal	si_clk		:	std_logic;
signal	si_q		:	matrix_in;

signal	sm_addr		:	std_logic_vector(3 downto 0);
signal	sm_clk		:	std_logic;
signal	sm_q		:	std_logic_vector(26 downto 0);

signal	sc_img_in	:	matrix_in;	
signal	sc_mh		:	std_logic_vector(26 downto 0);
signal	sc_mv		:	std_logic_vector(26 downto 0);
signal	sc_clk		:	std_logic;
signal	sc_sload	:	std_logic;
signal	sc_img_out	:	matrix_out;

signal	sig_count	:	unsigned(3 downto 0)		:=	"1100";
signal	count_i		:	natural range 0 to lin-1	:=	0;
signal	count_j		:	natural range 0 to col-1	:=	0;

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
	
	si_clk <= clk;
	sm_clk <= clk;
	
	sc_clk <= clk;
	sc_sload <= sload;
	
	count <= sig_count;
	
	counter: process(clk)
	begin
		if (rising_edge(clk)) then
			if (sig_count = "1100" or sc_sload = '1') then
				sig_count <= "0000";
				if (count_j = col-1) then 
					count_j <= 0;
					count_i <= count_i + elin;
				else
					count_j <= count_j + ecol;
				end if;
				sc_sload <= '1';
				sc_sload <= '0';
			else
				sig_count <= sig_count + 1;
			end if;
		end if;
	end process counter;
	
	prewitt: process(count_j, clk)
	begin
		sm_addr <= "0000";
		sc_mh <= sm_q;
		sm_addr <= "0001";
		sc_mv <= sm_q;
		si_addr_i <= count_i;
		si_addr_j <= count_j;
		sc_img_in <= si_q;
	end process prewitt;
	
	o <= sc_img_out;
	
end;





