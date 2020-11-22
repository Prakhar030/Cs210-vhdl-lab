-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- A 8-to-3 Priority encoder outputs the corresponding value of x,y,z according to the input.
entity PE8to3 is 
	port(
        d:in std_logic_vector(7 downto 0);
        v:out std_logic;
        x:out std_logic;
        y:out std_logic;
        z:out std_logic);
end PE8to3;

--architecture in terms of and ,not ,or gates.
architecture Behav1 of PE8to3 is
begin
	Encoder: process(d)
    begin
    if (d(7)='1') then x<='1';y<='1';z<='1'; v <= '1';
    elsif (d(6)='1') then x<='1';y<='1';z<='0'; v <= '1';
    elsif (d(5)='1') then x<='1';y<='0';z<='1'; v <= '1';
    elsif (d(4)='1') then x<='1';y<='0';z<='0'; v <= '1';
    elsif (d(3)='1') then x<='0';y<='1';z<='1'; v <= '1';
    elsif (d(2)='1') then x<='0';y<='1';z<='0'; v <= '1';
    elsif (d(1)='1') then x<='0';y<='0';z<='1'; v <= '1';
    elsif (d(0)='1') then x<='0';y<='0';z<='0'; v <= '1';
    else x<='0';y<='0';z<='0';v <= '0';
    end if;
    end process Encoder;
end Behav1;


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
    component PE8to3 is 
	port( d:in std_logic_vector(7 downto 0);
        v:out std_logic;
        x:out std_logic;
        y:out std_logic;
        z:out std_logic);
	end component;
	
	signal X: std_logic:='0';
    signal Y: std_logic:='0';
    signal Z: std_logic:='0';
    signal V: std_logic:='0';
    signal D: std_logic_vector(7 downto 0):="00000000";
begin
	
	PE: PE8to3 port map(D,V,X,Y,Z);
    
    
	-- Assign values to input signals.
    D<=std_logic_vector(unsigned(D)+1) after 1 ns;
    
	

	
end Behav;

-- How My code works:-
--when 10000000<=D<100000000 X="1",Y="1",Z="1" as D(7) is 1 and V='1'.
--when 1000000<=D<10000000 X="1",Y="1",Z="0" as D(6) is 1 and V='1'.
--when 100000<=D<1000000 X="1",Y="0",Z="1" as D(5) is 1 and V='1'.
--when 10000<=D<100000 X="1",Y="0",Z="0" as D(4) is 1 and V='1'.
--when 1000<=D<10000 X="0",Y="1",Z="1" as D(3) is 1 and V='1'.
--when 100<=D<1000 X="0",Y="1",Z="0" as D(2) is 1 and V='1'.
--when 10<=D<100 X="0",Y="0",Z="1" as D(1) is 1 and V='1'.
--when 1<=D<10 X="0",Y="0",Z="0" as D(0) is 1 and V='1'.
--when D=000000000 X="0",Y="0",Z="0" and V='0'.
