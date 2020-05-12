Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.numeric_std.All;
Use ieee.math_real.All;

------------------Entity Declaration---------------------------------------
Entity SLL64 Is
	Generic (N : Natural := 64);
	Port (
		X : In std_logic_vector(N - 1 Downto 0);
		Y : Out std_logic_vector(N - 1 Downto 0);
		ShiftCount : In unsigned(Integer(ceil(log2(real(N)))) - 1 Downto 0) 
	);
End Entity SLL64;

Architecture rtl Of SLL64 Is

	-------------Signal Declaration---------------------------
	Signal muxSelect1, muxSelect2, muxSelect3 : std_logic_vector (1 Downto 0);
	Signal muxOut1, muxOut2, muxOut3 : unsigned (N - 1 Downto 0);
	Signal muxIn1, muxIn2, muxIn3 : std_logic_vector (N - 1 Downto 0);

Begin

    ----- Separate the shift count for each Mux of the barrel shifter-----------
	muxSelect1(0) <= ShiftCount(0);
	muxSelect1(1) <= ShiftCount(1);

	muxSelect2(0) <= ShiftCount(2);
	muxSelect2(1) <= ShiftCount(3);

	muxSelect3(0) <= ShiftCount(4);
	muxSelect3(1) <= ShiftCount(5);

    ---------Value to be shifted--------------------------
	muxIn1 <= X;

    ----------------Perform shift left logic by 0, 1, 2 or 3---------------	
	muxOut1 <= unsigned(muxIn1) When muxSelect1 = "00" Else
	           shift_left(unsigned(muxIn1), 1) When muxSelect1 = "01" Else
	           shift_left(unsigned(muxIn1), 2) When muxSelect1 = "10" Else
	           shift_left(unsigned(muxIn1), 3) When muxSelect1 = "11" Else
	           unsigned(muxIn1);

	muxIn2 <= std_logic_vector(muxOut1);

    ----------------Perform shift left logic by 0, 4, 8 or 12---------------
	muxOut2 <= unsigned(muxIn2) When muxSelect2 = "00" Else
	           shift_left(unsigned(muxIn2), 4) When muxSelect2 = "01" Else
	           shift_left(unsigned(muxIn2), 8) When muxSelect2 = "10" Else
	           shift_left(unsigned(muxIn2), 12) When muxSelect2 = "11" Else
	           unsigned(muxIn2);
 
	muxIn3 <= std_logic_vector(muxOut2);

    ----------------Perform shift left logic by 0, 16, 32 or 48---------------
	muxOut3 <= unsigned(muxIn3) When muxSelect3 = "00" Else
	           shift_left(unsigned(muxIn3), 16) When muxSelect3 = "01" Else
	           shift_left(unsigned(muxIn3), 32) When muxSelect3 = "10" Else
	           shift_left(unsigned(muxIn3), 48) When muxSelect3 = "11" Else
	           unsigned(muxIn3);
 
	Y <= std_logic_vector(muxOut3);

End;