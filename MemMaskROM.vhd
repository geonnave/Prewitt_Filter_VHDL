library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemMaskROM is
	port
	(
		addr	:	in	std_logic_vector(3 downto 0);
		clk		:	in std_logic;
		q		:	out std_logic_vector(26 downto 0)
	);
end entity;


architecture rtl of MemMaskROM is
begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if (addr = "0000") then
				q <= "001001001000000000111111111";
			elsif (addr = "0001") then
				q <= "001000111001000111001000111";
			end if;
		end if;
	end process;
	
end rtl;
