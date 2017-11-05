--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:32:49 11/04/2017
-- Design Name:   
-- Module Name:   F:/VUT/TRETAK/DIGITALY/Missile_Command/lfsr_test/tb_top2.vhd
-- Project Name:  lfsr_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_top2 IS
END tb_top2;
 
ARCHITECTURE behavior OF tb_top2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         i_clk : IN  std_logic;
         i_rst : IN  std_logic;
         i_start : IN  std_logic;
         i_seed_dv : IN  std_logic;
         o_en : OUT  std_logic;
         o_running : OUT  std_logic;
         o_display : OUT  std_logic;
         o_x : OUT  std_logic_vector(9 downto 0);
         o_y : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_rst : std_logic := '0';
   signal i_start : std_logic := '0';
   signal i_seed_dv : std_logic := '0';

 	--Outputs
   signal o_en : std_logic;
   signal o_running : std_logic;
   signal o_display : std_logic;
   signal o_x : std_logic_vector(9 downto 0);
   signal o_y : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant i_clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          i_clk => i_clk,
          i_rst => i_rst,
          i_start => i_start,
          i_seed_dv => i_seed_dv,
          o_en => o_en,
          o_running => o_running,
          o_display => o_display,
          o_x => o_x,
          o_y => o_y
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
      wait for 370 ns;
		i_rst <= '0';
		wait for 250 ns;
		i_start <= '1';
		wait for 100 ns;
		i_start <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
