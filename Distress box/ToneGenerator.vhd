Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY ToneGenerator is
port (clk,clr: in std_logic;
      freq: in unsigned(15 downto 0);
		waveout: out signed(15 downto 0));
end entity;

Architecture behavior of ToneGenerator is
signal q1:signed(21 downto 0);	
signal q2:signed(21 downto 0);	
begin

process(clk,clr)
begin
if clr='0' then
  waveout<=(others=>'0');
 elsif clk'event and clk='1' then
    q2<= signed(freq) & "000000";
	 q1<=q1+q2;
end if;
waveout<=q1(21 downto 6);
end process;
end architecture;	 
    
 