Library ieee;
USE ieee.std_logic_1164.all;
ENTITY FULLADDER IS
port(Cin, a, b:IN STD_LOGIC;
	  s, Cout : OUT STD_LOGIC);
END FULLADDER;   

Architecture LogicFunc of FULLADDER is
BEGIN
s<= a XOR b XOR Cin;
Cout<= (a AND b)OR(Cin AND a)OR(Cin AND b);
END LogicFunc;