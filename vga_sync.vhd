----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_sync is
    Port ( i_CLK : in  STD_LOGIC;
           o_VSYNC, o_HSYNC, o_VIDEO_ON, o_FRAME_TICK, o_LINE_TICK : out  STD_LOGIC;
			  o_PIXEL_Y, o_PIXEL_X : out STD_LOGIC_VECTOR(9 downto 0)
			  );
end vga_sync;
------------------------------------------------------------------
architecture Behavioral of vga_sync is
	constant HF : integer := 16;
	constant HD : integer := 640;
	constant HR : integer := 96;
	constant HB : integer := 48;
	constant VF : integer := 10;
	constant VD : integer := 480;
	constant VR : integer := 2;
	constant VB : integer := 33;
------------------------------------		
component v_count is
		Generic (VR, VB, VD, VF : integer);
		Port ( i_CLK_EN : in  STD_LOGIC;
			  o_VCOUNT : out  STD_LOGIC_VECTOR (9 downto 0);
			  i_CLK : in  STD_LOGIC;
			  o_VOVF : out  STD_LOGIC);		  
end component;
------------------------------------
component h_count is
		Generic (HF, HD, HR, HB : integer);		
		Port ( i_CLK_EN : in  STD_LOGIC;
			  o_HCOUNT : out  STD_LOGIC_VECTOR (9 downto 0);
			  i_CLK : in  STD_LOGIC;
			  o_HOVF : out  STD_LOGIC);		  
end component;
------------------------------------
component divider_25MHz is
    Port ( i_CLK : in  STD_LOGIC;
           o_CLK_25M_en : out  STD_LOGIC);
end component;
------------------------------------
signal r_EN_25M, r_HOVF : std_logic := '0';
signal r_HCOUNT, r_VCOUNT : std_logic_vector(9 downto 0) := (others => '0');
------------------------------------------------------------------
begin
------------------------------------
Unit1: Divider_25MHz
	Port map(i_CLK => i_CLK, o_CLK_25M_en => r_EN_25M);
------------------------------------
Unit2: v_count
	Generic map(VR => VR, VB => VB, VD => VD, VF => VF)
	Port map(i_CLK => i_CLK, i_CLK_EN => r_HOVF, o_VCOUNT => r_VCOUNT, o_VOVF => o_FRAME_TICK);
------------------------------------	
Unit3: h_count
	Generic map(HR => HR, HB => HB, HD => HD, HF => HF)
	Port map(i_CLK => i_CLK, i_CLK_EN => r_EN_25M, o_HCOUNT => r_HCOUNT, o_HOVF => r_HOVF);	
------------------------------------

o_VSYNC <= 	'0' when (r_VCOUNT > (Std_logic_vector(to_Unsigned(VD+VF, 10))) and (r_VCOUNT <Std_logic_vector(to_Unsigned(VD+VF+VR,10)))) else
				'1';
o_HSYNC <= 	'0' when (r_HCOUNT > (Std_logic_vector(to_Unsigned(HD+HF,10))) and (r_HCOUNT < Std_logic_vector(to_Unsigned(HD+HF+HR,10)))) else
				'1';
o_VIDEO_ON <= 	'1' when (r_VCOUNT < Std_logic_vector(to_Unsigned(VD,10)) and r_HCOUNT < Std_logic_vector(to_Unsigned(HD,10)))	else
					'0';

o_LINE_TICK <= r_HOVF;
o_PIXEL_X <= r_HCOUNT;
o_PIXEL_Y <= r_VCOUNT;


end Behavioral;

