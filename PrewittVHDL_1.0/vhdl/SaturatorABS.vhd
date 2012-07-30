library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Saturator;

entity SaturatorABS is
	port
	(
		a		:	in unsigned(15 downto 0);
		o		:	out unsigned(15 downto 0);
	);
end entity;

architecture sature of SaturatorABS is
begin

	o <= (not(a) + 1) when a(15) = '1' else
		  a;
	
end sature;

