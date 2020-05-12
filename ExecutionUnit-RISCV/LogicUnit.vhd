Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.numeric_std.All;
Use IEEE.std_logic_unsigned.All;

---------------------Entity declaration----------------------------------
Entity LogicUnit Is
	Generic (N : Natural := 64);
	Port (
		A, B : In std_logic_vector (N - 1 Downto 0);
		Y : Out std_logic_vector(N - 1 Downto 0);
		LogicFN : In std_logic_vector(1 Downto 0)
	);
End Entity LogicUnit;

Architecture rtl Of LogicUnit Is
	Signal MuxIn1, MuxIn2, MuxIn3, MuxIn4 : std_logic_vector(N - 1 Downto 0);
Begin
    ---------------Logic Operation---------------------------
	MuxIn1 <= B;
	MuxIn2 <= A Xor B;
	MuxIn3 <= A Or B;
	MuxIn4 <= A And B;

   ----------------Output Stage Mux--------------------------
	Y <= MuxIn1 When LogicFN = "00" Else
	     MuxIn2 When LogicFN = "01" Else
	     MuxIn3 When LogicFN = "10" Else
	     MuxIn4 When LogicFN = "11";
 
End Architecture rtl;