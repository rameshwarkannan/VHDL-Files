Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY DispFrac IS
port(SW:IN unsigned(5 downto 0);
     HEX3,HEX2,HEX1,HEX0: OUT unsigned(6 downto 0);
	  KEY:IN std_logic_vector(3 downto 0));
END DispFrac;

ARCHITECTURE behavior of DispFrac is
signal in3,in2,in1,in0: unsigned(5 downto 0);
signal out3,out2,out1,out0:unsigned(3 downto 0);
signal out4:unsigned(3 downto 0);

component TimesTen is
port(X:IN unsigned(5 downto 0);
     TENX: OUT unsigned(9 downto 0));
END Component TimesTen;
 
 
 component SegDecoder is
 port(D:In unsigned;
      Y:out unsigned);
END component segdecoder;
component SecCount is
port (
reset: in std_logic;
       clock: in std_logic;
		Y: OUT UNSIGNED(3 downto 0);
		Y1: OUT UNSIGNED(3 DOWNTO 0));
End component SecCount;		
BEGIN
in3<=SW(5 downto 0);
f1:SecCount port map(clock=>KEY(0),reset=>key(1),Y=>out4,Y1=>out3);


--BINARYSUM3:TimesTen port map(X=>out4(5 downto 0),TENX=>out3(9 downto 0));
decoder4: entity work.SegDecoder port map(D=>out4(3 downto 0), Y=>HEX3(6 downto 0));
--BINARYSUM2:TimesTen port map(X=>out3(5 downto 0),TENX=>out2(9 downto 0));
decoder3: entity work.SegDecoder port map(D=>out3(3 downto 0), Y=>HEX2(6 downto 0));
--BINARYSUM1:TimesTen port map(X=>out2(5 downto 0),TENX=>out1(9 downto 0));
--decoder2: entity work.SegDecoder port map(D=>out1(9 downto 6), Y=>HEX1(6 downto 0));
--BINARYSUM0:TimesTen port map(X=>out1(5 downto 0),TENX=>out0(9 downto 0));
--decoder1: entity work.SegDecoder port map(D=>out0(9 downto 6), Y=>HEX0(6 downto 0));







--in3<=SW(5 downto 0);
end;