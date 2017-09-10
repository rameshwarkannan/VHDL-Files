Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity LB07 is
	Port (
		SW : in std_logic_vector(17 downto 0);
		LEDR : out std_logic_vector(17 downto 0) := (others => '0');
		LEDG : out std_logic_vector(8 downto 0 ) := (others => '0');
		KEY : in std_logic_vector(3 downto 0);
		CLOCK_50 : in std_logic;

		I2C_SDAT : inout std_logic;
		I2C_SCLK, AUD_XCK : out std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACDAT : out std_logic;
		AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic );
End Entity LB07;


Architecture structural of LB07 is

	Signal	AudioIn, AudioOut : signed(15 downto 0);
	Signal	SamClk : std_logic;
	signal  x1: unsigned(15 downto 0); 
	signal clr1:std_logic;
	signal clr2:std_logic;
	signal out3:unsigned(5 downto 0);

Begin
--***********************************************************************************
-- You must enter the last five digits from the student number of one group member.
-- example: 
--	
--		work.AudioInterface generic map ( SID => xxxxx ) - where xxxxx are the last 5 digits.
--
--***********************************************************************************
ASSM: Entity work.AudioInterface	generic map ( SID =>00734  )
			port map (
			Clock_50 => CLOCK_50, AudMclk => AUD_XCK,	-- period is 80 ns ( 12.5 Mhz )
			init => KEY(0), 									-- +ve edge initiates I2C data
			I2C_Sclk => I2C_SCLK,
			I2C_Sdat => I2C_SDAT,
			AUD_BCLK => AUD_BCLK, AUD_ADCLRCK => AUD_ADCLRCK, AUD_DACLRCK => AUD_DACLRCK,
			AUD_ADCDAT => AUD_ADCDAT, AUD_DACDAT => AUD_DACDAT,

			AudioOut => AudioOut, AudioIn => AudioIn, SamClk => SamClk );
          x1<=unsigned(SW(15 DOWNTO 0));
			
			
			Morse1:entity work.MorseGenerator PORT MAP(clock=>samClk,pulseout=>clr1,outseq=>out3);
			LEDG(0)<=clr1;
			clr2<=(not clr1) OR KEY(1);
			Tone1: Entity work. ToneGenerator port map(freq=>x1,clr=>clr2,clk=>SamClk, waveout=>AudioOut);
	--AudioOut <= AudioIn;
	
	
	
	
End Architecture structural;
