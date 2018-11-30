--
-- Codificador de 8 a 3 con prioridad
-- Elías Todorovich - EPS - UAM
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;


entity Coder is
   port (
         a: in std_logic_vector(7 downto 0);
         y: out std_logic_vector(2 downto 0);
         valid: out std_logic);              
end Coder;

-- arquitectura basada en asignaciones concurrentes 
architecture asg_conc of coder is 
begin
   
   y <=  "111" when a(7)='1' else
         "110" when a(6)='1' else
         "101" when a(5)='1' else
         "100" when a(4)='1' else
         "011" when a(3)='1' else
         "010" when a(2)='1' else
         "001" when a(1)='1' else
         "000";

   valid <= '0' when a=x"00" else '1';
                              
   
end asg_conc;  


-- Arquitectura basada en sentencia if
architecture beh_if of coder is 
begin

   process (a)
   begin
      
      if a(7)='1' then
         y <= "111";          
      elsif a(6)='1' then    
         y <= "110";          
      elsif a(5)='1' then    
         y <= "101";          
      elsif a(4)='1' then    
         y <= "100";          
      elsif a(3)='1' then    
         y <= "011";          
      elsif a(2)='1' then    
         y <= "010";          
      elsif a(1)='1' then    
         y <= "001";
      else
         y <= "000";             
      end if;
   end process;       

   valid <= '0' when a=x"00" else '1';
          
end beh_if;  

