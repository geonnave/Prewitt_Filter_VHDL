library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemPrewittMaskROM is
	port
	(
		addr	:	in	std_logic;
		clk		:	in std_logic;
		q		:	out std_logic_vector(26 downto 0)
	);
end entity;


architecture rtl of MemPrewittMaskROM is
begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if (addr = '0') then
				q <= "001001001000000000111111111";
			else
				q <= "001000111001000111001000111";
			end if;
		end if;
	end process;
	
end rtl;
