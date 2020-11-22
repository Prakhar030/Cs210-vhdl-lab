-- Code FOR LINE DETECTOR here
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



--------------------------------------------------------------------------------------


-- Code FOR LINE DETECTOR here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- A 3-to-8 Line Decoder output the bit value as signified by the selectbit into y bit.
entity combo1 is 
	port(x:in std_logic_vector(2 downto 0);
        f0:out std_logic;
        f1:out std_logic;
        f2:out std_logic;
        f3:out std_logic);
end combo1;

--architecture in terms of and ,not ,or gates.
architecture Behav2 of combo1 is
    component LD3to8 is 
	port(x:in std_logic_vector(2 downto 0);
    	e:in std_logic;
        d:out std_logic_vector(7 downto 0));
	end component;
    
signal d: std_logic_vector(7 downto 0);

begin
	ld: LD3to8 port map (x,'1',d);
    f0 <= '1' when (d="00000001") else
   			'0';
    f1 <= '1' when (d="00000100" or d="00001000" or d="01000000"or d="00010000") else
   			'0';
    f2 <= '1' when (d="01000000"or d="10000000") else
   			'0';
    f3 <= '1' when (d="00000010" or d="00000100" or d="00010000"or d="10000000") else
   			'0';
end Behav2;

------------------------------------------------------------------------------------------

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
	component combo1 is 
	port(x:in std_logic_vector(2 downto 0);
        f0:out std_logic;
        f1:out std_logic;
        f2:out std_logic;
        f3:out std_logic);
	end component;
    
signal X: std_logic_vector(2 downto 0):="000";
signal F0: std_logic:='0';
signal F1: std_logic:='0';
signal F2: std_logic:='0';
signal F3: std_logic:='0';
begin
	
	LD1: combo1 port map(X,F0,F1,F2,F3);
    
    
	-- Assign values to input signals.
    X<=std_logic_vector(unsigned(X)+1) after 1 ns;
    	
end Behav;
-- while execution in EDA 
--Please take into consideration only test bench signals and convert the radix to binary for clarfification.
--MY APPROACH (considering 0 as not an even number)
--WHEN x="000" F0='1' representing f0 is outputed,
--WHEN x="001" F3='1' representing f3 is outputed,
--WHEN x="010" F3='1' AND F1='1' representing f3 and f1 is outputed,
--WHEN x="011" F1='1' representing f1 is outputed,
--WHEN x="100" F3='1' AND F1='1' representing f3 and f1 is outputed,
--WHEN x="101" EVERYTHING IS '0' representing nothing is outputed,
--WHEN x="110" F1='1'AND F2='1' representing f2 and f1 is outputed,
--WHEN x="111" F3='1'AND F2='1' representing f3 and f2 is outputed.

