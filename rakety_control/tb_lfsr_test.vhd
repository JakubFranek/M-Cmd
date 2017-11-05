library ieee;
use ieee.std_logic_1164.all;
 
entity LFSR_TB is
end entity LFSR_TB;
 
architecture behave of LFSR_TB is
 
  constant c_CLK_PERIOD : time := 20 ns;  -- 25 MHz
   
  signal r_Clk : std_logic := '0';
  signal w_LFSR_Data : std_logic_vector(9 downto 0);
  signal w_LFSR_Done, i_En : std_logic;
   
begin
 
  r_Clk <= not r_Clk after c_CLK_PERIOD/2;
   
  LFSR_1 : entity work.LFSR
    port map (
      i_Clk       => r_Clk,
      i_Enable    => '1',
      i_Seed_DV   => i_En,
      i_Seed_Data => "1010101010",
      o_LFSR_Data => w_LFSR_Data,
      o_LFSR_Done => w_LFSR_Done
      );
   
	stim_proc: process
   begin         
        wait for 1 ns;
        i_En <= '1';
        wait for 50 ns;
        i_En <= '0';
        wait;
  end process;
 
end architecture behave;
