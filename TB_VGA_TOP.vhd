--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:30:21 10/17/2017
-- Design Name:   
-- Module Name:   V:/bndi/VGA/VGA1/TB_VGA_TOP.vhd
-- Project Name:  VGA1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vga_top
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
USE ieee.numeric_std.ALL;
 
ENTITY TB_VGA_TOP IS
END TB_VGA_TOP;
 
ARCHITECTURE behavior OF TB_VGA_TOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_top
    PORT(
         i_clk : IN  std_logic;
         o_hsync : OUT  std_logic;
         o_vsync : OUT  std_logic;
         o_r : OUT  std_logic;
         o_g : OUT  std_logic;
         o_b : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';

 	--Outputs
   signal o_hsync : std_logic;
   signal o_vsync : std_logic;
   signal o_r : std_logic;
   signal o_g : std_logic;
   signal o_b : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_top PORT MAP (
          i_clk => i_clk,
          o_hsync => o_hsync,
          o_vsync => o_vsync,
          o_r => o_r,
          o_g => o_g,
          o_b => o_b
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
      wait for 100 ns;	

      wait for i_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
