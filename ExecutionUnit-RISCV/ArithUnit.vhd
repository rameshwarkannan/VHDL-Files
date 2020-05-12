Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.numeric_std.All;
Use IEEE.std_logic_unsigned.All;

------------------Entity declaration----------------------------------------
Entity ArithUnit Is
	Generic (N : Natural := 64);
	Port (
		A, B : In std_logic_vector(N - 1 Downto 0);
		AddY, Y : Out std_logic_vector(N - 1 Downto 0);

		-- Control signals
		NotA, AddnSub, ExtWord : In std_logic := '0';

		-- Status signals
		Cout, Ovfl, Zero, AltB, AltBu : Out std_logic 
	);
End Entity ArithUnit;

Architecture rtl Of ArithUnit Is

-----------------Signal declaration----------------------------------------
	Signal Ain, Bin, zero_arr, Y_temp : std_logic_vector(N - 1 Downto 0);
	Signal Sumout, CoutAdder, Yout : std_logic_vector(N - 1 Downto 0);
	Signal AMux1, AMux2, BMux1, BMux2, ExtWordMux1, ExtWordMux2 : std_logic_vector(N - 1 Downto 0);
	Signal AddnSubCtrlSig, NotACtrlSig, ExtWordCtrlSig : std_logic; -- Control Signals
	Signal Zeroflg, Ovflflg, Coutflg : std_logic; -- Status Signals/Flags

Begin

    ----------Assign control signals to local signal variable-----------------
	ExtWordCtrlSig <= ExtWord;
	AddnSubCtrlSig <= AddnSub; 
	NotACtrlSig <= NotA;

	-- -----------------A & Not A--------------------------------------------
	AMux1 <= A;
	AMux2 <= Not A;

	-- ------------------B & Not B-------------------------------------------
	BMux1 <= B;
	BMux2 <= Not B;

	----------------------Mux Logic for selecting A or ANot--------------------
	Ain <= AMux1 When (NotACtrlSig = '0') Else
	       AMux2 When (NotACtrlSig = '1') Else
	       AMux1;

	-----------------------Mux Logic for selecting B or BNot-------------------
	Bin <= BMux1 When (AddnSubCtrlSig = '0') Else
	       BMux2 When (AddnSubCtrlSig = '1') Else
	       BMux1;

	-------------------Adder Port Map Statement-----------------------------
	A1 : Entity work.adder Port Map(Ain, Bin, Sumout, AddnSub, Coutflg, Ovflflg);

    ----------Zero flag calculation by using OR gates and NOT gate--------------
	Zero_arr(1) <= Sumout(0) Or Sumout(1);
	ZeroSumout : For i In 63 Downto 2
	Generate
		Zero_arr(i) <= Zero_arr(i - 1) Or Sumout(i);
	End Generate;
	Zero <= Not Zero_arr(63);

    ------------------AtlB & AtlBu flags calculation----------------------------
	AltBu <= Not Coutflg;
	AltB <= Sumout(63) Xor Ovflflg;

    -- 64 bit adder output loaded into 64 bit vector----------------------------
	ExtWordMux1 <= Sumout; 

    ----------------------------Extract lower 32 bits---------------------------
	ExtWordLower32Loop : For j In 31 Downto 0 
	Generate
	Begin
		ExtWordMux2(j) <= Sumout(j);
	End Generate ExtWordLower32Loop;

    ------------------- Sign extend to 64 bit-----------------------------------
	SgnExtLower32Loop : For j In 63 Downto 32 
	Generate
	Begin
		ExtWordMux2(j) <= Sumout(31);
	End Generate SgnExtLower32Loop;

    -------------------Flag output----------------------------------------------
	Cout <= Coutflg;
	Ovfl <= Ovflflg;

    -------------------Output Stage Mux-----------------------------------------
	Y <= ExtWordMux1 When (ExtWordCtrlSig = '0') Else
		 ExtWordMux2 When (ExtWordCtrlSig = '1') Else
		 ExtWordMux1;

	AddY <= ExtWordMux1;

End Architecture rtl;