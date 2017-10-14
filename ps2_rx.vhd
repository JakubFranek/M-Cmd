----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PS2_RX is
	 Port ( i_PS2_DATA : in  STD_LOGIC;
           i_EDGE_DET : in  STD_LOGIC;
           i_CLK : in  STD_LOGIC;
			  o_RECEIVED : out STD_LOGIC;
			  o_DATA_OUT : out STD_LOGIC_VECTOR(7 downto 0)			  
			  );
end PS2_RX;
--------------------------------------------	
architecture Behavioral of PS2_RX is
--------------------------------------------	
	type states is (s_IDLE, s_DPS, s_LOAD);
	signal s_present, s_next : states := s_IDLE;
	signal present_cnt, next_cnt : integer := 0;							--transfered bits count
	signal REG : STD_LOGIC_VECTOR(9 downto 0) := (others=>'0');		--10b dat (8b data, 1b parity, 1b stop
	signal r_DATA : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');	--pouze 8b dat z vyse uvedeneho REG
	signal r_RECEIVED : STD_LOGIC :='0';
--------------------------------------------	
begin
--Registrova cast---------------------------	
	process (i_CLK) 
	begin
		if(rising_edge(i_CLK)) then
			s_present <= s_next;
			present_cnt <= next_cnt;
			o_DATA_OUT <= r_DATA; 										--prenos pouze 8b dat (lze upravit)	data synchroni s received a platna po jeden main clk
			o_RECEIVED <= r_RECEIVED;
			if(i_EDGE_DET = '1') then
				REG(8 downto 0) <= REG(9 downto 1);
				REG(9) <= i_PS2_data;
			end if;			
		end if;
	end process;
	

--Kombinacni cast---------------------------	
	process(s_present, i_EDGE_DET, i_PS2_DATA, present_cnt, next_cnt, REG)
	begin
		r_RECEIVED <= '0';												--default value
		r_DATA <= (others=>'0');										--default value
		case s_present is
			when s_IDLE =>
				next_cnt <= 0;				
				if(i_EDGE_DET = '1') then
					s_next <= s_DPS;
					next_cnt <= present_cnt+1;							--cnt=1
				else
					s_next <= s_IDLE;
					next_cnt <= 0;
				end if;	
				
			when s_DPS =>
				if(i_EDGE_DET = '1' and present_cnt <= 9) then					
					next_cnt <= present_cnt+1;
					s_next <= s_DPS;					
				elsif(i_EDGE_DET = '1' and present_cnt>9) then				--prijat 10ty bit (11ty stop b. se doclockne v s_LOAD)
					s_next <= s_LOAD;
					next_cnt <= present_cnt;
				else
					s_next <= s_DPS;
					next_cnt <= present_cnt;
				end if;								
			
			when s_LOAD =>
				r_RECEIVED <= '1';											--signalizace ze o_DATA_OUT je platne
				r_DATA <= std_logic_vector(REG(7 downto 0));			--prenos pouze 8b dat (lze upravit)	
				s_next <= s_IDLE;
				next_cnt <= 0;
		end case;
	end process;
--------------------------------------------	
end Behavioral;
----------------------------------------------------------------

