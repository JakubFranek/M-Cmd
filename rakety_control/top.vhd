library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port	( i_clk, i_rst, i_start, i_seed_dv: in  STD_LOGIC;
			  o_en, o_running, o_display : out std_logic;
			  o_x, o_y : out std_logic_vector(9 downto 0)
         );
end top;

architecture Behavioral of top is

	component timer_test is
		 Port ( i_rng : in  STD_LOGIC_VECTOR (9 downto 0);
				  i_clk, i_start, i_rst : in  STD_LOGIC;
				  o_en,o_running : out  STD_LOGIC);
	end component;

	component LFSR is  
	  port (
		 i_Clk    : in std_logic;
		 i_Enable : in std_logic; 
		 i_Seed_DV   : in std_logic;
		 i_Seed_Data : in std_logic_vector(9 downto 0);     
		 o_LFSR_Data : out std_logic_vector(9 downto 0);
		 o_LFSR_Done : out std_logic
		 );
	end component;
	
	component LFSR_4b is  
	  port (
		 i_Clk    : in std_logic;
		 i_Enable : in std_logic;
		 
		 i_Seed_DV   : in std_logic;
		 i_Seed_Data : in std_logic_vector(3 downto 0);
		  
		 o_LFSR_Data : out std_logic_vector(3 downto 0);
		 o_LFSR_Done : out std_logic
		 );
	end component;
	
	component raketa_test is
    Port ( i_rng_x : in  STD_LOGIC_VECTOR (9 downto 0);
           i_rng_angle : in  STD_LOGIC_VECTOR (3 downto 0);
           i_clk_move : in  STD_LOGIC;
           i_start_en : in  STD_LOGIC;
           i_rst : in  STD_LOGIC;           
           o_x : out  STD_LOGIC_VECTOR (9 downto 0);
           o_y : out  STD_LOGIC_VECTOR (9 downto 0);
           o_display : out  STD_LOGIC;
           i_clk_50M : in  STD_LOGIC);
	end component;
	
	component clk_div_10us is
    Port ( 	i_clk : in  STD_LOGIC;
				i_rst : in std_logic;
				o_clk_10us : out  STD_LOGIC);
	end component;

	signal r_lfsr_data : std_logic_vector(9 downto 0);
	signal r_lfsr4b_data: std_logic_vector(3 downto 0);
	signal w_lfsr_done, w_lfsr4b_done, r_clk_100k, r_start_en : std_logic;

begin

	unit1: LFSR port map (i_clk => i_clk, i_enable => not(i_rst), i_seed_dv => i_seed_dv, i_seed_data => "0101010101", o_lfsr_data => r_lfsr_data, o_lfsr_done => w_lfsr_done);
	unit2: timer_test port map (i_rng => r_lfsr_data, i_clk => i_clk, i_start => i_start, i_rst => i_rst, o_en => r_start_en, o_running => o_running);
	unit3: LFSR_4b port map (i_clk => i_clk, i_enable => not(i_rst), i_seed_dv => i_seed_dv, i_seed_data => "0011", o_lfsr_data => r_lfsr4b_data, o_lfsr_done => w_lfsr4b_done);
	unit4: clk_div_10us port map (i_clk => i_clk, i_rst => i_rst, o_clk_10us => r_clk_100k);
	unit5: raketa_test port map (i_rng_x => r_lfsr_data, i_rng_angle => r_lfsr4b_data, i_clk_move => r_clk_100k, i_start_en => r_start_en, i_rst => i_rst, o_x => o_x, o_y => o_y, o_display => o_display, i_clk_50M => i_clk);
	
	o_en <= r_start_en;
	
end Behavioral;

