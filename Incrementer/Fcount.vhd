Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity Fcount is
port (D: in unsigned(5 downto 0);
       clk: in std_logic;
		Y: OUT UNSIGNED(5 downto 0));
End Entity;

Architecture behaviour of Fcount is
   signal out5:unsigned(5 downto 0);
begin
--clk<=KEY(0);
--out5<="000000"; 
process(clk)
Begin
if clk'EVENT AND clk='1' THEN
Y<=out5+D;
out5<=out5+D;
end if;
end process;

--D1: DispFrac port map(SW=>D,HEX3=>z,HEX2=>c,HEX1=>b,HEX0=>a);
END ARCHITECTURE;













