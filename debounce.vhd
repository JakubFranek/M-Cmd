----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
	Port (i_PS2_CLK, i_CLK_EN, i_CLK : in STD_LOGIC;
			o_DEB_OUT : out STD_LOGIC
			);
end debouncer;

architecture Behavioral of debouncer is
------------------------------------------------
	type states is (s0, s1, s2, s3, s4, s5);
	signal present_state, next_state : states;
------------------------------------------------
begin
--PAMETOVA CAST---------------------------------	
	process (i_CLK) begin
		if (rising_edge(i_CLK)) then				
			present_state <= next_state;
		end if;
	end process;
--KOMBINACNI CAST-------------------------------	
	process(present_state, i_PS2_CLK, i_CLK_EN) begin
			case present_state is
				when s0 => 
					o_DEB_OUT <= '1';
					if(i_PS2_CLK = '0' and i_CLK_EN = '1') then
						next_state <= s1;
					else
						next_state <= s0;
					end if;
					
				when s1 => 
					o_DEB_OUT <= '1';
					if(i_PS2_CLK = '0' and i_CLK_EN = '1') then
						next_state <= s2;
					elsif(i_PS2_CLK = '1' and i_CLK_EN = '1') then
						next_state <= s0;
					else 
						next_state <= s1;		
					end if;	
					
				when s2 => 
					o_DEB_OUT <= '1';
					if(i_PS2_CLK = '0' and i_CLK_EN = '1') then
						next_state <= s3;
					elsif(i_PS2_CLK = '1' and i_CLK_EN = '1') then
						next_state <= s0;
					else 
						next_state <= s2;		
					end if;
					
				when s3 => 
					o_DEB_OUT <= '1';
					if(i_PS2_CLK = '0' and i_CLK_EN = '1') then
						next_state <= s4;
					elsif(i_PS2_CLK = '1' and i_CLK_EN = '1') then
						next_state <= s0;
					else 
						next_state <= s3;		
					end if;	
					
				when s4 => 
					o_DEB_OUT <= '0';		
					if(i_PS2_CLK = '1') then
						next_state <= s0;
					else
						next_state <= s5;
					end if;	
					
				when s5 => 
					o_DEB_OUT <= '0';
					if(i_PS2_CLK = '1' and i_CLK_EN = '1') then
						next_state <= s0;
					else 
						next_state <= s5;		
					end if;	
			end case;	
	end process;
end Behavioral;

