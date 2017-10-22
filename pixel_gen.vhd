----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pixel_gen is
    Port ( i_VIDEO_ON : in  STD_LOGIC;
           i_PIXEL_X, i_PIXEL_Y : in  STD_LOGIC_VECTOR (9 downto 0);
           o_R,o_G,o_B : out  STD_LOGIC);
end pixel_gen;

architecture Behavioral of pixel_gen is

signal w_comp0_80, w_comp80_160,w_comp160_240,w_comp240_320,w_comp320_400,w_comp400_480,w_comp480_560,w_comp560_640 : std_logic;

signal r_pixel_x : unsigned(9 downto 0);

begin
r_pixel_x <= unsigned(i_pixel_x);

w_comp0_80 <= '1' when r_pixel_x >= 0 and r_pixel_x < 80 else '0';				--nutno od nuly, aby neprechazela barva do dalsiho radku!
w_comp80_160 <= '1' when r_pixel_x > 79 and r_pixel_x < 160 else '0';
w_comp160_240 <= '1' when r_pixel_x > 159 and r_pixel_x < 240 else '0';
w_comp240_320 <= '1' when r_pixel_x > 239 and r_pixel_x < 320 else '0';
w_comp320_400 <= '1' when r_pixel_x > 319 and r_pixel_x < 400 else '0';
w_comp400_480 <= '1' when r_pixel_x > 399 and r_pixel_x < 480 else '0';
w_comp480_560 <= '1' when r_pixel_x > 479 and r_pixel_x < 560 else '0';
w_comp560_640 <= '1' when r_pixel_x > 559 and r_pixel_x < 640 else '0';

o_R <= '0' when ((w_comp0_80='1' or w_comp80_160='1' or w_comp160_240='1' or w_comp240_320='1') and i_video_on='1') else '1';
o_G <= '0' when ((w_comp0_80='1' or w_comp80_160='1' or w_comp320_400='1' or w_comp400_480='1') and i_video_on='1') else '1';
o_B <= '0' when ((w_comp0_80='1' or w_comp160_240='1' or w_comp320_400='1' or w_comp480_560='1') and i_video_on='1') else '1';

end Behavioral;

