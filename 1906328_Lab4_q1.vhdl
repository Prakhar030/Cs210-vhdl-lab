-- Code your design here
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
	--Fill in the appropriate architecture 
    s<= (a xor b) xor c_in;
    c_out<=(a and b) or (c_in and b) or (a and c_in);
end Behav;



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



-------------------------------------------------------------------------------------
-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--The testbench for the N_bit_Ripple_adder:
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
	component N_bit_Ripple_adder 
		generic(N:integer);
		port(
          	a,b	:in std_logic_vector(N-1 downto 0);
			c_in:in std_logic;
          	s	:out std_logic_vector(N-1 downto 0);
			c_out:out std_logic);
	end component;
	signal A,B,S: std_logic_vector(4 downto 0):="00000";
	signal C_IN,C_OUT: std_logic:='0';
begin
	--Instantiate the Ripple_adder
  RA: N_bit_Ripple_adder generic map(N=>5) port map(A, B, C_IN, S, C_OUT);
    
	--Assign values to input signals.
	A <= std_logic_vector(unsigned(A)+1) after 10 ns;
    B <= std_logic_vector(unsigned(B)+1) after 160 ns;
    C_IN <= '0';

end Behav;

--FOR CHECKING WHAT I DID WAS FIRST I TOOK N=4 AND 4 BIT SIGNALS ABC THEN I MATCHED IT WITH OUTPUTS OF LAB-2.
