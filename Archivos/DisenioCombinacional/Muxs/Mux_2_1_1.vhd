-- Multiplexor 2 to 1 de 1 bit
-- Martín Vázquez - UNCPBA



library ieee;
use ieee.std_logic_1164.ALL;


entity mux is
   port (
         a,b: in std_logic;
         sel : in std_logic;
         y: out std_logic);              
end mux;

-- arquitectura basada en asignación concurrente condicional
architecture asg_conc of mux is 
begin

   y <=  a when sel='0' else 
         b when sel='1' else                                 
         'X';    
         
end asg_conc;     