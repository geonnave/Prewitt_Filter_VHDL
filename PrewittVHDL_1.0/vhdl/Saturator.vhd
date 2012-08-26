library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--	This, such as the MAC_signed, are the Low Level entities. Is here and there 
--	that the lower levels operations happens.
--	The purpose of this circuit is to sature the value of one pixel, what means 
--	that if it is over than 255, it have to be setted as 255.

entity Saturator is
	port
	(
		a		:	in std_logic_vector(15 downto 0);	-- value resulting from the sum of prewittH and prewittV
		o		:	out std_logic_vector(7 downto 0)
	);
end entity;

architecture sature of Saturator is
begin
	-- sature the pixel value to 255 if it is over 255
	o <= "11111111" when a(8) = '1' or a(9) = '1' or a(10) = '1' or a(11) = '1' or a(12) = '1' or a(13) = '1' or 
						 a(14) = '1' else
		 a(7 downto 0);
end sature;

