----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Falling_edge_detect is
    Port ( i_CLK : in  STD_LOGIC;
           i_PS2_CLK : in  STD_LOGIC;
           o_EDGE_DET : out  STD_LOGIC);
end Falling_edge_detect;

architecture Behavioral of Falling_edge_detect is
--------------------------------------------	
	signal w_Y, w_Z : STD_LOGIC;
	signal r_X : std_logic := '0';
--------------------------------------------	
begin
--Registrova cast---------------------------
	process (i_CLK)
	begin
		if(rising_edge(i_CLK)) then
			r_X <= i_PS2_CLK;
			o_EDGE_DET <= w_Z;
		end if;		
	end process;
--Kombinacni cast---------------------------
	w_Z <= not(i_PS2_CLK) and w_Y;
	w_Y <= r_X xor i_PS2_CLK;	
--------------------------------------------	
end Behavioral;
----------------------------------------------------------------------------------
