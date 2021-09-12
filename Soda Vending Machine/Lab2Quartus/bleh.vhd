--vendingMachineProcessor
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vmProcessor is
  port(
    clk,reset,c,choice: in std_logic;
    V:  in std_logic_vector(7 downto 0);
	 P: out std_logic_vector(7 downto 0);
	 E: out std_logic_vector(7 downto 0);
    D: out std_logic_vector(2 downto 0)
  );
end vmProcessor;

architecture structure_view of vmProcessor is
  component accumulator
    port(
      clk:      in std_logic;
      reset:    in std_logic;
      data_in:  in std_logic_vector(7 downto 0);
      data_out: out std_logic_vector(7 downto 0)
    );
  end component;

  component adder8bit
    port(
      in1: in std_logic_vector(7 downto 0);
		in2: in std_logic_vector(7 downto 0);
		ci:  in std_logic;
      sum: out std_logic_vector(7 downto 0);
      co:  out std_logic
    );
  end component;

  component comparator
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
  --state one
  BA0: coinSensor port map (c,V);
  MU0: choiceSensor port map (choice,C0,C1,Cx);
  
  --state two
  AC0: accumulator port map (clk,reset,P0,P1);
  NG0: adder8bit port map (V,accumulatorResult,P);
  data_out <= temp2;
  
end structure_view;