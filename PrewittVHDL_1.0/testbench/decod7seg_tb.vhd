library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity decod7seg_tb is
end entity;


architecture test_bench of decod7seg_tb is

component decod7seg is
	port
	(
		a	:	in	std_logic_vector(15 downto 0);
		s1,	
		s2,	
		s3,	
		s4,	
		s5	:	out	std_logic_vector(6 downto 0)
	);
end component;

signal	sa	:	std_logic_vector(15 downto 0);
signal	ss1	:	std_logic_vector(6 downto 0);
signal	ss2	:	std_logic_vector(6 downto 0);
signal	ss3	:	std_logic_vector(6 downto 0);
signal	ss4	:	std_logic_vector(6 downto 0);
signal	ss5	:	std_logic_vector(6 downto 0);

begin
	dut : decod7seg port map ( a => sa, s1 => ss1, s2 => ss2, s3 => ss3, s4 => ss4, s5 => ss5);
	
	tb : process
	begin
		wait for 20 ns;
		sa <= "0000000000000000";
		wait for 20 ns;
		assert (ss1 = "0000000" and ss5 = "1111110") report "case1 failed";
		sa <= "0000001111111110";
		wait for 20 ns;
		assert (ss1 = "0000000" and ss5 = "1101101") report "case2 failed";
		sa <= "0000111111111001";
		wait for 20 ns;
		assert (ss1 = "0000000" and ss5 = "1111011") report "case3 failed";
		wait for 20 ns;
	end process tb;

end test_bench;