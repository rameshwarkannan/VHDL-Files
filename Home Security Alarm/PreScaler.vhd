Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity PreScaler is
port(clkin: in std_logic;
     clkout: out std_logic);
end entity;
Architecture behavior of PreScaler is
signal x1: unsigned(17 downto 0);
begin
process(clkin)
begin
if clkin'event and clkin='1' then	
 x1<=x1+ "000000000000000001";
end if;
clkout<=x1(17);
 
end process;
end architecture; 