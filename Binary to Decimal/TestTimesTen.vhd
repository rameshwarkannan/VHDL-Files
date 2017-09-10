library ieee;
USE ieee.std_logic_1164.all;
ENTITY TestTimesTen IS
port(SW:IN STD_LOGIC_VECTOR(5 downto 0);
     HEX3,HEX2,HEX1,HEX0: OUT STD_LOGIC_VECTOR(6 downto 0));
END TestTimesTen;

ARCHITECTURE behavior of TestTimesTen is
signal in3,in2,in1,in0: std_LOGIC_VECTOR(5 downto 0);
signal out3,out2,out1,out0:std_LOGIC_VECTOR(9 downto 0);


component TimesTen is
port(X:IN STD_LOGIC_VECTOR(5 downto 0);
     TENX: OUT STD_LOGIC_VECTOR(9 downto 0));
END Component TimesTen;
 
 
 component SegDecoder is
 port(D:In std_LOGIC_VECTOR;
      Y:out std_logic_vector);
END component segdecoder;
BEGIN
in3<=SW(5 downto 0);
BINARYSUM3:TimesTen port map(X=>in3(5 downto 0),TENX=>out3(9 downto 0));
decoder4: entity work.SegDecoder port map(D=>out3(9 downto 6), Y=>HEX3(6 downto 0));
BINARYSUM2:TimesTen port map(X=>out3(5 downto 0),TENX=>out2(9 downto 0));
decoder3: entity work.SegDecoder port map(D=>out2(9 downto 6), Y=>HEX2(6 downto 0));
BINARYSUM1:TimesTen port map(X=>out2(5 downto 0),TENX=>out1(9 downto 0));
decoder2: entity work.SegDecoder port map(D=>out1(9 downto 6), Y=>HEX1(6 downto 0));
BINARYSUM0:TimesTen port map(X=>out1(5 downto 0),TENX=>out0(9 downto 0));
decoder1: entity work.SegDecoder port map(D=>out0(9 downto 6), Y=>HEX0(6 downto 0));
--in3<=SW(5 downto 0);
end;