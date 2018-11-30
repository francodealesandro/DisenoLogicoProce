-- Multiplexor de 2 a 1 de N bits (générico)
-- Martín Vázquez - UNCPBA


library ieee;
use ieee.std_logic_1164.ALL;


entity muxN is
   generic (N: integer:=3); 
   port (
         a,b: in std_logic_vector(N-1 downto 0);
         sel : in std_logic;
         y: out std_logic_vector(N-1 downto 0));              
end muxN;

-- arquitectura basada en asignación concurrente condicional
architecture asg_conc of muxN is 
begin

   y <=  a when sel='0' else 
         b when sel='1' else                                 
         (others => 'X');    
         
end asg_conc;



-- arquitectura basada en generación de sent. concurrentes
-- con instanciación de componentes
architecture gen_inst of muxN is 

   component mux 
   port (
         a,b: in std_logic;
         sel : in std_logic;
         y: out std_logic);              
   end component;

begin

   GMuxN:for I in 0 to N-1 generate
      GMx1: mux port map (
                     a => a(I),--a
                     b => b(I),--b
                     sel => sel,
                     y => y(i));
   end generate;
      
end gen_inst;