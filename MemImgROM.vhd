library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_types.all;

entity MemImgROM is
	port
	(
		addr_i	:	in	natural		range 0 to elin;
		addr_j	:	in	natural		range 0 to ecol;
		clk		:	in std_logic;
		q		:	out std_logic_vector(7 downto 0)
	);
end entity;


architecture rtl of MemImgROM is

	-- Build a 2-D array type for the RoM
	subtype pixel is std_logic_vector(7 downto 0);
	type memory_t is array(0 to elin, 0 to ecol) of pixel;
		
	function init_rom
		return memory_t is
		variable tmp : memory_t;
		begin
			for addr_i_pos in 0 to elin loop
				for addr_j_pos in 0 to ecol loop
					if (elin >= 14 and ecol >= 14) then
						if (addr_i_pos > 4 and addr_i_pos < 14 and addr_j_pos > 4 and addr_j_pos < 14) then
							tmp(addr_i_pos, addr_j_pos) := "01000000";
						else
							tmp(addr_i_pos, addr_j_pos) := "00010000";
						end if;
					else
						tmp(addr_i_pos, addr_j_pos) := "00000000";
					end if;
				end loop;
			end loop;
		return tmp;
	end init_rom;
	
	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := init_rom;
	
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			q <= rom(addr_i, addr_j);
		end if;
	end process;
		
end rtl;
