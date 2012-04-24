library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MAC_signed;
use work.Saturator;

entity ConvolutionHV is
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
end entity;

architecture rtl of ConvolutionHV is

component MAC_signed is
	port
	(
		a			:	in std_logic_vector(7 downto 0);		--	a and b are the in pixels
		b			:	in signed(2 downto 0);
		clk			:	in std_logic;				--	the clock
		sload		:	in std_logic;				--	
		accum_out	:	out signed(15 downto 0)		--	the output pixel 
	);
end component;

component Saturator is
	port
	(
		a		:	in std_logic_vector(15 downto 0);
		o		:	out std_logic_vector(7 downto 0)
	);
end component;

signal 	sig_aH			:	std_logic_vector(7 downto 0)	:= (others => '0');
signal 	sig_bH			:	signed(2 downto 0)				:= (others => '0');
signal 	sig_aV			:	std_logic_vector(7 downto 0)	:= (others => '0');
signal 	sig_bV			:	signed(2 downto 0)				:= (others => '0');
signal 	sig_clk			:	std_logic;
signal 	sig_sload		:	std_logic;
signal 	sig_accum_outH	:	signed(15 downto 0)		:= (others => '0');
signal 	sig_accum_outV	:	signed(15 downto 0)		:= (others => '0');

signal sig_s			:	std_logic_vector(15 downto 0);
signal sig_o			:	std_logic_vector(7 downto 0);

signal	reg_counter		:	unsigned(3 downto 0)	:= "1100";


begin
	macH: MAC_signed port map (
		a => sig_aH, b => sig_bH, clk => sig_clk, sload => sig_sload, accum_out => sig_accum_outH
	);
	macV: MAC_signed port map (
		a => sig_aV, b => sig_bV, clk => sig_clk, sload => sig_sload, accum_out => sig_accum_outV
	);
	
	sat: Saturator port map (
		a => sig_s, o => sig_o
	);
	
	sig_clk <= clk;
	sig_sload <= sload;
	
	counter: process(clk)
	begin
		if (rising_edge(clk)) then
			count <= reg_counter;
			if (reg_counter = "1100" or sig_sload = '1') then
				reg_counter <= "0000";
			else
				reg_counter <= reg_counter + 1;
			end if;
		end if;
	end process counter;
	
	convolveH: process(reg_counter, clk)
	begin
		if (rising_edge(clk)) then
		    if(reg_counter = "0000") then
				sig_aH <= "00000000";
				sig_bH <= "000";
			elsif (reg_counter = "0001") then
				sig_aH <= in_x0y0;
				sig_bH <= mh_x0y0;
			elsif (reg_counter = "0010") then
				sig_aH <= in_x0y1;
				sig_bH <= mh_x0y1;
			elsif (reg_counter = "0011") then
				sig_aH <= in_x0y2;
				sig_bH <= mh_x0y2;
			elsif (reg_counter = "0100") then
				sig_aH <= in_x1y0;
				sig_bH <= mh_x1y0;
			elsif (reg_counter = "0101") then
				sig_aH <= in_x1y1;
				sig_bH <= mh_x1y1;
			elsif (reg_counter = "0110") then
				sig_aH <= in_x1y2;
				sig_bH <= mh_x1y2;
			elsif (reg_counter = "0111") then
				sig_aH <= in_x2y0;
				sig_bH <= mh_x2y0;
			elsif (reg_counter = "1000") then
				sig_aH <= in_x2y1;
				sig_bH <= mh_x2y1;
			elsif (reg_counter = "1001") then
				sig_aH <= in_x2y2;
				sig_bH <= mh_x2y2;
			elsif (reg_counter = "1001") then
				sig_aH <= "00000000";
				sig_bH <= "000";
			elsif (reg_counter = "1010") then
				sig_aH <= "00000000";
				sig_bH <= "000";
			elsif (reg_counter = "1011") then
				sig_aH <= "00000000";
				sig_bH <= "000";
			end if;
		end if;
	end process convolveH;
	
	convolveV: process(reg_counter, clk)
	begin
		if (rising_edge(clk)) then
		    if(reg_counter = "0000") then
				sig_aV <= "00000000";
				sig_bV <= "000";
			elsif (reg_counter = "0001") then
				sig_aV <= in_x0y0;
				sig_bV <= mv_x0y0;
			elsif (reg_counter = "0010") then
				sig_aV <= in_x0y1;
				sig_bV <= mv_x0y1;
			elsif (reg_counter = "0011") then
				sig_aV <= in_x0y2;
				sig_bV <= mv_x0y2;
			elsif (reg_counter = "0100") then
				sig_aV <= in_x1y0;
				sig_bV <= mv_x1y0;
			elsif (reg_counter = "0101") then
				sig_aV <= in_x1y1;
				sig_bV <= mv_x1y1;
			elsif (reg_counter = "0110") then
				sig_aV <= in_x1y2;
				sig_bV <= mv_x1y2;
			elsif (reg_counter = "0111") then
				sig_aV <= in_x2y0;
				sig_bV <= mv_x2y0;
			elsif (reg_counter = "1000") then
				sig_aV <= in_x2y1;
				sig_bV <= mv_x2y1;
			elsif (reg_counter = "1001") then
				sig_aV <= in_x2y2;
				sig_bV <= mv_x2y2;
			elsif (reg_counter = "1001") then
				sig_aV <= "00000000";
				sig_bV <= "000";
			elsif (reg_counter = "1010") then
				sig_aV <= "00000000";
				sig_bV <= "000";
			elsif (reg_counter = "1011") then
				sig_aV <= "00000000";
				sig_bV <= "000";
			end if;
		end if;
	end process convolveV;
	
	accumH <= sig_accum_outH;
	accumV <= sig_accum_outV;

	sig_s <= std_logic_vector((sig_accum_outH + sig_accum_outV)) when reg_counter = "1011";
	
	pixel_out <= sig_o when reg_counter = "1100";
	
end rtl;


