--
-- Full Adder de 1 bit
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;



entity FA_1 is
   port (
         a, b, cin: in std_logic;
         s, cout: out std_logic);              
end FA_1;

architecture beh_basic of FA_1 is 

begin
   
   s <= a xor b xor cin;
   cout <= (a and b) or (a and cin) or (b and cin);

end beh_basic;  
