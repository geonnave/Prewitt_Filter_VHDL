library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturator is
	port
	(
		a		:	in std_logic_vector(15 downto 0);
		o		:	out std_logic_vector(7 downto 0)
	);
end entity;

architecture sature of Saturator is
begin
	o <= "00000000" when a(15) = '1' else
		 "11111111" when a(8) = '1' or a(9) = '1' or a(10) = '1' or a(11) = '1' or a(12) = '1' or a(13) = '1' or 
						  a(14) = '1' else
		 a(7 downto 0);
end sature;

