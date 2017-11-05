--------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity timer_test is
    Port ( i_rng : in  STD_LOGIC_VECTOR (9 downto 0);
           i_clk, i_start, i_rst : in  STD_LOGIC;
           o_en,o_running : out  STD_LOGIC);
end timer_test;

architecture Behavioral of timer_test is

	type state is (s_counting, s_sleep);
	signal next_state, present_state : state;
	signal r_next_count, r_present_count : unsigned(9 downto 0) := (others => '0');
	signal r_count_target : unsigned(9 downto 0) := (others => '0');

begin

	process(i_clk, i_rst) begin
		if i_rst='1' then 
			present_state <= s_sleep;
		elsif rising_edge(i_clk) then
			present_state <= next_state;		
		end if;
	end process;

	process(i_clk, present_state) begin
		if rising_edge(i_clk) then
			r_present_count <= r_next_count;
		end if;
	end process;

	process(i_clk, present_state, i_start, i_rst) begin
		if i_rst = '1' then
			r_count_target <= (others => '0');
		elsif present_state = s_sleep then
			if rising_edge(i_start) then
				r_count_target <= unsigned(i_rng);
			end if;
		end if;
	end process;

	process(present_state, i_clk, r_present_count, i_start, r_count_target) begin
		case present_state is
			when s_sleep =>
				o_running <= '0';
				if i_start = '1' then
					next_state <= s_counting;
				else
					next_state <= s_sleep;
				end if;
			when s_counting =>
				o_running <= '1';
				if r_present_count = r_count_target then
					next_state <= s_sleep;
				else
					next_state <= s_counting;
				end if;
		end case;		
	end process;

	o_en <= '1' when (r_present_count = r_count_target and present_state = s_counting) else '0';
	r_next_count <= (r_present_count + 1) when next_state = s_counting else (others => '0');

end Behavioral;

