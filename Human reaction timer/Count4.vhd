Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
 entity count4 is
 port(x :in unsigned(3 downto 0);
     clock,load,enable: in std_logic_vector);	
end entity;	  
	  
	  
	  
	
Architecture behavior of count4 is
signal ones:unsigned(3 downto 0);
begin
ones<=x;
if(ones="1001") then
ones<="0000";
else 
ones<=ones+"0001";
end if;
end architecture;



	 