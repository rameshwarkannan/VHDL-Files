Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

eNTITY homesecurityalarm IS 
port(KEY:IN STD_LOGIC_VECTOR(3 DOWnto 0);
     SW: IN std_logic_VECTOR(17 DOWNTO 0);
	  CLOCK_50:IN std_logic;
	  LEDG:OUT STD_logic_VECTOR(3 DOWNTO 0);
	  LEDR:OUT STD_logic_VECTOR(3 downto 0);
	  HEX2,HEX1,HEX0: out std_logic_VECTOR(6 downto 0));
	  
end entity;


Architecture behavior of L8 is
signal clock1:std_LOGIC;
signal ready1:std_logic;
signal alarm1:std_logic;
signal sysarm1:std_logic;
signal delay1,out3:std_logic;
SIGNAL CODE:std_logic;
BEGIN
part1:entity work. PreScaler PORT MAP(clkin=>CLOCK_50,clkout=>clock1);
part2:entity work.jamesbond  Port map(clock=>clock1,digit=>SW(17 downto 15),go=>SW(13),gotcode=>code);
code<='1';
LEDG(2)<=code;
part3:entity work. System1 PORT MAP(incode=>code,ARM=>KEY(0),doors=>SW(3 DOWNTO 0),cloc=>clock1,ready=>ready1,sysarm=>LEDG(0),alarmon=>alarm1,delay=>delay1);
part4:entity work.tensecdelay port map(load=>delay1,clk1=>clock1,TC=>out3);
part5:entity work. Alarm PORT MAP(enable=>alarm1,ext=>out3,clock=>clock1,seg2=>HEX2,seg1=>HEX1,seg0=>HEX0); 

END ARCHITECTURE ;