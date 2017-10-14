--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:54:53 10/12/2017
-- Design Name:   
-- Module Name:   C:/Users/Dada/Documents/Xilinx/BNDI/PS2_KB/tb_test_v2.vhd
-- Project Name:  ps2_skola2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP
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
 
ENTITY tb_test_v2 IS
END tb_test_v2;
 
ARCHITECTURE behavior OF tb_test_v2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         i_PS2_DATA : IN  std_logic;
         i_PS2_CLK : IN  std_logic;
         i_CLK : IN  std_logic;
         o_ANODE : OUT  std_logic_vector(3 downto 0);
         o_LEDS : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_PS2_DATA : std_logic := '0';
   signal i_PS2_CLK : std_logic := '0';
   signal i_CLK : std_logic := '0';

 	--Outputs
   signal o_ANODE : std_logic_vector(3 downto 0);
   signal o_LEDS : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant i_PS2_CLK_period : time := 40 us;
   constant i_CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          i_PS2_DATA => i_PS2_DATA,
          i_PS2_CLK => i_PS2_CLK,
          i_CLK => i_CLK,
          o_ANODE => o_ANODE,
          o_LEDS => o_LEDS
        );

   -- Clock process definitions
   i_PS2_CLK_process :process
   begin
		i_PS2_CLK <= '1';
		wait for i_PS2_CLK_period/2;
		i_PS2_CLK <= '0';
		wait for i_PS2_CLK_period/2;
   end process;
 
   i_CLK_process :process
   begin
		i_CLK <= '0';
		wait for i_CLK_period/2;
		i_CLK <= '1';
		wait for i_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		--A = 1C = 0001 1100
		--break = F0 = 1111 0000		
	
      -- hold reset state for 100 ns.
      i_PS2_DATA <= '1';
		--wait for 10 us;
		wait for 10 us;
		i_PS2_DATA <= '0';	--start
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '0';	--data 0
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--1		
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--2	
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--3	
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '1';	--4
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--5
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '0';	--6
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--7
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--parity
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--stop								

      wait for i_PS2_CLK_period;
		
		i_PS2_DATA <= '0';	--start
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '0';	--data 0
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--1		
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--2	
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--3	
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '1';	--4
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--5
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '1';	--6
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--7
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--parity
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--stop	

		wait for i_PS2_CLK_period;
		
		i_PS2_DATA <= '0';	--start
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '0';	--data 0
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--1		
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--2	
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--3	
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '1';	--4
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--5
		wait for i_PS2_CLK_period;	
		i_PS2_DATA <= '0';	--6
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--7
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '0';	--parity
		wait for i_PS2_CLK_period;		
		i_PS2_DATA <= '1';	--stop

      wait;
   end process;

END;