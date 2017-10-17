
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_top is
    Port ( i_clk : in  STD_LOGIC;
           o_hsync,o_vsync,o_r,o_g,o_b : out  STD_LOGIC);
end vga_top;

architecture Behavioral of vga_top is


component pixel_gen is
    Port ( i_VIDEO_ON : in  STD_LOGIC;
           i_PIXEL_X, i_PIXEL_Y : in  STD_LOGIC_VECTOR (9 downto 0);
           o_R,o_G,o_B : out  STD_LOGIC);
end component;

component vga_sync is
    Port ( i_CLK : in  STD_LOGIC;
           o_VSYNC, o_HSYNC, o_VIDEO_ON, o_FRAME_TICK, o_LINE_TICK : out  STD_LOGIC;
			  o_PIXEL_Y, o_PIXEL_X : out STD_LOGIC_VECTOR(9 downto 0)
			  );
end component;

signal w_video_on : std_logic;
signal r_pixel_y,r_pixel_x : std_logic_vector(9 downto 0);

begin


unit1: vga_sync port map(i_clk => i_clk, o_vsync => o_vsync, o_hsync => o_hsync,o_video_on => w_video_on, o_pixel_x => r_pixel_x, o_pixel_y => r_pixel_y);
unit2: pixel_gen port map(i_video_on => w_video_on, i_pixel_y => r_pixel_y, i_pixel_x => r_pixel_x, o_r => o_r, o_g => o_g, o_b => o_b);


end Behavioral;

