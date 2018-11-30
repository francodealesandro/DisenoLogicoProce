-- Contador binario de 8 bits con reset asincrónico
-- y carga sincrónica
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;


entity count8 is
   port (
         clk, rst, l: in std_logic;
         i : in std_logic_vector(7 downto 0);
         o: out std_logic_vector(7 downto 0));

end count8;


-- arquitectura basada en instanciación de componentes 
architecture beh_inst of count8 is 
 
component ffd is
   port (
         clk, rst, d: in std_logic;
         q: out std_logic);

end component;  

component addsub is
   port (
         a, b: in std_logic_vector(7 downto 0);
         n : in std_logic;
         s: out std_logic_vector(7 downto 0);
         cout: out std_logic);              
end component;  

signal  count, count_next, count_add: std_logic_vector(7 downto 0); 

begin
   
   cadd: addsub port map (count, x"01", '0', count_add, open);
   
   count_next <= i when l='1' else count_add;
   
   Genffs: for j in 0 to 7 generate
      Cff: ffd port map (clk, rst, count_next(j), count(j));
   end generate;

   o <= count;
  
end beh_inst;


-- arquitectura basada en procesos 
architecture beh_proc of count8 is 
signal count: std_logic_vector(7 downto 0); 

begin
   
   pcount: process (clk, rst)
   begin
      if rst='1' then
         count <= x"00"; -- (others => '0')       
      elsif (clk'event and clk='1') then
         if (l='1') then
            count <= i;
         else
            count <= count + 1;                
         end if;             
      end if;   
   end process;

   o <= count;
  
end beh_proc;