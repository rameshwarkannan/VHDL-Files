Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity PreScale is
port(clockin : in std_logic;
     clockout: out std_logic);
end entity;
 
 
Architecture behavior of PreScale is
signal Q:unsigned(19 downto 0);
begin
process(clockin)
begin
if clockin'EVENT AND clockin='1' THEN
Q<=Q+"00000000000000000001";
END IF;
clockout<=Q(19);
End process;
End architecture;