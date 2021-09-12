library IEEE;
use IEEE.std_logic_1164.all;


entity part1 is
	port (CLK,RESET,INPUT : in bit;
			OUTPUT : out bit);
end part1;

architecture behaviour of part1 is
	TYPE STATE_TYPE IS (s0,s1,s2,s3);
	SIGNAL state : STATE_TYPE;
	
begin
	process(CLK,RESET)
	variable init : bit := '0';
	begin
		if init = '0' then
			state <= s0;
			init := '1';
		elsif RESET ='1' then
			state <= s0;
		elsif CLK'event and CLK='1' then
			case state is
				when s0 =>
					if INPUT = '1' then
						OUTPUT <= '0';
						state <= s0;
					else
						OUTPUT <= '0';
						state <= s1;
					end if;
					
				when s1 => 
					if INPUT = '1' then
						OUTPUT <= '0';
						state <= s2;
					else
						OUTPUT <= '0';
						state <= s1;
					end if;
			
				when s2 => 
					if INPUT = '1' then
						OUTPUT <= '0';
						state <= s0;
					else
						OUTPUT <= '0';
						state <= s3;
				end if;
			
				when s3 =>
					if INPUT = '1' then
						OUTPUT <= '1';
						state <= s2;
					else
						OUTPUT <= '0';
						state <= s1;
					end if;
				end case;
			end if;
	end process;
		
end behaviour;