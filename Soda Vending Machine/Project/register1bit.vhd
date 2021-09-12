--synchronous 8-bit register
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register1bit is
  port(
    clk:    in std_logic;
    reset:  in std_logic;
    regin:  in std_logic;
    regout: out std_logic
  );
end register1bit;

architecture register1bit of register1bit is
begin
  process
  constant zero: std_logic:='0';
  begin
  --synchronous reset
    wait until (rising_edge(clk));
	 
	 if reset = '0' then
	   regout <= zero;
    elsif reset = '1' then
	   regout <= regin;
	 elsif reset = 'X' or clk = 'X' then
	   regout <= (others => 'X');
	 end if;
  end process;
end register1bit;