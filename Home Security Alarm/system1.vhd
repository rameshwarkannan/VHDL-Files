Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity system1 is
port(doors:in std_logic_vector(3 downto 0);
      ARM: in std_logic;
		incode:in std_logic;
		cloc :IN std_logic;
		ready:out std_logic;
		sysarm:out std_logic;
		alarmon:out std_logic;
		delay :out std_logic);
end entity;

Architecture Delayed of system1 is
SIGNAL temp1:unsigned(5 downto 0);
begin

process(cloc,ARM) 
BEGin
if rising_edge(ARM) and incode='1' then
temp1<=temp1+"000001";
else
temp1<=temp1;
end if;
IF temp1(0)='0' then
   ready<='0';
	sysarm<='0';
	alarmon<='0';
	delay<='0';

elsif temp1(0)='1' THEN
   IF doors<="0000" then
	     delay<='0';
	     ready<='1';
	     sysarm<='1';
	     alarmon<='0';
   else
	     delay<='1';
	     ready<='0';
		  sysarm<='1';
		  alarmon<='1';
		  
	end if;
end if;	  
  END PROCESS;
END ARCHITECTURE;