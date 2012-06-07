library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Convolution is
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
		accum						:	out signed(15 downto 0)		--just for test, to see the results
	);
end entity;

architecture rtl of Convolution is

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

signal 	sig_a			:	std_logic_vector(7 downto 0)	:= (others => '0');
signal 	sig_b			:	signed(2 downto 0)				:= (others => '0');
signal 	sig_clk			:	std_logic;
signal 	sig_sload		:	std_logic;
signal 	sig_accum_out	:	signed(15 downto 0)		:= (others => '0');

signal	reg_counter		:	unsigned(3 downto 0)	:= "1011";

for mac: MAC_signed use entity work.MAC_signed;

begin
	mac: MAC_signed port map (
		a => sig_a, b => sig_b, clk => sig_clk, sload => sig_sload, accum_out => sig_accum_out
	);
	
	sig_clk <= clk;
	sig_sload <= sload;
	
	counter: process(clk)
	begin
		if (rising_edge(clk)) then
			count <= reg_counter;
			if (reg_counter = "1011" or sig_sload = '1') then
				reg_counter <= "0000";
			else
				reg_counter <= reg_counter + 1;
			end if;
		end if;
	end process counter;
	
	convolve: process(reg_counter, clk)
	begin
		if (rising_edge(clk)) then
		    if(reg_counter = "0000") then
				sig_a <= "00000000";
				sig_b <= "000";
			elsif (reg_counter = "0001") then
				sig_a <= in_x0y0;
				sig_b <= mf_x0y0;
			elsif (reg_counter = "0010") then
				sig_a <= in_x0y1;
				sig_b <= mf_x0y1;
			elsif (reg_counter = "0011") then
				sig_a <= in_x0y2;
				sig_b <= mf_x0y2;
			elsif (reg_counter = "0100") then
				sig_a <= in_x1y0;
				sig_b <= mf_x1y0;
			elsif (reg_counter = "0101") then
				sig_a <= in_x1y1;
				sig_b <= mf_x1y1;
			elsif (reg_counter = "0110") then
				sig_a <= in_x1y2;
				sig_b <= mf_x1y2;
			elsif (reg_counter = "0111") then
				sig_a <= in_x2y0;
				sig_b <= mf_x2y0;
			elsif (reg_counter = "1000") then
				sig_a <= in_x2y1;
				sig_b <= mf_x2y1;
			elsif (reg_counter = "1001") then
				sig_a <= in_x2y2;
				sig_b <= mf_x2y2;
			elsif (reg_counter = "1010") then
				sig_a <= "00000000";
				sig_b <= "000";
			end if;
		end if;
	end process convolve;

	accum <= sig_accum_out;
	
	pixel_out <= sig_accum_out when reg_counter = "1011";
	
end rtl;


