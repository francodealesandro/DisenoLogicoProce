--
-- TestBench para Contador de 8 bits
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_arith.ALL;


entity count8_tb is
end count8_tb;


architecture practica of count8_tb is 


   component count8 
      port (
            clk, rst, l: in std_logic;
            i : in std_logic_vector(7 downto 0);
            o: out std_logic_vector(7 downto 0));
   end component;
   
   -- Señales de estímulo
   signal clock, reset, ld: std_logic; 
   signal inp: std_logic_vector(7 downto 0);
   
   -- Señales a observar
   signal o: std_logic_vector(7 downto 0);
   
   constant delay: time:= 5 ns;
   constant tper: time:= 10 ns;	
  
begin
   
   -- Unit Under Test port map
   UUT: count8 port map (
               clk => clock,
               rst => reset,
               l => ld,
               i => inp,
               o => o);


   -- TestBench
   
   Pclk: process 
   begin
      clock <= '0';
      wait for tper/2;
      clock <= '1';
      wait for tper/2;
   end process;       
   
   PRst: process 
   begin
      reset <= '0';
      wait for 10*delay;
      reset <= '1';
      wait for 10*delay;
      reset <= '0';        
      wait;
   end process; 

   PLoad: process 
   begin
      ld <= '0';
      wait for 100*tper;
      ld <= '1';
      wait for 5*tper;
      ld <= '0';
      wait;
   end process; 


   PInp: process 
   begin
      inp <= x"12";
      wait for 103*tper;
      inp <= x"78";
      wait;
   end process; 

end practica; 


