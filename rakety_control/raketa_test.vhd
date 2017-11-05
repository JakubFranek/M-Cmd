library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity raketa_test is
    Port ( i_rng_x : in  STD_LOGIC_VECTOR (9 downto 0);
           i_rng_angle : in  STD_LOGIC_VECTOR (3 downto 0);
           i_clk_move : in  STD_LOGIC;
           i_start_en : in  STD_LOGIC;
           i_rst : in  STD_LOGIC;           
           o_x : out  STD_LOGIC_VECTOR (9 downto 0);
           o_y : out  STD_LOGIC_VECTOR (9 downto 0);
           o_display : out  STD_LOGIC;
           i_clk_50M : in  STD_LOGIC);
end raketa_test;

architecture Behavioral of raketa_test is

	type state is (s_active, s_off);
	signal next_state, present_state : state;
	signal r_x, r_y, r_x_next, r_y_next : unsigned(9 downto 0) := (others => '0');
	signal w_dx : signed(3 downto 0);
	signal w_dy : unsigned(3 downto 0);
	signal r_angle : unsigned(3 downto 0) := (others => '0');
	
begin

	process(i_start_en, i_clk_50M, i_rst)begin
		if i_rst='1' then
			r_angle <= (others => '0');
		elsif rising_edge(i_clk_50M) and i_start_en = '1' then
			r_angle <= unsigned(i_rng_angle);
		end if;
	end process;
	
	process(i_clk_50M, i_rst)begin
		if i_rst='1' then
			present_state <= s_off;
		elsif rising_edge(i_clk_50M) then
			present_state <= next_state;
		end if;
	end process;
	
	process(i_clk_move, i_clk_50M, i_rst)begin
		if i_rst = '1' then
			r_x <= (others => '0');
			r_y <= (others => '0');
		elsif rising_edge(i_clk_50M) then
			if i_start_en = '1' then
				r_x <= unsigned(i_rng_x);
			elsif i_clk_move = '1' then
				r_x <= r_x_next;
				r_y <= r_y_next;
			end if;
		end if;
	end process;
	
	r_x_next <= (r_x + unsigned(w_dx(3) & w_dx(3) & w_dx(3) & w_dx(3) & w_dx(3) & w_dx(3) & w_dx)) when 
					(present_state = s_active) else (others => '0');
	r_y_next <= (r_y + w_dy) when (present_state = s_active) else (others => '0');
	
	process(present_state, i_clk_50M, i_start_en, r_x, r_y) begin
		case present_state is
			when s_off =>
				o_display <= '0';
				if i_start_en = '1' then
					next_state <= s_active;
				else
					next_state <= s_off;
				end if;
			when s_active =>
				o_display <= '1';
				if r_y > 479 or r_x > 639 then
					next_state <= s_off;
				else
					next_state <= s_active;
				end if;
		end case;		
	end process;

	process(r_angle)begin
    case r_angle is
        when "0000" => w_dx <= "0000"; w_dy <= "0001";
        when "0001" => w_dx <= "0001"; w_dy <= "0001";
        when "0010" => w_dx <= "0010"; w_dy <= "0010";
        when "0011" => w_dx <= "0011"; w_dy <= "0011";
		  when "0100" => w_dx <= "0100"; w_dy <= "0100";
        when "0101" => w_dx <= "0101"; w_dy <= "0101";
		  when "0110" => w_dx <= "0110"; w_dy <= "0110";
        when "0111" => w_dx <= "0111"; w_dy <= "0111";
        when "1000" => w_dx <= "1000"; w_dy <= "1000";
		  when "1001" => w_dx <= "1001"; w_dy <= "1001";
        when "1010" => w_dx <= "1010"; w_dy <= "1010";
        when "1011" => w_dx <= "1011"; w_dy <= "1011";
        when "1100" => w_dx <= "1100"; w_dy <= "1100";
		  when "1101" => w_dx <= "1101"; w_dy <= "1101";
        when "1110" => w_dx <= "1110"; w_dy <= "1110";
        when "1111" => w_dx <= "1111"; w_dy <= "1111";
        when others => w_dx <= "0000"; w_dy <= "0000";
    end case;
	end process;

	o_x <= std_logic_vector(r_x);
	o_y <= std_logic_vector(r_y);

end Behavioral;