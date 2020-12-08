-- Code your design here
-- Code for T-Flip Flop
library IEEE;
use IEEE.std_logic_1164.all;
entity TFF is 
	port(
        R:in std_logic;
        T:in std_logic;
        Clk:in std_logic;
        Q:out std_logic);
end TFF;

--behavioural architecture 
architecture Behav1 of TFF is
begin
	proc: process(Clk,R) is
    begin
    if R='1' then
    	Q<='0';
    else
    	if Clk'event and Clk='0' then
        	if T='0' then
            	Q<=Q;
            else
            	Q<=not(Q);
            end if;
        end if;
    end if;
    end process proc;
end Behav1;
---------------------------------------------
---------------------------------------------
-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity Testbench is 
-- 
end Testbench;

architecture Behav of Testbench is
    component TFF is 
	port(
        R:in std_logic;
        T:in std_logic;
        Clk:in std_logic;
        Q:out std_logic);
	end component;

    
    
	signal R0,R1,R2,R: std_logic:='1';
    signal T0,T1,T2,T: std_logic:='0';
    signal Clk: std_logic:='0';
    signal Q: std_logic:='1';
begin
	ff:TFF port map(R,T,Clk,Q);
    
    Clk<=not Clk after 10ns;
    R1<='0' after 2ns;
    R2<=not(R2) after 130ns;
    R0<=not (R1 xor R2);
    R<=R0 after 4ns;
    T0<=not(T0) after 5ns;
    T1<=not(T1) after 25ns;
    T2<=T1 xor T0;
    T<=T2 after 3ns;
end Behav;
---------------------------------------------
---------------------------------------------
