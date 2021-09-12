library ieee;
use ieee.std_logic_1164.all ;
entity vendMachine is
  port(
    clk,reset,c,choice: in std_logic;
    V: in  std_logic_vector(7 downto 0); --value of input coin
	 P: out std_logic_vector(7 downto 0); --money accumulated
	 E,drinkCost: out std_logic_vector(7 downto 0); --E = amount of change
    D: out std_logic_vector(1 downto 0); --type of drink output (01/10) or no drink output (00/11)
	 state0,state1,state2,PgreaterThanC,PlessThanC,PequalToC: out std_logic --for debugging
  );
end vendMachine;

architecture stateMachine of vendMachine is 
  
  component adder8bit
    port(
      in1: in  std_logic_vector(7 downto 0);
		in2: in  std_logic_vector(7 downto 0);
		ci:  in  std_logic;
      sum: out std_logic_vector(7 downto 0);
      co:  out std_logic
    );
  end component;
  
  component bit8_comp
	port(
	  Acu: in std_logic_vector (7 downto 0);		-- The cost of drinks
	  S: in std_logic_vector (7 downto 0);      -- Output total amount of coins from Accumulator
	  Cip1,Dip1: in std_logic;						-- initial C/D input (= logic 0)
	  Sgt,Slt,Seq: out std_logic                -- S greater than, S less than, S equal to
	);

  end component;
  
  component register8bit is
  port(
    clk:    in std_logic;
    reset:  in std_logic;
    regin:  in std_logic_vector(7 downto 0);
    regout: out std_logic_vector(7 downto 0)
  );
  end component;
  
  component register2bit is
  port(
    clk:    in std_logic;
    reset:  in std_logic;
    regin:  in std_logic_vector(1 downto 0);
    regout: out std_logic_vector(1 downto 0)
  );
  end component;
  
  component mux8 is 
  port(sel: in std_logic;
       A,B: in std_logic_vector(7 downto 0); 
       C:   out std_logic_vector(7 downto 0)); 
  end component;
  
  component mux2 is 
  port(sel: in std_logic;
       A,B: in std_logic_vector(1 downto 0); 
       C:   out std_logic_vector(1 downto 0)); 
  end component; 
  
  type statetype is (S0,S1,S2);
  --signal --> temporary variables
  signal state: statetype;
  signal tempP0,tempP1,tempE,Cx,notCx,adderOut,compCx: std_logic_vector(7 downto 0);
  signal Dx,tempD: std_logic_vector(1 downto 0);
  signal logic0: std_logic:='0';
  signal temp1: std_logic_vector(7 downto 0):="00000001";
  signal C0: std_logic_vector(7 downto 0):="00001111"; --cost of drink 0: 15 cents
  signal C1: std_logic_vector(7 downto 0):="00010100"; --cost of drink 1: 20 cents
  signal D0: std_logic_vector(1 downto 0):="01";
  signal D1: std_logic_vector(1 downto 0):="10";
  signal PgtC,PltC,PeqC,tempC,enS2,enP: std_logic;

    begin
     MU0: mux8          port map (choice,C1,C0,Cx);
	  MU1: mux2          port map (choice,D1,D0,Dx);

	  RE0:  register8bit port map (not(clk),'1',tempP0,tempP1); --state 1; wait and compare state
	  BA0:  adder8bit    port map (V,tempP1,logic0,adderOut,tempC);
	  RE1:  register8bit port map (clk,enP,adderOut,P);
	  RE2:  register8bit port map (clk,enP,adderOut,tempP0);
	  
	  CO0:  bit8_comp    port map (Cx,tempP0,logic0,logic0,PgtC,PltC,PeqC);
	  PgreaterThanC <= PgtC; --for debugging
	  PlessThanC <= PltC;    --for debugging
	  PequalToC <= PeqC;     --for debugging
	  drinkCost <= Cx;       --for debugging

	  notCx <= not(Cx); --state 2; dispensing state
	  BA1:  adder8bit    port map (notCx,temp1,logic0,compCx,tempC);
	  BA2:  adder8bit    port map (compCx,tempP0,logic0,tempE,tempC);
	  RE3:  register8bit port map (clk,enS2,tempE,E);
	  RE4:  register2bit port map (clk,enS2,Dx,D);
	  RE5:  register2bit port map (clk,enS2,Dx,tempD);

	 
	 process(clk)
	 begin
	   if(clk'event and clk='1')then
		  case state is
		    when S0=>
			   if reset = '1' then
				  state <= S0;
			   elsif c = '1' then
				  state <= S1;
				else
				  state <= S0;
				end if;
			 when S1=>
			   if reset = '1' then
				  state <= S0;
			   elsif PgtC = '1' then
				  state <= S2;
				elsif PeqC = '1' then
				  state <= S2;
				else
				  state <= S1;
				end if;
			 when S2=>
			   if reset = '1' then
				  state <= S0;
			   elsif tempD = "10" then
				  state <= S0;
				elsif tempD = "01" then
				  state <= S0;
				else 
				  state <= S2;
				end if;
		  end case;
		end if;
	 end process;
	 process (state)
	 begin
	   case state is
		  when S0=> enS2 <= '0'; enP <= '0'; state1 <= '0'; state2 <= '0';
		            state0 <= '1';
		  when S1=> enS2 <= '0'; state0 <= '0'; state2 <= '0';
		            enP <= '1'; state1 <= '1';
		  when S2=> state0 <= '0'; state1 <= '0';
		            enS2 <= '1'; enP <= '1'; state2 <= '1';

		end case;
	 end process;
end stateMachine;
