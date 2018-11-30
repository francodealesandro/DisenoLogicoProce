--
-- TestBench Multiplexor 2 a 1 de N bits
-- Martín Vázquez - UNCPBA 
--


library ieee;
use ieee.std_logic_1164.ALL;


entity muxN_tb is
end muxN_tb;


architecture practica of muxN_tb is 


   -- declaración de componente de Unidad bajo testeo
   component muxN
   generic (N:integer:=3);  
   port(
         a,b: in std_logic_vector(N-1 downto 0);
         sel : in std_logic;
         y: out std_logic_vector(N-1 downto 0));              
   end component;             
   

   constant N: integer := 8;

   -- Señales de estímulo
   signal sel: std_logic;
   signal a,b: std_logic_vector(N-1 downto 0);
   
   -- Señales a observar
   signal y: std_logic_vector(N-1 downto 0);
   
   constant delay: time:= 10 ns;
   
begin
   
   -- Unit Under Test port map
   UUT: muxN
            generic map (N) -- =>
            port map (
               a => a, b => b, sel => sel, y => y);


   -- TestBench
   process 
   begin               

         -- Prueba de puerto A
         sel <= '0';
         a <= x"a0";
         b <= x"01";
         wait for delay;
         assert y=a report "No funciona muxN. Puerto A" severity error;

         a <= x"0f";
         wait for delay;
         assert y=a report "No funciona muxN. Puerto A" severity error;

         -- Prueba de puerto B         
         sel <= '1';
         a <= x"0a";
         b <= x"01";
         wait for delay;
         assert y=b report "No funciona muxN. Puerto B" severity error;
         
         b <= x"0f";
         wait for delay;
         assert y=b report "No funciona muxN. Puerto B" severity error;
                  
         report "TestBench finalizado";
         wait;    
   end process;          
end practica; 

