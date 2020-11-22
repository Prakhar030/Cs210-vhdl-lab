--We start by making entities used in adder-subtractor module :- 
--1. Full adder,
--2. N bit ripple adder,
--3. 2 X 1 multiplexor(multi-bit),
--4. ov calculator,
--5. some useful gates(not gate , bitwise not gate, mulitinput and gate, mulitinput or gate,
--I used all these to make adder-subtractor module. 




library IEEE;
use IEEE.std_logic_1164.all;

--A Full_adder adds 3 bits (a,b,c_in) to produce a sum (s) and a carry (c_out).

entity Full_adder is 
	port(
    a,b	: in std_logic;
    c_in: in std_logic;
	s	: out std_logic;
	c_out: out std_logic);
end Full_adder;


architecture Behav of Full_adder is
begin
    s<= (a xor b) xor c_in;
    c_out<=(a and b) or (c_in and b) or (a and c_in);
end Behav;

-----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- A Ripple_adder uses N Full_adder instances connected 
-- together by signals to add two N bit input vectors a and b along with a carry in
--and generates a N bit sum (s) and a carry out (c_out)
entity N_bit_Ripple_adder is 
	generic(N:integer:=4);
	port(
      	a,b	:in std_logic_vector(N-1 downto 0);
		c_in:in std_logic;
      	s	:out std_logic_vector(N-1 downto 0);
		c_out:out std_logic);
end N_bit_Ripple_adder;

architecture Struct of N_bit_Ripple_adder is
									--declare the Full adder component here.
	component Full_adder
    port(
    a,b	: in std_logic;
    c_in: in std_logic;
	s	: out std_logic;
	c_out: out std_logic);
	end component;
    
									--the following signal will be useful for connecting 
									--together the full adders.
signal carry: std_logic_vector(N-1 downto 0);
begin
									--loop start
	LOOPING : for i in N-1 downto 0 generate
      
      O_bit:if i =0 generate		--for bit one cin is different than others.
        FA0: Full_adder port map (a(i),b(i),c_in,	s(i),carry(0));
      end generate O_bit;
      rest_bits:if i>0 generate		--general case
        FAi: Full_adder port map (a(i),b(i),carry(i-1),	s(i),carry(i));
   	  end generate rest_bits;
      last_bit:if i=N-1 generate	--end case cout is different
        FAlast: Full_adder port map (a(i),b(i),carry(i-1),	s(i),c_out);
   	  end generate last_bit;
    end generate LOOPING;
end Struct;
----------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

--A 2X1 multiplexor outputs the bit value as signified by the selectbit into y bit.
entity Mux2X1 is 
	generic(N:integer:=8);
	port(a,b: in std_logic_vector(N-1 downto 0);
    	s:in std_logic;
        y:out std_logic_vector(N-1 downto 0));
end Mux2X1;


architecture Behav1 of Mux2X1 is
begin
  y<=	a when (s='0') else
    	b;
  
end Behav1;
-----------------------------------------------------------------
--CODE FOR 1 BIT NOT GATE
library IEEE;
use IEEE.std_logic_1164.all;

entity Not1 is 
	
	port(a: in std_logic;y:out std_logic);
end Not1;

architecture behave3 of Not1 is
begin
  y<=	not a;
  
end behave3;

-----------------------------------------------------------------

--CODE FOR N BIT NOT GATE
library IEEE;
use IEEE.std_logic_1164.all;

entity bitwise_Not1 is 
	generic(N:integer:=8);
	port(a: in std_logic_vector(N-1 downto 0);y:out std_logic_vector(N-1 downto 0));
end bitwise_Not1;

architecture behave4 of bitwise_Not1 is
	component Not1 is 
		port(a: in std_logic;y:out std_logic);
	end component;

begin
  not_arr:for i in N-1 downto 0 generate
  	not_i: Not1 port map(a(i),y(i));
  end generate not_arr;
end behave4;

-------------------------------------------------------------
--CODE FOR 4 BIT AND GATE

library IEEE;
use IEEE.std_logic_1164.all;

entity and4_gate is 
	
	port(a,b,c,d: in std_logic;y:out std_logic);
end and4_gate;

architecture behave6 of and4_gate is
begin
  y<=a and b and c and d;
end behave6;

---------------------------------------------------------------
--CODE FOR 4 BIT OR GATE

library IEEE;
use IEEE.std_logic_1164.all;

entity or4_gate is 
	
	port(a,b,c,d: in std_logic;y:out std_logic);
end or4_gate;

architecture behave7 of or4_gate is
begin
  y<=a or b or c or d;
end behave7;

------------------------------------------------------------
--CODE FOR CALCULATING OVERFLOW
library IEEE;
use IEEE.std_logic_1164.all;

entity ov_calculator is 
	
	port(a,b,c,d: in std_logic;ov:out std_logic);
end ov_calculator;

architecture behave8 of ov_calculator is
	    
    component and4_gate is 	
	port(a,b,c,d: in std_logic;y:out std_logic);
	end component;

    component or4_gate is	
	port(a,b,c,d: in std_logic;y:out std_logic);
	end component;
 	
	component Not1 is 
		port(a: in std_logic;y:out std_logic);
	end component;
signal not_a,not_b,not_c,not_d,K,L,M,N : std_logic:='0';
begin
  A0:Not1  port map(a,not_a);
  A1:Not1  port map(b,not_b);
  A2:Not1  port map(c,not_c);
  A3:Not1  port map(d,not_d);
  B0:and4_gate port map(not_a,not_b,not_c,d,K);
  B1:and4_gate port map(not_a,b,c,not_d,L);
  B2:and4_gate port map(a,b,not_c,d,M);
  B3:and4_gate port map(a,not_b,c,d,N);
  Out_1:or4_gate port map(K,L,M,N,ov);
end behave8;




-------------------------------------------------------------
--CODE FOR FINAL ADDER AND SUBTRACTOR MODULE
library IEEE;
use IEEE.std_logic_1164.all;

entity AandS_module is 
	generic(M:integer:=8);
	port(
    A: in std_logic_vector(M-1 downto 0);
    B: in std_logic_vector(M-1 downto 0);
    OP_select:in std_logic;
    OV:out std_logic;
    Y:out std_logic_vector(M-1 downto 0);
    c_out:out std_logic);
end AandS_module;

architecture behave5 of AandS_module is
	
	
    component bitwise_Not1 is 
	generic(N:integer:=8);
	port(a: in std_logic_vector(N-1 downto 0);y:out std_logic_vector(N-1 downto 0));
	end component;
    
    component Mux2X1 is 
	generic(N:integer:=8);
	port(a,b: in std_logic_vector(N-1 downto 0);
    	s:in std_logic;
        y:out std_logic_vector(N-1 downto 0));
	end component;
   
   	component ov_calculator is 	
	port(a,b,c,d: in std_logic;ov:out std_logic);
	end component;
    
    component N_bit_Ripple_adder is 
	generic(N:integer:=4);
	port(
      	a,b	:in std_logic_vector(N-1 downto 0);
		c_in:in std_logic;
      	s	:out std_logic_vector(N-1 downto 0);
		c_out:out std_logic);
	end component;

signal Bnotbitwise: std_logic_vector(M-1 downto 0);
signal U: std_logic_vector(M-1 downto 0);
signal V: std_logic_vector(0 downto 0);
signal H0: std_logic_vector(0 downto 0):="0";
signal H1: std_logic_vector(0 downto 0):="1";
begin
	
	C1:bitwise_Not1 generic map(N=>M) port map(B,Bnotbitwise);
	C2:Mux2X1 generic map(N=>M) port map(B,Bnotbitwise,OP_select,U);
    C3:Mux2X1 generic map(N=>1) port map(H0,H1,OP_select,V);
    
  	output:N_bit_Ripple_adder generic map(N=>M) port map(A,U,V(0),Y,c_out);
  
  	out_2:ov_calculator port map(OP_select,A(M-1),B(M-1),Y(M-1),OV);  
end behave5;








----------------------------------------------------------------------











-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--The testbench for the Module:
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
	component AandS_module is 
	generic(M:integer:=8);
	port(
    A: in std_logic_vector(M-1 downto 0);
    B: in std_logic_vector(M-1 downto 0);
    OP_select:in std_logic;
    OV:out std_logic;
    Y:out std_logic_vector(M-1 downto 0);
    c_out:out std_logic);
	end component;
    
    
    signal A,B,Y: std_logic_vector(3 downto 0):="0000";
    signal OP_select,OV,c_out: std_logic:='0';
    
begin
	--Instantiate the module
  A_S: AandS_module generic map(M=>4) port map(A, B, OP_select,OV,Y,c_out);
    
	--Assign values to input signals.
	A <= std_logic_vector(unsigned(A)+1) after 10 ns;
    B <= std_logic_vector(unsigned(B)+1) after 50 ns;
    OP_select <= not OP_select after 100ns;

end Behav;
