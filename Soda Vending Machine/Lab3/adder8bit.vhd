library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder8bit is 

Port(
in1: in std_logic_vector (7 downto 0);
in2: in std_logic_vector (7 downto 0);
ci: in std_logic;
sum: out std_logic_vector (7 downto 0);
co: out std_logic);

end adder8bit;

architecture structure_view of adder8bit is

component adder1bit
port (A,B,Cin : in std_logic;
 Sum,Cout : out std_logic);
 end component;
 
 signal co0,co1,co2,co3,co4,co5,co6 : std_logic;
 
 begin
 
 FA0: adder1bit port map(in1(0),in2(0),ci,sum(0),co0);
 FA1:	adder1bit port map(in1(1),in2(1),co0,sum(1),co1);
 FA2: adder1bit port map(in1(2),in2(2),co1,sum(2),co2);
 FA3: adder1bit port map(in1(3),in2(3),co2,sum(3),co3);
 FA4: adder1bit port map(in1(4),in2(4),co3,sum(4),co4);
 FA5: adder1bit port map(in1(5),in2(5),co4,sum(5),co5);
 FA6: adder1bit port map(in1(6),in2(6),co5,sum(6),co6);
 FA7: adder1bit port map(in1(7),in2(7),co6,sum(7),co);
 
 end structure_view;