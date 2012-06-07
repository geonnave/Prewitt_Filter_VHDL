library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SelectAC is
	port(
		a			:	in signed(8 downto 0);
		b			:	in signed(8 downto 0);
		clk			:	in std_logic;
		sload		:	in std_logic;
		accum_out:	out signed(17 downto 0)
		);
end entity;

architecture conv of SelectAC is
signal	a_reg			:	signed(8 downto 0);
signal	b_reg			:	signed(8 downto 0);
signal	sload_reg		:	std_logic;
signal	mult_reg		:	signed(17 downto 0);
signal	adder_out		:	signed(17 downto 0);
signal	old_result		:	signed(17 downto 0);
begin
	
--	mult_reg <= a_reg * b_reg;
	mult_reg <= (others => '0') when b_reg = "000000000" else
				'0' & "000000000" & a_reg(7 downto 0) when b_reg = "000000001" else
				'1' & "111111111" & ((not a_reg(7 downto 0)) + 1);
	
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