-- Code for testbench is here
library IEEE;
use IEEE.std_logic_1164.all;
entity Testbench is 

end Testbench;

architecture Arch_t of Testbench is
	component and_gate
	port(a,b: in bit; c: out bit);
	end component;
    component xor_gate
	port(a,b: in bit; s: out bit);
	end component;
    signal w,x,y,z:bit:='0';
    
begin
	A1: and_gate port map(a=>w,b=>x,c=>y);
    A2: xor_gate port map(a=>w,b=>x,s=>z);
    w<=not w after 20ns;
    x<=not x after 10ns;
end Arch_t;


-- Code for design is here
library IEEE;
use IEEE.std_logic_1164.all;
-- and gate design
entity and_gate is
	port(a,b: in bit; c: out bit);
end and_gate;

architecture arch1 of and_gate is 

begin
	c<= a and b;
end arch1;

-- xor gate design
entity xor_gate is
	port(a,b: in bit; s: out bit);
end xor_gate;

architecture arch2 of xor_gate is 

begin
	s<= a xor b;
end arch2;