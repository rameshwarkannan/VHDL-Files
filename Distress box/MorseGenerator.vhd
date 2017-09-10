Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity MorseGenerator is
port(clock :in std_logic;
     pulseout:out std_logic;
	  outseq:out unsigned(5 downto 0));
end entity;

Architecture behavior of MorseGenerator is 
signal d:unsigned(5 downto 0);
signal in1:unsigned(5 downto 0);
signal clock1:std_logic;
begin
presc1:entity work.PreScaler port map(clkin=>clock,clkout=>clock1);
seq1: entity work.sequencer port map(cloc=>clock1,count=>d);
outseq<=d;
 pulseout<= 
           '1' when d= "100001" else
           '1' when d="011111" else
			  '1' when d="011101" else
			  '1' when d="011001" else
			  '1' when d="011000" else
			  '1' when d="010111" else
			  '1' when d="010100" else
			  '1' when d="010011" else
			  '1' when d="010001" else
			  '1' when d="010000" else
			  '1' when d="001111" else
			  '1' when d="001011" else
			  '1' when d="001001" else
			  '1' when d="000111" else
			  '0';
end architecture;	  
		