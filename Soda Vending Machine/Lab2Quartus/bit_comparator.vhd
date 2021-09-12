--1-Bit Comparator

entity bit_comp is
  port (Ai,Bi,Cip1,Dip1: in bit;
    	  Ci,Di: out bit);
end bit_comp;

architecture structure_view of bit_comp is
  component nand_gate
    port(I1,I2: in bit;
          O: out bit);
  end component;

  component nand4_gate
    port(I1,I2,I3,I4: in bit; 
	      O: out bit);
  end component;
  
  component not_gate
    port(I: in bit; 
	      O: out bit);
  end component;

  signal nAi,nBi,nCip1,nDip1,x,y: bit;

begin
  NG0:  not_gate   port map (Ai,nAi);
  NG1:  not_gate   port map (Bi,nBi);
  NG2:  not_gate   port map (Cip1,nCip1);
  NG3:  not_gate   port map (Dip1,nDip1);
  NA40: nand4_gate port map (Ai,nBi,nCip1,nDip1,x);
  NA41: nand4_gate port map (nAi,Bi,nCip1,nDip1,y);
  NA0:  nand_gate  port map (x,nCip1,Ci);
  NA1:  nand_gate  port map (y,nDip1,Di);
  
end structure_view;