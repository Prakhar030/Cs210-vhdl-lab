--Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

--A 4X1 multiplexor outputs the bit value as signified by the selectbit into y bit.
entity Mux4X1 is 
	port(a,b,c,d: in std_logic_vector(7 downto 0);
    	s:in std_logic_vector(1 downto 0);
        y:out std_logic_vector(7 downto 0));
end Mux4X1;


architecture Behav1 of Mux4X1 is
begin
  y<=	a when (s="00") else
    	b when (s="01") else
      	c when (s="10") else
        d;
  
end Behav1;




architecture Behav2 of Mux4X1 is
begin
	with s select 
  	y<=		a when "00",
    		b when "01",
      		c when "10",
        	d when others;
  
end Behav2;


-- Code your testbench here
--or browse Examples
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- The testbench for the Ripple_adder:
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
	component Mux4X1 
		port(a,b,c,d:in std_logic_vector(7 downto 0);
		s:in std_logic_vector(1 downto 0);
		
        y:out std_logic_vector(7 downto 0));
	end component;
    

	signal A,B,C,D: std_logic_vector(7 downto 0):="00000000";
	signal S:std_logic_vector(1 downto 0):="00";
    
    signal Y: std_logic_vector(7 downto 0):="00000000";
begin
	
	Mux1: entity work.Mux4X1(Behav1) port map(A, B, C, D, S,Y);
    Mux2: entity work.Mux4X1(Behav2) port map(A, B, C, D, S,Y);
    
	-- Assign values to input signals.
    A<=std_logic_vector(unsigned(A)+1) after 1 ns;
    B<=std_logic_vector(unsigned(B)+1) after 2 ns;
	C<=std_logic_vector(unsigned(C)+1) after 3 ns;
    D<=std_logic_vector(unsigned(D)+1) after 4 ns;
    S <= std_logic_vector(unsigned(S)+1) after 5 ns;
    --To calculate all possible Input combinations :-
    -- when s=(0,0) ===> 2^8 possible configerations of A are possible
    --So increase A uptill the value changes to 8.
    --tOTAL NUMBER OF INPUTS=2^(8+2)=2^10=1024
    --SO CLEARLY ITS NOT FEASIBLE TO REPRESENT ALL THE OUTPUT FOR A PARTICULAR SELECTION
    --BUT WHAT I HAVE DONE IS CHANGED THE TIMEPERIOD OF ALL THE WAVE FORM SO THAT WE CAN CLEARLY SEE THAT WHEN THE VALUE OF SELECTOR CHANGES THE VALUE OF Y ALSO CHANGES FROM ONE INPUT TO ANOTHER.
	
end Behav;
--ONE VERY IMPORTANT NOTE WHEN YOU RUN THIS CODE IN EDA PLATFORM TO CHECK THE OUTPUT SIGNALS FROM THE RESPECTIVE ARCHITECTURES PLEASE CHOOSE THE Y SIGNAL FROM Mux1 AND Mux2 FOR COMPARISON.
