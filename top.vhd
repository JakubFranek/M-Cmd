library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TOP is
    Port ( i_PS2_DATA : in  STD_LOGIC;
			  i_PS2_CLK	: in STD_LOGIC;
           i_CLK : in  STD_LOGIC;
			  o_ANODE : out STD_LOGIC_VECTOR(3 downto 0);
			  o_LEDS : out  STD_LOGIC_VECTOR (6 downto 0)
			  );
end TOP;
	
architecture Behavioral of TOP is
--------------------------------------------
--FALLING EDGE DETECT-----------------------
	component Falling_edge_detect is
		 Port ( i_CLK : in  STD_LOGIC;
				  i_PS2_CLK : in  STD_LOGIC;
				  o_EDGE_DET : out  STD_LOGIC
				  );
	end component;
--DEBOUNCER---------------------------------
	component Debouncer is
		Port (i_PS2_CLK, i_CLK_EN,i_CLK : in STD_LOGIC;
				o_DEB_OUT : out STD_LOGIC
				);
	end component;
--DIVIDER-----------------------------------	
	component Freq_divider is
    Port ( 	i_CLK	: in  STD_LOGIC;
				o_CLK_EN : out  STD_LOGIC
				);
	end component;
--PS2_RX------------------------------------		
	component PS2_RX is
	 Port ( i_PS2_DATA : in  STD_LOGIC;
           i_EDGE_DET : in  STD_LOGIC;
           i_CLK : in  STD_LOGIC;
			  o_RECEIVED : out STD_LOGIC;
			  o_DATA_OUT : out STD_LOGIC_VECTOR(7 downto 0)			  
			  );
	end component;
--KB_CODE------------------------------------		
	component KB_CODE is
	 Port ( i_CLK : in  STD_LOGIC;
			  i_RECEIVED : in STD_LOGIC;
			  i_DATA_IN : in STD_LOGIC_VECTOR(7 downto 0);
			  o_ENABLE : out STD_LOGIC;
			  o_KB_CODE : out STD_LOGIC_VECTOR(7 downto 0)
			  );
	end component;	
--DECODER------------------------------------	
	component Decoder is
    Port ( i_KB_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           o_ANODE : out  STD_LOGIC_VECTOR (3 downto 0);
           o_LEDS : out  STD_LOGIC_VECTOR (6 downto 0);
			  i_ENABLE : in STD_LOGIC
			  );
	end component;
--------------------------------------------	
	signal w_DEB_OUT_t, r_EDGE_DET_t, r_CLK_EN_t, r_RECEIVED_t, w_ENABLE_t : STD_LOGIC;				--pripona _t = TOP
	signal r_DATA_OUT_t, r_KB_CODE_t : STD_LOGIC_VECTOR(7 downto 0);	
--------------------------------------------	
begin

--FALLING EDGE DETECT-----------------------------------
	Unit1: Falling_edge_detect										--component => top
		Port map(i_CLK => i_CLK, i_PS2_CLK => w_DEB_OUT_t, o_EDGE_DET => r_EDGE_DET_t);	
--DEBOUNCER---------------------------------------------
	Unit2: Debouncer												  
		Port map(i_CLK => i_CLK, i_PS2_CLK => i_PS2_CLK, o_DEB_OUT => w_DEB_OUT_t, i_CLK_EN => r_CLK_EN_t);
--DIVIDER-----------------------------------------------
	Unit3: Freq_divider												 
		Port map(i_CLK => i_CLK, o_CLK_EN => r_CLK_EN_t);
--PS2_RX------------------------------------------------
	Unit4: PS2_RX												 
		Port map(i_CLK => i_CLK, i_PS2_DATA => i_PS2_DATA, i_EDGE_DET => r_EDGE_DET_t, o_DATA_OUT => r_DATA_OUT_t, o_RECEIVED => r_RECEIVED_t);	
--KB_CODE-----------------------------------------------
	Unit5: KB_CODE												 
		Port map(i_CLK => i_CLK, i_DATA_IN => r_DATA_OUT_t, i_RECEIVED => r_RECEIVED_t, o_ENABLE => w_ENABLE_t, o_KB_CODE => r_KB_CODE_t);
--DECODER-----------------------------------------------
	Unit6: Decoder												 
		Port map(i_KB_IN => r_KB_CODE_t, i_ENABLE => w_ENABLE_t, o_ANODE => o_ANODE, o_LEDS=> o_LEDS);			
--------------------------------------------	
end Behavioral;
----------------------------------------------------------------------------------
