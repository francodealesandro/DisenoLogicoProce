--
-- Sumador Restador de 8 bits con carry out
--
-- Sumador Restador de 8 bits con carry out
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;


entity addsub is
   port (
         a, b: in std_logic_vector(7 downto 0);
         n : in std_logic;
         s: out std_logic_vector(7 downto 0);
         cout: out std_logic);              
end addsub;

-- arquitectura básica con un sumador y un restador
architecture beh_basic of addsub is 
signal s_add, s_sub: std_logic_vector(8 downto 0); 
begin
   
   s_add <= (a(7)&a) + (b(7)&b);
   s_sub <= (a(7)&a) - (b(7)&b);
   

   s <= s_add(7 downto 0) when n='0' else
        s_sub(7 downto 0);
         
   cout <= s_add(8) when n='0' else
           s_sub(8);
   
end beh_basic;  


-- Arquitectura más cpmpacta con un solo sumador restador
architecture beh_compact of addsub is 
signal b_int: std_logic_vector(7 downto 0);
signal addsub_int: std_logic_vector(8 downto 0);
begin
   
   b_int <= not b when n='1' else b;

   addsub_int <= (a(7)&a) + (b_int(7)&b_int) + n;
   
   s <= addsub_int(7 downto 0);
   cout <= addsub_int(8);
   
end beh_compact;  



-- Arquitectura basada en generación de instanciación de componentes 
architecture beh_geninst of addsub is 

component FA_1 
   port (
         a, b, cin: in std_logic;
         s, cout: out std_logic);              
end component;

signal c: std_logic_vector(8 downto 0);
signal b_int: std_logic_vector(7 downto 0);

begin
   
   b_int <= not b when n='1' else b;
   c(0) <= n;
   
   GenInst:for i in 0 to 7 generate
      IFA: FA_1 port map (
               a => a(i),
               b => b_int(i),
               cin => c(i),
               s => s(i),
               cout => c(i+1));
   end generate;
   
   cout <= c(8);
   
end beh_geninst;


