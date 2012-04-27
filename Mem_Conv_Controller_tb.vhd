library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Mem_Conv_Controller;

entity Mem_Conv_Controller_tb is
end entity;

architecture rtl of Mem_Conv_Controller_tb is

component Mem_Conv_Controller is
	port
	(
		clk			:	in	std_logic;
		sload		:	in	std_logic
	);
end component;

begin
	
end;