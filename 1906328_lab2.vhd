-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

-- A Full_adder adds 3 bits (a,b,c_in) to produce a sum (s) and a carry (c_out).
entity Full_adder is 
	port(
    a,b	: in std_logic;
    c_in: in std_logic;
	s	: out std_logic;
	c_out: out std_logic);
end Full_adder;


architecture Behav of Full_adder is
begin
	--- Fill in the appropriate architecture 
    s<= (a xor b) xor c_in;
    c_out<=(a and b) or (c_in and b) or (a and c_in);
end Behav;



library IEEE;
use IEEE.std_logic_1164.all;

-- A Ripple_adder uses four Full_adder instances connected 
-- together by signals to add two four bit input vectors a and b along with a carry in
-- and generates a 4 bit sum (s) and a carry out (c_out)
entity Ripple_adder is 
	port(
	a,b	:in std_logic_vector(3 downto 0);
	c_in:in std_logic;
    s	:out std_logic_vector(3 downto 0);
	c_out:out std_logic);
end Ripple_adder;

architecture Struct of Ripple_adder is
	-- declare the Full adder component here.
	component Full_adder
    port(
    a,b	: in std_logic;
    c_in: in std_logic;
	s	: out std_logic;
	c_out: out std_logic);
	end component;
    
	-- the following signals will be useful for connecting together 
	-- the full adders.
	signal carry: std_logic_vector(3 downto 0):="0000";

begin
	-- as an example, here's the first instance:
	FA0: Full_adder port map (a(0),b(0),c_in,	 s(0),carry(0));
    FA1: Full_adder port map (a(1),b(1),carry(0),	 s(1),carry(1));
	FA2: Full_adder port map (a(2),b(2),carry(1),	 s(2),carry(2));
    FA3: Full_adder port map (a(3),b(3),carry(2),	 s(3),c_out);
	-- connect all other instances and finally generate the carry out.
end Struct;


-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- The testbench for the Ripple_adder:
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
	component Ripple_adder 
		port(
		a,b	:in std_logic_vector(3 downto 0);
		c_in:in std_logic;
		s	:out std_logic_vector(3 downto 0);
		c_out:out std_logic);
	end component;
	signal A,B,S: std_logic_vector(3 downto 0):="0000";
	signal C_IN,C_OUT: std_logic:='0';
begin
	-- Instantiate the Ripple_adder
	RA: Ripple_adder port map(A, B, C_IN, S, C_OUT);
    
	-- Assign values to input signals.
	A <= std_logic_vector(unsigned(A)+1) after 10 ns;
    B <= std_logic_vector(unsigned(B)+1) after 160 ns;
    C_IN <= '0';

end Behav;