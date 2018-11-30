--
-- TestBench Multiplexor 2 a 1 de 8 bits
-- Elías Todorovich - EPS - UAM
--


library ieee;
use ieee.std_logic_1164.ALL;


entity mux8_tb is
end mux8_tb;


architecture practica of mux8_tb is 

   -- component declaration of the tested unit
   component mux8
   port(
         a,b: in std_logic_vector(7 downto 0);
         sel : in std_logic;
         y: out std_logic_vector(7 downto 0));              
   end component;             
   
   -- Señales de estímulo
   signal sel: std_logic;
   signal a,b: std_logic_vector(7 downto 0);
   
   -- Señales a observar
   signal y: std_logic_vector(7 downto 0);
   
   constant delay: time:= 10 ns;
   
begin
   
   -- Unit Under Test port map
   UUT: mux8 port map (
               a => a, b => b, sel => sel, y => y);


   -- TestBench
   process 
   begin               

         -- Prueba de puerto A
         sel <= '0';
         a <= x"a0";
         b <= x"01";
         wait for delay;
         assert y=a report "No funciona mux8. Puerto A" severity error;

         a <= x"0f";
         wait for delay;
         assert y=a report "No funciona mux8. Puerto A" severity error;

         -- Prueba de puerto B         
         sel <= '1';
         a <= x"0a";
         b <= x"01";
         wait for delay;
         assert y=b report "No funciona mux8. Puerto B" severity error;
         
         b <= x"0f";
         wait for delay;
         assert y=b report "No funciona mux8. Puerto B" severity error;
                  
         report "TestBench finalizado";
         wait;    
   end process;          
end practica; 



configuration conf_mux81tb of mux8_tb is 
   for practica
      for UUT: mux8
         use entity work.mux8(beh_if);
      end for;   
   end for; 
      
end conf_mux81tb;


