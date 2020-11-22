-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- A 3-to-8 Line Decoder output the bit value as signified by the selectbit into y bit.
entity LD3to8 is 
	port(x:in std_logic_vector(2 downto 0);
    	e:in std_logic;
        d:out std_logic_vector(7 downto 0));
end LD3to8;

--architecture in terms of and ,not ,or gates.
architecture Behav1 of LD3to8 is
begin
	d(0) <= (not x(2)) and (not x(1)) and (not x(0)) and e;
    d(1) <= (not x(2)) and (not x(1)) and ( x(0)) and e;
    d(2) <= (not x(2)) and ( x(1)) and (not x(0)) and e;
    d(3) <= (not x(2)) and ( x(1)) and ( x(0)) and e;
    d(4) <= ( x(2)) and (not x(1)) and (not x(0)) and e;
    d(5) <= ( x(2)) and (not x(1)) and ( x(0)) and e;
    d(6) <= ( x(2)) and ( x(1)) and (not x(0)) and e;
    d(7) <= ( x(2)) and ( x(1)) and ( x(0)) and e;
end Behav1;
--architecture in terms of when/else statements.
architecture Behav2 of LD3to8 is
begin
	d(0)<=	e when (x="000") else
   			'0';
    d(1)<=	e when (x="001") else
    		'0';
    d(2)<=	e when (x="010") else
    		'0';        
  	d(3)<=	e when (x="011") else
    		'0';
	d(4)<=	e when (x="100") else
    		'0';
	d(5)<=	e when (x="101") else
    		'0';
    d(6)<=	e when (x="110") else
    		'0';
	d(7)<=	e when (x="111") else
    		'0';
end Behav2;

--------------------------------------------------------------------

-- Code your testbench here
--or browse Examples
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- The testbench for the LD3to8:
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
    component LD3to8 is 
	port(x:in std_logic_vector(2 downto 0);
    	e:in std_logic;
        d:out std_logic_vector(7 downto 0));
	end component;

	signal X: std_logic_vector(2 downto 0):="000";
    signal E: std_logic:='1';
    signal D: std_logic_vector(7 downto 0):="00000000";
begin
	
	LD1: entity work.LD3to8(Behav1) port map(X,E,D);
    LD2: entity work.LD3to8(Behav2) port map(X,E,D);
    
	-- Assign values to input signals.
    X<=std_logic_vector(unsigned(X)+1) after 1 ns;
    E<=not E after 8 ns;
	

	
end Behav;
--ONE VERY IMPORTANT NOTE WHEN YOU RUN THIS CODE IN EDA PLATFORM TO CHECK THE OUTPUT SIGNALS FROM THE RESPECTIVE ARCHITECTURES PLEASE CHOOSE THE x,e,d SIGNALS FROM LD1 AND LD2 FOR COMPARISON.

--MY APPROACH 
--WHEN x="000" d ="00000001" representing d0 is outputed,
--WHEN x="001" d ="00000010" representing d1 is outputed,
--WHEN x="010" d ="00000100" representing d2 is outputed,
--WHEN x="011" d ="00001000" representing d3 is outputed,
--WHEN x="100" d ="00010000" representing d4 is outputed,
--WHEN x="101" d ="00100000" representing d5 is outputed,
--WHEN x="110" d ="01000000" representing d6 is outputed,
--WHEN x="111" d ="10000000" representing d7 is outputed,

