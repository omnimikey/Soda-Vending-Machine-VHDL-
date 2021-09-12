library  IEEE; 
use  IEEE.std_logic_1164.all; 
entity not_gate is 
  port(I: in bit; 
       O: out bit); 
end not_gate; 
architecture behavioral of not_gate is 
begin 
  O <= not(I) after 10 ns; 
end behavioral;

library IEEE; 
use IEEE.std_logic_1164.all;
entity and_gate is 
  port(I1,I2: in bit;
       O: out bit); 
end  and_gate; 
architecture behavioral of and_gate is
begin
  O <= (I1 and I2) after 10 ns; 
end behavioral;

library  IEEE; 
use IEEE.std_logic_1164.all; 
entity or_gate is 
  port(I1,I2: in bit; 
       O: out bit); 
end or_gate; 
architecture behavioral of or_gate is 
begin 
  O <= (I1 or I2) after 10 ns; 
end behavioral;

library  IEEE; 
use IEEE.std_logic_1164.all; 
entity nor_gate is 
  port(I1,I2: in bit; 
       O: out bit); 
end nor_gate; 
architecture behavioral of nor_gate is 
begin 
  O <= (I1 nor I2) after 10 ns; 
end behavioral;

library IEEE; 
use IEEE.std_logic_1164.all; 
entity exor_gate is 
  port(I1,I2: in bit; 
       O: out bit); 
end exor_gate; 
architecture behavioral of exor_gate is 
begin 
  O <= (I1 xor I2) after 10 ns;
end behavioral;

library IEEE; 
use IEEE.std_logic_1164.all; 
entity nand_gate is 
  port(I1,I2: in bit; 
       O: out bit); 
end nand_gate; 
architecture behavioral of nand_gate is 
begin 
  O <= (I1 nand I2) after 10 ns;
end behavioral;

library IEEE; 
use IEEE.std_logic_1164.all; 
entity nand4_gate is 
  port(I1,I2,I3,I4: in bit; 
       O: out bit); 
end nand4_gate; 
architecture behavioral of nand4_gate is 
begin 
  O <= not(I1 and I2 and I3 and I4) after 10 ns;
end behavioral;

library IEEE; 
use IEEE.std_logic_1164.all; 
entity mux8 is 
  port(sel: in std_logic;
       A,B: in std_logic_vector(7 downto 0); 
       C:   out std_logic_vector(7 downto 0)); 
end mux8; 
architecture behavioral of mux8 is 
begin 
  C <= A when (sel = '1') else B;
end behavioral;

library IEEE; 
use IEEE.std_logic_1164.all; 
entity mux2 is 
  port(sel: in std_logic;
       A,B: in std_logic_vector(1 downto 0); 
       C:   out std_logic_vector(1 downto 0)); 
end mux2; 
architecture behavioral of mux2 is 
begin 
  C <= A when (sel = '1') else B;
end behavioral;