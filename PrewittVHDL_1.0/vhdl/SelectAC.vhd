library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--	This, such as the Saturator, are the Low Level entities. Is here and there 
--	that the lower levels operations happens.
--	The purpose of this circuit is to multiplicate the two entries and 
--	accumulate the result on the previous result (if no previous result, it 
--	will be 0).

entity SelectAC is
	port
	(
		a			:	in std_logic_vector(7 downto 0);
		b			:	in signed(2 downto 0);
		clk			:	in std_logic;
		sload		:	in std_logic;
		accum_out	:	out signed(15 downto 0)
	);
end entity;

architecture conv of SelectAC is
signal	a_reg		:	std_logic_vector(7 downto 0);
signal	b_reg		:	signed(2 downto 0)	:=	(others => '0');
signal	sload_reg	:	std_logic;
signal	mult_reg	:	signed(15 downto 0);
signal	adder_out	:	signed(15 downto 0);
signal	old_result	:	signed(15 downto 0);

begin
	
	mult_reg <= signed'("0000000000000000") when b_reg = "000" else
				signed("00000000" & a_reg(7 downto 0)) when b_reg = "001" else
				signed("11111111" & unsigned(not a_reg(7 downto 0)) + 1) when b_reg = "111" else
				signed'("0000000000000000");
	
	process(adder_out, sload_reg)
	begin
		if (sload_reg = '1') then
			old_result <= (others => '0');
		else
			old_result <= adder_out;
		end if;
	end process;
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			a_reg <= a;
			b_reg <= b;
			sload_reg <= sload;
			adder_out <= old_result + mult_reg;
		end if;
	end process;
	
	accum_out <= adder_out;
	
end conv;