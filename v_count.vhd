----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity v_count is
		Generic (VR, VB, VD, VF : integer);
		Port ( i_CLK_EN : in  STD_LOGIC;
			  o_VCOUNT : out  STD_LOGIC_VECTOR (9 downto 0);
			  i_CLK : in  STD_LOGIC;
			  o_VOVF : out  STD_LOGIC);		  
end v_count;

architecture Behavioral of v_count is
	
	signal q_reg, d_int : unsigned(9 downto 0) := (others=>'0');

begin
	
	process(i_CLK, i_CLK_EN)
	begin
		if(rising_edge(i_CLK)) then
			if(i_CLK_EN = '1') then
				q_reg <= d_int;
			end if;			
		end if;
	end process;
	
	d_int <= (others=>'0') when (q_reg=(To_Unsigned(VF,10)+To_Unsigned(VD,10)+To_Unsigned(VR,10)+To_Unsigned(VB,10)-1)) else
				q_reg+1;
				
	o_VOVF <= 	'1' when (q_reg = (To_Unsigned(VF,10)+To_Unsigned(VD,10)+To_Unsigned(VR,10)+To_Unsigned(VB,10)-1)) else
					'0';
	o_VCOUNT <= std_logic_vector(q_reg);			

end Behavioral;

