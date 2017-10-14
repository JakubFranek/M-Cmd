----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity KB_CODE is
	 Port ( i_CLK : in  STD_LOGIC;
			  i_RECEIVED : in STD_LOGIC;
			  i_DATA_IN : in STD_LOGIC_VECTOR(7 downto 0);
			  o_ENABLE : out STD_LOGIC;
			  o_KB_CODE : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end KB_CODE;
--------------------------------------------	
architecture Behavioral of KB_CODE is
--------------------------------------------	
	type states is (s_GET_CODE, s_WAIT_BRK, s_BRK);
	signal s_present, s_next : states := s_GET_CODE;													--inicializace
	signal w_NEXT_CODE, r_PRESENT_CODE : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');		--8b data pamet
--------------------------------------------	
begin
--Registrova cast---------------------------	
	process (i_CLK) 
	begin
		if(rising_edge(i_CLK)) then
			s_present <= s_next;	
			r_PRESENT_CODE <= w_NEXT_CODE;
			o_KB_CODE <= r_PRESENT_CODE;	
		end if;
	end process;	

--Kombinacni cast---------------------------	
	process(s_present, i_RECEIVED, i_DATA_IN, r_PRESENT_CODE)
	begin
		o_ENABLE <= '0';
		case s_present is
			when s_GET_CODE =>
				w_NEXT_CODE <= i_DATA_IN;									--zapamatovani prvni stiskle klavesy
				if(i_RECEIVED = '1') then
					s_next <= s_WAIT_BRK;
				else
					s_next <= s_GET_CODE;
				end if;
				
			when s_WAIT_BRK =>
				o_ENABLE <= '1';
				w_NEXT_CODE <= r_PRESENT_CODE;
				if(i_RECEIVED = '1' AND i_DATA_IN = x"F0") then	--break code F0
					s_next <= s_BRK;
				else
					s_next <= s_WAIT_BRK;
				end if;				
			
			when s_BRK =>														--pustili jsme skutecne tuto klavesu? (nasleduje po F0 kod zapamatovane klavesy?)
				w_NEXT_CODE <= r_PRESENT_CODE;
				if((i_RECEIVED = '1') AND (i_DATA_IN = r_PRESENT_CODE)) then			--pustili jsme zapamatovanou klavesu	
					s_next <= s_GET_CODE;
				elsif((i_RECEIVED = '1') AND NOT (i_DATA_IN = r_PRESENT_CODE)) then	--pustili jsme jinou klavesu
					s_next <= s_WAIT_BRK;
				else
					s_next <= s_BRK;
				end if;	

		end case;
	end process;
--------------------------------------------	
end Behavioral;
----------------------------------------------------------------

