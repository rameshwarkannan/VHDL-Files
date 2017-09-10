
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity SegDecoder is
		Port (D: in unsigned (3 downto 0);
				Y: out unsigned (6 downto 0));
		end SegDecoder;
architecture behavior of SegDecoder is
	begin
		
	Y<="1000000" when D="0000" else --0
		"1111001" when D="0001" else--1
		"0100100" when D="0010" else--2
		"0110000" when D="0011" else--3
		"0011001" when D="0100" else--4
		"0010010" when D="0101" else--5
		"0000010" when D="0110" else--6
		"1111000" when D="0111" else--7
		"0000000" when D="1000" else--8
		"0011000" when D="1001"; --else--9
		--"0001000" when D="1010" else--10
		--"0000011" when D="1011" else--c
		--"0100111" when D="1100" else--d
		--"0100001" when D="1101" else--E
		--"0000110" when D="1110" else--F
		--"0001110" when D="1111";
end behavior;