Library ieee;
use ieee.std_logic_1164.all;

entity Part2 is
		Port (SW: in std_logic_vector (17 downto 0);
				LEDR: out std_logic_vector (17 downto 0));
		end Part2;
architecture csa of Part2 is
	begin
		LEDR <= SW;
end csa;