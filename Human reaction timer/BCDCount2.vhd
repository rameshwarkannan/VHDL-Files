Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Entity BCDCount2 is
port(clear,enable,clk:in std_logic;
     BCD0,BCD1:OUT unsigned(3 downto 0));
end entity;

Architecture behavior of BCDCount2 is 
signal ones:unsigned(3 downto 0);
signal tens:unsigned(3 downto 0);
begin
process(clk,clear,enable)
begin
if clk'EVENT AND clk='1' THEN
if clear='1' then
 ones<="0000";
 tens<="0000";
elsif enable='1' then
  if (ones="1001") THEN
     ones<="0000";
	 if tens="1001" THEN
     tens<="0000";
	 ELSe
	tens<=tens+"0001";
   END IF;
ELSE 
ones<=ones+"0001";

End if;
end if;
end if;	
BCD0<=ones;
BCD1<=tens;
end process;
end architecture;
