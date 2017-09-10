Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity Alarm is
port(enable: in std_logic;
     clock,ext:IN std_logic;
     seg2,seg1,seg0: OUT std_logic_vector(6 downto 0));
	  
end entity;

Architecture behavior of Alarm is

signal counter:integer:=0;
begin

process(clock,enable)
begin
if enable='0' THEN
  seg2<="1111111";
  seg1<="1111111";
  seg0<="1111111";
ELSE
  if clock'event and clock='1' THEN
       counter<=counter+1; 
		 if counter=100 then
		   counter<=0;
		elsif counter>50 and ext='0'	then
       seg2<="0011000";
	     seg1<="1111001";
	     seg0<="1111001";
		  else 
		  seg2<="1111111";
        seg1<="1111111";
        seg0<="1111111";
	  end if;
	END IF;
END IF; 	
END PROCESS;
END ARCHITECTURE;
   
