library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity alu is
    port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           s : out  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           op : in  STD_LOGIC_VECTOR (2 downto 0));
end alu;

architecture arq of alu is

begin 

s <= (a(6 downto 0) & '0') when op = "001" else
     (a + b) when op = "010" else
     (a - b) when op = "011" else
     (a and b) when op = "100" else
     (a or b) when op = "101" else
     (a xor b) when op = "110" else
     ('0' & a(7 downto 1)) when op = "111" else
      a;
              
end arq;