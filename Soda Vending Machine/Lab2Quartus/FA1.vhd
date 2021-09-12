--Full Adder (structural view 1)
library IEEE;
use IEEE.std_logic_1164.all;
entity adder1bit is
  port (A,B,Cin: in bit; --input ports
      	Sum,Cout: out bit); --output  ports
end adder1bit;

library IEEE;
use IEEE.std_logic_1164.all; 
-- Structure view of Full Adder 

architecture structure_view of adder1bit is
  component and_gate
	port(I1,I2: in bit; O: out bit);
  end component;

  component or_gate
  port(I1,I2: in bit; O: out bit);
  end component;

  component exor_gate
	port(I1,I2: in bit; O: out bit);
  end component;

  signal x,y,z: bit;

begin
  G1: exor_gate port  map (A,B,x);
  G2: exor_gate port  map (x,Cin,Sum);
  G3: and_gate  port  map (x,Cin,y);
  G4: and_gate  port  map (A,B,z);
  G5: or_gate   port  map (y,z,Cout);
end structure_view;