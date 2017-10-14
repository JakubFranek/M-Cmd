----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
    Port ( i_KB_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           o_ANODE : out  STD_LOGIC_VECTOR (3 downto 0);
           o_LEDS : out  STD_LOGIC_VECTOR (6 downto 0);
			  i_ENABLE : in STD_LOGIC
			  );
end Decoder;

architecture Behavioral of Decoder is

begin
	with i_KB_IN select 
	o_LEDS <= 	"0000001" when x"45",	--0
					"1001111" when x"16",	--1
					"0010010" when x"1E",	--2
					"0000110" when x"26",	--3
					"1001100" when x"25",	--4
					"0100100" when x"2E",	--5
					"0100000" when x"36",	--6	
					"0001111" when x"3D",	--7
					"0000000" when x"3E",	--8
					"0000100" when x"46",	--9
					"0001000" when x"1C", 	--A
					"1100000" when x"32",	--B
					"0110001" when x"21",	--C
					"1000010" when x"23",	--D
					"0110000" when x"24",	--E
					"0111000" when x"2B",	--F
					"1111111" when others;	--nic
					
	o_ANODE <= 	"1110" when (i_ENABLE='1') else
					"1111";					

end Behavioral;

