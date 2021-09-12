--8-Bit Accumulator
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity accumulator is
  port(
    clk:      in std_logic;
    reset:    in std_logic;
    data_in:  in std_logic_vector(7 downto 0);
    data_out: out std_logic_vector(7 downto 0)
  );
end accumulator;

architecture structure_view of accumulator is
  component adder8bit
    port(
      in1: in std_logic_vector(7 downto 0);
		in2: in std_logic_vector(7 downto 0);
		ci:  in std_logic;
      sum: out std_logic_vector(7 downto 0);
      co:  out std_logic
    );
  end component;

  component register8bit
    port(
      clk:    in std_logic;
      reset:  in std_logic;
      regin:  in std_logic_vector(7 downto 0);
      regout: out std_logic_vector(7 downto 0)
      );
  end component;

  signal Cin,Cout: std_logic:='0';
  signal temp1,temp2: std_logic_vector(7 downto 0);

begin
  BA0:  adder8bit    port map (data_in,temp2,Cin,temp1,Cout);
  NG1:  register8bit port map (clk,reset,temp1,temp2);
  data_out <= temp2;
  
end structure_view;