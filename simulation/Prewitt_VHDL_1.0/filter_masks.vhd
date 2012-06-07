library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package filter_masks is
	constant	PrewittSize		:	integer	:=	3;
	constant	mPrewittH		:	std_logic_vector	:=	"001001001000000000111111111";
	constant	mPrewittV		:	std_logic_vector	:=	"001000111001000111001000111";
end;
