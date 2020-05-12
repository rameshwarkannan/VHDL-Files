library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

------------Entity declaration for Shift Unit---------------------
Entity ShiftUnit is
            Generic ( N : natural := 64 );
            Port ( A, B, C : in std_logic_vector( N-1 downto 0 );
                   Y : out std_logic_vector( N-1 downto 0 );
                   ShiftFN : in std_logic_vector( 1 downto 0 );
                   ExtWord : in std_logic );
End Entity ShiftUnit;

Architecture rtl of ShiftUnit is

-------------Signal declaration----------------------------------
signal A_swapped: std_logic_vector (N-1 downto 0);
signal Mux1_select: std_logic;
signal Mux1_out, Mux2_out, Mux3_out, Mux4_out, Mux5_out: std_logic_vector (N-1 downto 0);
signal ShiftCount: unsigned (5 downto 0);
signal SLL_out: std_logic_vector (N-1 downto 0);
signal SRL_out: std_logic_vector (N-1 downto 0);
signal SRA_out, tempB: std_logic_vector (N-1 downto 0);
signal Mux2_out_ext, Mux3_out_ext: std_logic_vector (N-1 downto 0);


begin
    ------------Swap Word of A-------------------------------------
    swap: for i in 31 downto 0
	      generate
		  begin
	           A_swapped(i+32) <= A(i);
		  end generate swap;
	
    swap1: for i in 31 downto 0
	      generate
		  begin
	           A_swapped(i) <= A(i+32);
		  end generate swap1;	
	
	
	--------------Mux1 to select between A or Swap Word of A-----------------
	Mux1_select <= ShiftFN(1) AND ExtWord;
	
	Mux1_out <= A when (Mux1_select = '0') else
	            A_swapped when (Mux1_select = '1') else
				A;
				
				
	------------Extract last 6 bits for 64 bit operations or last 5 bits for 32 bit operations----
	Extract: for i in 63 downto 6
	      generate
		  begin
		       tempB(i) <= B(i);
		  end generate Extract;
		  
    --tempB first extracts the value from B based on 64 bits or 32 bits 
	tempB(5) <= '0' when ExtWord = '1' else
				B(5) when ExtWord = '0' else
				'0';
				
	Extract1: for i in 4 downto 0
	  generate
	  begin
		   tempB(i) <= B(i);
	  end generate Extract1;
  
  	Extract2: for i in 5 downto 0
	      generate
		  begin
		       ShiftCount(i) <= tempB(i);
		  end generate Extract2;
		  
		  
	-------------All three shifting are computed : Shift Right Arithmetic, Shift Right Logic,
	-------------and Shift Left Logic
	SLL1: entity work.SLL64 port map(Mux1_out, SLL_out, ShiftCount);
	SRL1: entity work.SRL64 port map(Mux1_out, SRL_out, ShiftCount);
	SRA1: entity work.SRA64 port map(Mux1_out, SRA_out, ShiftCount);
	
	
	------------MUX2 to select between SLL output or Pass C----------------
	Mux2_out <= C when (ShiftFN(0) = '0') else
	            SLL_out when (ShiftFN(0) = '1') else
				C;
	
		       
	------------MUX3 to select between SRL output or SRA output---------------
	Mux3_out <= SRL_out when (ShiftFN(0) = '0') else
	            SRA_out when (ShiftFN(0) = '1') else
				SRL_out;
				
    ------------Sign Extend Lower----------------------------------------------
	SgnExt1: for i in 31 downto 0
	      generate
		  begin
		       Mux2_out_ext(i) <= Mux2_out(i);
		  end generate SgnExt1;
    	
	SgnExt2: for i in 63 downto 32
	      generate
		  begin
		       Mux2_out_ext(i) <= Mux2_out(31);
		  end generate SgnExt2;
		  
		  
	-------------MUX4 to select between sign extended version or Mux2_output-----------
	Mux4_out <= Mux2_out when (ExtWord = '0') else
	            Mux2_out_ext when (ExtWord = '1') else
				Mux2_out;
				
	
	------------Sign Extend Upper-------------------------------------------------------
	SgnExt3: for i in 31 downto 0
	      generate
		  begin
		       Mux3_out_ext(i) <= Mux3_out(i+32);
		  end generate SgnExt3;
    	
	SgnExt4: for i in 63 downto 32
	      generate
		  begin
		       Mux3_out_ext(i) <= Mux3_out(63);
		  end generate SgnExt4;	  
			   

    -------------MUX5 to select between Mux3_output or Sign extended version------------
	Mux5_out <= Mux3_out when (ExtWord = '0') else
	            Mux3_out_ext when (ExtWord = '1') else
				Mux3_out;



    -------------MUX6 - Output Stage Mux-------------------------------------------------
    Y <= Mux4_out when (ShiftFN(1) = '0') else
	     Mux5_out when (ShiftFN(1) = '1') else
		 Mux4_out;

end architecture rtl;