library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.decod7seg;

--	This, such as the Saturator, are the Low Level entities. Is here and there 
--	that the lower levels operations happens.
--	The purpose of this circuit is to multiplicate the two entries and 
--	accumulate the result on the previous result (if no previous result, it 
--	will be 0).

entity MAC_signed is
	port
	(
		a			:	in std_logic_vector(7 downto 0);		--	a and b are the in pixels
		b			:	in signed(2 downto 0);
		clk			:	in std_logic;				--	the clock
		sload		:	in std_logic;				--	
		accum_out	:	out signed(15 downto 0);		--	the output pixel 
		s1,	
		s2,	
		s3,	
		s4,	
		s5	:	out	std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of MAC_signed is
component decod7seg is
	port
	(
		a	:	in	std_logic_vector(15 downto 0);
		s1,	
		s2,	
		s3,	
		s4	:	out	std_logic_vector(6 downto 0)
	);
end component;
signal	sa	:	std_logic_vector(15 downto 0);
signal	ss1	:	std_logic_vector(6 downto 0);
signal	ss2	:	std_logic_vector(6 downto 0);
signal	ss3	:	std_logic_vector(6 downto 0);
signal	ss4	:	std_logic_vector(6 downto 0);

signal	a_reg		:	std_logic_vector(7 downto 0);
signal	b_reg		:	signed(2 downto 0);
signal	sload_reg	:	std_logic;
signal	mult_reg	:	signed(15 downto 0);
signal	adder_out	:	signed(15 downto 0);
signal	old_result	:	signed(15 downto 0);

begin
	c7s : decod7seg port map ( a => sa, s1 => ss1, s2 => ss2, s3 => ss3, s4 => ss4);

	mult_reg <= (signed("00000" & a_reg) * b_reg) when sload_reg = '0' else
				"0000000000000000";
	
	process(adder_out, sload_reg)					--	reset the old result or add the sum result
	begin
		if (sload_reg = '1') then
			old_result <= (others => '0');
		else
			old_result <= adder_out;
		end if;
	end process;
	
	process(clk)									--	sum the old result and the mult_reg
	begin
		if (rising_edge(clk)) then
			a_reg <= a;
			b_reg <= b;
			sload_reg <= sload;
			adder_out <= old_result + mult_reg;		--	store the sum result in a register
		end if;
	end process;
	
	accum_out <= adder_out;							--	the pixel resulting is sent to the output
	sa <= std_logic_vector(adder_out);
	
	s1 <= ss1;
	s2 <= ss2;
	s3 <= ss3;
	s4 <= ss4;
	
end rtl;