Library ieee;
Use ieee.std_logic_signed.All;
Use ieee.std_logic_1164.All;
Use ieee.numeric_std.All;
Use ieee.math_real.All;

---------- Entity declaration-------------------------------------
Entity ExecUnit Is
	Generic (N : Natural := 64);
	Port (
		A, B : In std_logic_vector(N - 1 Downto 0);
		NotA : In std_logic := '0';
		FuncClass, LogicFN, ShiftFN : In std_logic_vector(1 Downto 0);
		AddnSub, ExtWord : In std_logic := '0';
		Y : Out std_logic_vector(N - 1 Downto 0);
		Zero, AltB, AltBu : Out std_logic 
	);
End Entity ExecUnit;

Architecture rtl Of ExecUnit Is
    -------------------------Signal declaration-----------------------
	Signal Ain, Bin, Xin, zero_arr, AddC, C : std_logic_vector(N - 1 Downto 0);
	Signal YoutLogicU, YoutShiftU, YFuncClass : std_logic_vector(N - 1 Downto 0);
	Signal YMux1, YMux2, YMux3, YMux4 : std_logic_vector(N - 1 Downto 0);
	Signal FuncClassCtrlSig : std_logic_vector(1 Downto 0);
	
	-- temporary Status Signals/Flags
	Signal Zeroflg, Ovflflg, Coutflg, AltBuFlg, AltBFlg : std_logic; 
Begin
	FuncClassCtrlSig <= FuncClass;
	
	-----------Call the three sub units to start the operation------------------
    -----------AddC from arithmetic unit is passed into shift unit--------------	
	P1 : Entity work.ArithUnit Port Map(A, B, AddC, C, NotA, AddnSub, ExtWord, Coutflg, Ovflflg, Zeroflg, AltBFlg, AltBuFlg);
	P2 : Entity work.ShiftUnit Port Map(A, B, AddC, YoutShiftU, ShiftFN, ExtWord);
    P3 : Entity work.LogicUnit Port Map(A, B, YoutLogicU, LogicFN);

    -------------Fill the 64 bits logic vector with AtlBu flag and 0's---------------------------
	SgnExtAltBu : For j In 63 Downto 1
	Generate
	Begin
		YMux1(j) <= '0';
	End Generate SgnExtAltBu;				
	YMux1(0) <= AltBuFlg;
					
	-------------Fill the 64 bits logic vector with AtlB flag and 0's---------------------------				
	SgnExtAltB : For j In 63 Downto 1
	Generate
	Begin
		YMux2(j) <= '0';
	End Generate SgnExtAltB;
	YMux2(0) <= AltBFlg;
	
	-------------------Store the results from shift and logic unit----------------------
	YMux3 <= YoutShiftU; -- Comes from ShiftUnit PortMap
	YMux4 <= YoutLogicU; -- Comes from LogicUnit PortMap

	-------- Output Stage Mux of the execution unit--------------------------------
	Y <= YMux1 When (FuncClassCtrlSig = "00") Else
		 YMux2 When (FuncClassCtrlSig = "01") Else
		 YMux3 When (FuncClassCtrlSig = "10") Else
		 YMux4 When (FuncClassCtrlSig = "11") Else
		 YMux1;
						
    ----------Set the Status Flags-------------------------------------
	Zero <= Zeroflg;
	AltB <= AltBflg;
	AltBu <= AltBuflg;
 
End Architecture rtl;