----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider_25MHz is
    Port ( i_CLK : in  STD_LOGIC;
           o_CLK_25M_en : out  STD_LOGIC);
end divider_25MHz;

architecture Behavioral of divider_25MHz is

	signal clk_d_int, clk_q_reg : std_logic;
	signal d_int, q_reg : unsigned(6 downto 0) := (others=>'0');
----------------------------------------------------------
begin
--pametova cast - preneseni vstupu KO D na vystup s hranou
	process (i_CLK) begin
		if (rising_edge(i_CLK)) then
			q_reg <= d_int;
			clk_q_reg <= clk_d_int;
		end if;
	end process;
--kombinacni cast - pripraveni dalsiho vstupu pro KO D
	d_int <= (others=>'0') when (q_reg = 1) else							
				(q_reg+1);					
	clk_d_int <= 	'1' when (q_reg = 1)	else			--1 clk puls						
						'0';
----------------------------------------------------------						
	o_CLK_25M_en <= clk_q_reg;


end Behavioral;

