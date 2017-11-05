LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_timer_test IS
END tb_timer_test;
 
ARCHITECTURE behavior OF tb_timer_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT timer_test
    PORT(
         i_rng : IN  std_logic_vector(9 downto 0);
         i_clk : IN  std_logic;
         i_start : IN  std_logic;
         i_rst : IN  std_logic;
         o_en : OUT  std_logic;
         o_running : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_rng : std_logic_vector(9 downto 0) := (others => '0');
   signal i_clk : std_logic := '0';
   signal i_start : std_logic := '0';
   signal i_rst : std_logic := '0';

 	--Outputs
   signal o_en : std_logic;
   signal o_running : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: timer_test PORT MAP (
          i_rng => i_rng,
          i_clk => i_clk,
          i_start => i_start,
          i_rst => i_rst,
          o_en => o_en,
          o_running => o_running
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      i_rst <= '1';
		i_rng <= "1111100000";
      wait for 100 ns;
		i_rst <= '0';
		i_rng <= "0000011111";
		wait for 100 ns;
		i_start <= '1';
		i_rng <= "0000010101";
		wait for 20 ns;
		i_rng <= "0010010101";
		wait for 20 ns;
		i_rng <= "0100000101";
		wait for 20 ns;
		i_start <= '0';
		i_rng <= "0000001001";
		wait for 100 ns;
		i_rng <= "0000000000";
		wait for 20 ns;
		i_rng <= "0100000101";
		wait for 100 ns;
		i_rng <= "1000100101";
		wait for 20 ns;
		i_rng <= "0100101101";
		wait for 1000 ns;
		i_start <= '1';
		i_rng <= "0010101101";
		wait for 20 ns;
		i_rng <= "0101100101";
		wait for 20 ns;
		i_rng <= "0000001101";
		wait for 100 ns;
		i_start <= '0';
		i_rng <= "1110101111";
		wait for 20 ns;
		i_rng <= "0000000111";		
		wait for 100 ns;
		i_rng <= "0000011111";
		i_rst <= '1';
		wait for 20 ns;
		i_rng <= "0011000111";		
		wait for 100 ns;
		i_rst <= '0';
		i_rng <= "1111100000";
      -- insert stimulus here 

      wait;
   end process;

END;
