library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;
use work.mem_size.all;
use work.filter_masks.all;
use work.MemImgROM;
use work.ConvolutionN;


entity MainController is
	port
	(
		clk			:	in	std_logic;
		sload		:	in	std_logic;
		enable		:	in	std_logic;
		c_sload		:	out	std_logic;
		count		:	out unsigned(3 downto 0);
		count_i		:	out natural range 0 to lin;
		count_j		:	out natural range 0 to col;
		m			:	out matrix_in;
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
component ConvolutionN is
	port
	(
		img_in						:	in	matrix_in;	--	image in
		mh							:	in	std_logic_vector(26 downto 0);			--	horizontal filter mask 
		mv							:	in	std_logic_vector(26 downto 0);			--	vertical filter mask 
		clk							:	in	std_logic;				--	the clock
		sload						:	in	std_logic;				--	
--		counter						:	out	unsigned(3 downto 0);	
		img_out						:	out	matrix_out	-- image out
	);
end component;

signal	si_addr_i	:	natural	range 0 to lin;
signal	si_addr_j	:	natural	range 0 to col;
signal	si_clk		:	std_logic;
signal	si_q		:	matrix_in;

signal	sc_img_in	:	matrix_in;	
signal	sc_mh		:	std_logic_vector(26 downto 0);
signal	sc_mv		:	std_logic_vector(26 downto 0);
signal	sc_clk		:	std_logic;
signal	sc_sload	:	std_logic;
--signal	sig_count	:	unsigned(3 downto 0);
signal	sc_img_out	:	matrix_out;

signal	sig_count		:	unsigned(3 downto 0)	:=	"1100";
signal	sig_count_i		:	natural range 0 to lin	:=	0;
signal	sig_count_j		:	natural range 0 to col	:=	0;

begin
	
	imgROM: MemImgROM port map (
		addr_i => si_addr_i, addr_j => si_addr_j, clk => si_clk, q => si_q
	);
	convN: ConvolutionN port map (
		img_in => sc_img_in, mh => sc_mh, mv => sc_mv, clk => sc_clk, 
		sload => sc_sload, img_out => sc_img_out
	);
	
	si_clk <= clk;
	sc_clk <= clk;
	
	count <= sig_count;
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (sig_count = "1100" or sc_sload = '1') then
				sig_count <= "0000";
			else
				sig_count <= sig_count + 1;
			end if;
		end if;
	end process;
	
	counter: process(clk)
	begin
		if (rising_edge(clk)) then
		    if (sc_sload = 'U') then
			    sc_sload <= '1';
			end if;
			if (sig_count = "1100" and sc_sload /= 'U') then
				if (sig_count_j = col-ecol) then 
					sig_count_j <= 0;
					sig_count_i <= sig_count_i + elin;
				else
					sig_count_j <= sig_count_j + ecol;
				end if;
				sc_sload <= '1';
			end if;
			if (sig_count = "0000") then
				sc_sload <= '0';
			end if;
		end if;
	end process counter;
		
	sc_mh <= mPrewittH;
	sc_mv <= mPrewittV;
	
	prewitt: process(sig_count_j, clk)
	begin
		if (sig_count = "1011" and sig_count_i <= lin-elin and sig_count_j <= col-ecol) then
			si_addr_i <= sig_count_i;
			si_addr_j <= sig_count_j;
		elsif (sig_count = "0000") then
			sc_img_in <= si_q;
		end if;
	end process prewitt;
	
	c_sload <= sc_sload;
	
	count_i <= sig_count_i;
	count_j <= sig_count_j;
	
	m <= sc_img_in;
	
	o <= sc_img_out;
	
end;





