library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturator is
	port
	(
		a		:	in signed(17 downto 0);
		o		:	out signed(8 downto 0)
	);
end entity;

architecture sature of Saturator is
begin
	o <= "000000000" when a(17) = '1' else
--		 "011111111" when a(17 downto 8) = '1' else
		 "011111111" when a(8) = '1' or a(9) = '1' or a(10) = '1' or a(11) = '1' or a(12) = '1' or a(13) = '1' or 
						  a(14) = '1' or a(15) = '1' or a(16) = '1' or a(17) = '1' else
		 a(8 downto 0);
end sature;
