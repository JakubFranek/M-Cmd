--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:24:06 11/02/2017
-- Design Name:   
-- Module Name:   F:/VUT/TRETAK/DIGITALY/Missile_Command/lfsr_test/tb_top.vhd
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
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         i_clk : IN  std_logic;
         i_rst : IN  std_logic;
         i_start : IN  std_logic;
			i_seed_dv : in std_logic;
         o_en : OUT  std_logic;
         o_running : OUT  std_logic
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
      -- hold reset state for 100 ns.
      i_rst <= '1';
      wait for 100 ns;
		i_rst <= '0';
		wait for 100 ns;
		i_start <= '1';
		wait for 50 ns;
		i_start <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
