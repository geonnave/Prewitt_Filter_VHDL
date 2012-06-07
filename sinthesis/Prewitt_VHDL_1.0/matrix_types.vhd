library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package matrix_types is
	constant	rcol	:	integer	:=	4;			--->numbers of columns and lines to be crossed in the image
	constant	rlin	:	integer	:=	4;			--´
	constant	ecol	:	integer	:=	rcol+2;		--->numbers of columns and lines of the image in
	constant	elin	:	integer	:=	rlin+2;		--´
	type matrix_in is array(0 to elin-1, 0 to ecol-1) of std_logic_vector(7 downto 0);
	type matrix_out is array(1 to rlin, 1 to rcol) of std_logic_vector(7 downto 0);
end;
