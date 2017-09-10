Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity SecCount is
   Port( clock : in std_logic;
	      reset:in std_logic;
	 Y : out unsigned(3 downto 0);
	 Y1: OUT UNSIGNED(3 downto 0));
End Entity SecCount;

--**********************************************************************************
-- The First solution
--**********************************************************************************
Architecture First of SecCount is
signal ones:unsigned(3 downto 0);
signal tens:unsigned(3 downto 0);

begin
--clk<=KEY(0);
--out5<="000000"; 
process(clock)
Begin
 if clock'EVENT AND clock='1' THEN
if(ones="1001") then
    ones<="0000";
	 if(tens="0101") then
	 tens<="0000";
	 else
	 tens<=tens+1;
	 end if;
else
ones<=ones+1;
end if;
end if;
Y<=tens;
Y1<=ones;
end process;

End Architecture;