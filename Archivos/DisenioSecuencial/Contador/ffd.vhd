-- Flip flop d con reset asincrónico
--
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;


entity ffd is
   port (
         clk, rst, d: in std_logic;
         q: out std_logic);

end ffd;

-- arquitectura basada en procesos 
architecture beh_proc of ffd is 

begin
   
   pffd: process (clk, rst)
   begin
      if rst='1' then
         q <= '0';
      elsif (clk'event and clk='1') then
         q <= d;
      end if;   
   end process;

  
end beh_proc;
