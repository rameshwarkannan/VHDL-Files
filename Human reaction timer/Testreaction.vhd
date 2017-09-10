Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Entity Testreaction is
port(SW: IN STD_logic_vector(5 downto 0);
     KEY: IN STD_logic_vector(3 DOWNTO 0);
	  CLOCK_50: IN STD_LOGIC;
	  HEX3,HEX2:OUT unsigned(6 downto 0);
	  LEDR:out unsigned(17 downto 0));
End entity;

Architecture behavior of testreaction is
signal push:std_logic;
signal clk:std_logic;
signal enabl:std_logic;
signal clr:std_logic;
signal clk1:std_logic;
signal led:std_logic;
SIGNAL out3,out4:unsigned(3 downto 0);
component BCDCount2
   port(clear,enable,clk:in std_logic;
     BCD0,BCD1:OUT unsigned(3 downto 0));
end component;

component PreScale
port(clockin : in std_logic;
     clockout: out std_logic);
end COMPONENT;
component SegDecoder
port(D: in unsigned (3 downto 0);
	 Y: out unsigned (6 downto 0));
end component;
Begin
push<=KEY(0);
enabl<=SW(0);	
clr<=KEY(1); 

pre1: PreScale port map(clockin=>CLOCK_50,clockout=>clk1);
process(clk1)
begin
if (clk1'Event and clk1='1') then
--if push='0' then
 --led<='0';
if enabl='0' then
 led<='1';
 else 
 led<='0';
end if;
end if;
end process;

LEDR(0)<= not led;
count1: BCDCount2 port map (clear=>clr,enable=>enabl,clk=>clk1,BCD0=>out3,BCD1=>out4);
decoder1:SegDecoder port map(D=>out4,Y=>HEX3);
decoder2:SegDecoder port map(D=>out3,Y=>HEX2);
eND ARChitecture;
 
