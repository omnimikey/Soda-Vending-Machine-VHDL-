--Full Adder (structural view 2)

entity FULL_ADDER is
  port (A,B,Cin: in bit;
    	  Sum,Cout: out bit);
end FULL_ADDER;

architecture structure_view of FULL_ADDER is
  component half_adder
    port(A,B: in bit;
          Sum,Carry: out bit);
  end component;

  component or_gate
    port(I1,I2: in bit; O: out bit);
  end component;

  signal Y0,Z0,Z1: bit;

begin
  HA0: half_adder port map (A,B,Y0,Z0);
  HA1: half_adder port map (Cin,Y0,Sum,Z1);
  OG:  or_gate    port map (Z0,Z1,Cout);
end structure_view;