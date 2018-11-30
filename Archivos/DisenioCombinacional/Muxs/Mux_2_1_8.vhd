--
-- Multiplexor 2 a 1 de 8 bits
-- Elías Todorovich - EPS - UAM
--


library ieee;
use ieee.std_logic_1164.ALL;


entity mux8 is
   port (
         a,b: in std_logic_vector(7 downto 0);
         sel : in std_logic;
         y: out std_logic_vector(7 downto 0));              
end mux8;

-- arquitectura basada en sentencia if
architecture beh_if of mux8 is 
begin

 
   process (sel, a, b)
   begin
      
      if sel = '1' then y <= b;
      elsif sel = '0' then y <= a;
      else y <= "XXXXXXXX";
      end if;   
   end process;       
          
end beh_if;  



-- arquitectura basada en sentencia case
architecture beh_case of mux8 is 
begin

 
   process (sel, a, b)
   begin
      
      case sel is 
            when '0' => y <= a;
            when '1' => y <= b;
            when others => y <= "XXXXXXXX";
      end case;                
   end process;       
          
end beh_case;  


-- arquitectura basada en asignación concurrente condicional
architecture asg_conc of mux8 is 
begin

   y <=  a when sel='0' else 
         b when sel='1' else                                 
         "XXXXXXXX";
end asg_conc;  


-- arquitectura basada en asignacion con with-select
architecture asg_sel of mux8 is 
begin

   with sel select
      y <=   a when '0',
             b when '1',
             "XXXXXXXX" when others;  

end asg_sel;  
           
