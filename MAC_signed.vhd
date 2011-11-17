library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAC_signed is
	port
	(
		a			:	in signed(8 downto 0);
		b			:	in signed(8 downto 0);
		clk			:	in std_logic;
		sload		:	in std_logic;
		accum_out	:	out signed(17 downto 0)
	);
end entity;

architecture rtl of MAC_signed is

signal	a_reg		:	signed(8 downto 0);
signal	b_reg		:	signed(8 downto 0);
signal	sload_reg	:	std_logic;
signal	mult_reg	:	signed(17 downto 0);
signal	adder_out	:	signed(17 downto 0);
signal	old_result	:	signed(17 downto 0);

begin
	mult_reg <= a_reg * b_reg;
	
	process(adder_out, sload_reg)
	begin
		if(sload_reg = '1') then
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
	
end rtl;


