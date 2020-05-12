
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;


Entity Adder is
Generic ( N : natural := 64 );
Port ( A, B : in std_logic_vector( N-1 downto 0 );
Y : out std_logic_vector( N-1 downto 0 );
-- Control signals
Cin : in std_logic;
-- Status signals
Cout, Ovfl : out std_logic );
End Entity Adder;




Architecture behaviour of Adder is 

signal G, P, S, t :std_logic_vector(N-1 downto 0);
signal C :std_logic_vector(N downto 0);
signal v: std_logic;
--GPnet
begin
GPnet: for i in N-1 downto 0
     generate
     begin
	     G(i) <= A(i) and B(i);
	     P(i) <= A(i) xor B(i);
     end generate GPnet;
	 

---Cnet
C(0) <= Cin;
Cnet: for i in N-1 downto 0
     generate
     begin
	 t(i) <= C(i) and P(i);
	 C(i+1) <= G(i) or t(i);
     end generate Cnet;


---Snet: 
Snet: for i in N-1 downto 0
     generate
     begin
	    S(i) <= P(i) xor C(i);
     end generate Snet;

Y <= S;
Cout<= C(N);
Ovfl <= C(N) xor C(N-1);



end;