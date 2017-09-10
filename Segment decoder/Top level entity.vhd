Library ieee;
use ieee.std_logic_1164.all;

entity Part3 is
		Port (SW: in std_logic_vector (17 downto 0);
		KEY:in std_logic_vector(3 downto 0);
	 HEX0, HEX1: out std_logic_vector (6 downto 0));
				
		end Part3;
architecture behavior of Part3 is
signal x1: std_logic_vector(3 downto 0);
signal x2: std_logic_vector(3 downto 0);
	begin
		
		
x1<=SW(3 downto 0) when KEY(0)='0' else SW(13 downto 10);
x2<=SW(7 downto 4) when KEY(0)='0' else SW(17 downto 14);			
decoder1:entity work.SegDecoder port map(D=>x1,Y=>HEX0);
decoder2:entity work.SegDecoder port map(D=>x2,Y=>HEX1);
end behavior;
