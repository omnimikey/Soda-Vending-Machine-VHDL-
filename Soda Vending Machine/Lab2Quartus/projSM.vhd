library ieee;
use ieee.std_logic_1164.all ;
entity vendMachine is
  port(
    clk,reset,c,choice: in std_logic;
    V: in  std_logic_vector(7 downto 0); --value of input coin
	 E: out std_logic_vector(7 downto 0); --amount of change
    D: out std_logic_vector(1 downto 0)  --type of drink output or no drink output
  );
end vendMachine;

architecture stateMachine of vendMachine is 
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
      in1: in  std_logic_vector(7 downto 0);
		in2: in  std_logic_vector(7 downto 0);
		ci:  in  std_logic;
      sum: out std_logic_vector(7 downto 0);
      co:  out std_logic
    );
  end component;
  
  component bit8_comp
    port(
      A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		AgtB,AltB,AeqB: out std_logic
    );
  end component;

  type statetype is (S0,S1);
  --signal --> temporary variables
  signal state,next_state: statetype;
  signal tempInP,tempInP,Cx,negativeCx,adderOut: std_logic_vector(7 downto 0);
  signal logic0: std_logic:='0';
  signal cE,PgtC,PltC,PeqC,state1v,state3v,PgtC,PltC,PeqC: std_logic;

begin 
state_comb: process (state,input,state1,state3) begin
  case state is
    when S0 => --initialization state
	   state1v <= '0';
		state3v <= '0';
	   if c = '1' then --first coin input
		  next_state <= S1;
		  P := V;
		  tempOutP <= V;
		else
		  next_state <= S0;
		  P := "00000000";
		  tempOutP <= "00000000";
		end if;
	
    when S1 => --waiting state
	   state1v <= '1';
		state3v <= '0';
	   if c = '1' then 
		  next_state <= S2;
		  --accumulator saves value of P while reset is high
		  tempInP <= tempOutP;
		else
		  next_state <=S1;
		end if;
		
    when S2 => --comparison state
	   state1v <= '0';
		state3v <= '0';
	   if PltC = '1' then
		--P is less than Cx, need to input more money
		  next_state <= S1;
		else
		--enough money, go to dispensing state
		  next_state <= S3;
		end if;
		
    when S3 =>	--dispensing state
	   state1v <= '0';
		state3v <= '1';
	   if choice = '1' then
		  D <= "10"; --output drink 1
		  if PeqC = '1' then --input P was perfect, no need to output change
		    cE <= '0';
		  else --need to output change
		    cE <= '1';
		  end if;
		  next_state <= S0;
		else
		  D <= "01"; --output drink 0
		  if PeqC = '1' then --input P was perfect, no need to output change
		    cE <= '0';
		  else --need to output change
		    cE <= '1';
		  end if;
		  next_state <= S0;
		end if;
  end case;


--S0 - initialization -no port map necessary
if state1v = '1' then  --S1 - waiting state
  state1: process
  begin  --accumulator will save value of P while reset is high
	  AC0: accumulator port map (clk,reset,tempInP,tempOutP);
	  BA0: adder8bit port map (V,tempOutP,logic0,adderOut,logic0);
	  P <= adderOut;
	  tempInP <= adderOut;
	  --prep for comparison state
	  if choice = '0' then
	    Cx <= "00001111"; --drink 0 is 15 cents
	  else
	    Cx <= "00010100"; --drink 1 is 20 cents
	  end if;
	  --Cx is the cost of the choice (C0 or C1)
	  CO0: bit8_comp port map (tempInP,Cx,PgtC,PltC,PeqC);
  end process state1;
--elsif state <= 'S2' then --no port map necessary
elsif state3v = '1' then --dispensing state
  if cE = '1' then
    state3: process
    begin  --subtract total money input by cost of choice
      negativeCx <= std_logic_vector(unsigned(not(Cx)) + 1);
      BA1: adder8bit port map (adderOut,negativeCx,logic0,E,logic0);
    end process state3;
  else
    E <= "00000000";
  end if;
end if;
end process state_comb;


  state_clocked: process
  begin
    wait until (clk'event and clk='1');
		if reset='1' then
		state <= S0;
		else
      state <= next_state;
    end if;
  end process state_clocked;
end stateMachine; 	
		
		