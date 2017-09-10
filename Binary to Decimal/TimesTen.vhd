Library ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY TimesTen IS
port(X:IN unsigned(5 downto 0);
     TENX: OUT unsigned(9 downto 0));
END TimesTen;




Architecture operator of TimesTen is
signal a,b:UNSIGNED(9 downto 0);
begin
a<="000" & X(5 DOWNTO 0) &'0';
b<='0' &X(5 DOWNTO 0)&"000";
TENX<= X(5 DOWNTO 0) & "0000";
End architecture operator;


