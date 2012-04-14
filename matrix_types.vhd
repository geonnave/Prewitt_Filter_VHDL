library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package matrix_types is
	constant	ecol	:	integer	:=	4;
	constant	elin	:	integer	:=	4;
	constant	rcol	:	integer	:=	2;
	constant	rlin	:	integer	:=	2;
	type matrix_in is array(0 to elin-1, 0 to ecol-1) of std_logic_vector(7 downto 0);
	type matrix_out is array(1 to rlin, 1 to rcol) of std_logic_vector(7 downto 0);
end;
