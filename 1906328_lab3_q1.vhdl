-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

-- A 4X1 multiplexor output the bit value as signified by the selectbit into y bit.
entity Mux4X1 is 
	port(a,b,c,d: in std_logic;
    	s:in std_logic_vector(1 downto 0);
        y:out std_logic);
end Mux4X1;

--architecture in terms of and ,not ,or gates.
architecture Behav of Mux4X1 is
begin
	y<= (a and (not s(0)) and (not s(1))) or (c and (not s(0)) and  s(1)) or (b and  s(0) and (not s(1)))  or (d and  s(0) and s(1)); 
end Behav;

-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- The testbench for the multiplexor:
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
	component Mux4X1 
		port(a,b,c,d:in std_logic;
		s:in std_logic_vector(1 downto 0);
		y:out std_logic);
	end component;
	signal A,B,C,D: std_logic:='0';
	signal S:std_logic_vector(1 downto 0):="00";
    signal Y: std_logic:='0';
begin
	-- Instantiate the Multiplexor
	Mux: Mux4X1 port map(A, B, C, D, S, Y);
	-- Assign values to input signals.
    A<=not A after 4 ns;
    B<=not B after 9 ns;
	C<=not C after 17 ns;
    D<=not D after 12 ns;
    S <= std_logic_vector(unsigned(S)+1) after 10 ns;
	

end Behav;

