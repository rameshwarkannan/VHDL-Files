Library ieee;
USE ieee.std_logic_1164.all;
ENTITY HALFADDER IS
port(a, b:IN STD_LOGIC;
	  s, Cout : OUT STD_LOGIC);
END HALFADDER;   

Architecture LogicFunc of HALFADDER is
BEGIN
s<= a XOR b;
Cout<=a AND b;
END LogicFunc;