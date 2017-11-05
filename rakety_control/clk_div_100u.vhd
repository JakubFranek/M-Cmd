library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_div_10us is
    Port ( 	i_clk : in  STD_LOGIC;
				i_rst : in std_logic;
				o_clk_10us : out  STD_LOGIC);
end clk_div_10us;

architecture Behavioral of clk_div_10us is

	signal cnt1_d_int, r_cnt1_q_reg : unsigned(15 downto 0) := (others => '0');

begin

	--
	process (i_clk) begin
		if rising_edge(i_clk) then
			if i_rst = '1' then				
				r_cnt1_q_reg <= (others => '0');
			else
				r_cnt1_q_reg <= cnt1_d_int;
			end if;
		end if;
	end process;

	process (r_cnt1_q_reg) begin
		cnt1_d_int <= r_cnt1_q_reg + 1;
		o_clk_10us <= '0';
		if r_cnt1_q_reg = 499 then
			cnt1_d_int <= (others => '0');
			o_clk_10us <= '1';
		end if;
	end process;

end Behavioral;


