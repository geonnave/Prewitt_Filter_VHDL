library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package filter_masks is
	constant	Prewitt	:	std_logic_vector(3 downto 0) :=	"0000";
	constant	Sharpen	:	std_logic_vector(3 downto 0) :=	"0001";
	constant	Smooth	:	std_logic_vector(3 downto 0) :=	"0010";
	constant	Sobel	:	std_logic_vector(3 downto 0) :=	"0011";
	
	constant	PrewittSize		:	integer	:=	9;
	constant	PrewittMaxBits	:	integer	:=	3;
	constant	mPrewittH		:	std_logic_vector	:=	"001001001000000000111111111";
	constant	mPrewittV		:	std_logic_vector	:=	"001000111001000111001000111";
end;
