
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity JamesBond is
port(
go: in std_logic;
digit: in std_logic_vector(2 downto 0);
clock: in std_logic;
gotCode: out std_logic);
end entity JamesBond;

architecture mission of JamesBond is
type DIstate is (p1,p2,p3,p4); -- p1 1 digit, p2 2 digit, p3 3 digit
signal presSt : DIstate;
signal delay2:std_logic;
signal c:std_logic;
begin
process(go, digit)
begin
if  RISING_EDGE(GO)  then
	CASE presSt is
	when p1 =>
		if digit = "000" then
		presSt <= p2;
		else 
		presSt<=p1;
		end if;
	when p2 =>
		if digit = "000" then
		presSt <= p3;
		else 
		presSt<=p1;
		end if;
	when p3 =>
		if digit = "111" then
		presSt <= p4;
		else
		presSt<=p1;
		end if;
	when p4 =>
	presSt <= p1;
	end case;
end if;
end process;

gotCode <= '1' when presSt = p4 else '0';
end architecture mission;