Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity system is
port(doors:in std_logic_vector(3 downto 0);
      ARM: in std_logic;
		cloc :IN std_logic;
		ready:out std_logic;
		sysarm:out std_logic;
		alarmon:out std_logic);
end entity;

Architecture basic of system is
begin
process(cloc,ARM) 
BEGin
IF ARM='0' then
   ready<='0';
	sysarm<='0';
	alarmon<='0';

elsif ARM='1' THEN
   IF doors<="0000" then
	    ready<='1';
	     sysarm<='1';
	     alarmon<='0';
   else
	     ready<='0';
		  sysarm<='1';
		  alarmon<='1';
		  
	end if;
end if;	
	   
  END PROCESS;
END ARCHITECTURE;  
       	