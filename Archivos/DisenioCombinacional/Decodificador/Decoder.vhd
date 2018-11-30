--
-- Decodificador 3 a 8 bits
-- Elías Todorovich - EPS - UAM
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL; -- para la función CONV_INTEGER


entity Decoder is
   port (
         a: in std_logic_vector(2 downto 0);
         y: out std_logic_vector(7 downto 0));              
end Decoder;

-- arquitectura basada en sentencia concurrente with-select
architecture asg_sel of decoder is 
begin

   with a select 
      y <=  "00000001" when "000",
            x"02" when "001",
            x"04" when "010",
            x"08" when "011",
            x"10" when "100",
            x"20" when "101",
            x"40" when "110",
            x"80" when "111",                                    
            "XXXXXXXX" when others;  
end asg_sel;  

-- Arquitectura basada en sentencia for
architecture beh_for of decoder is 
begin
 
   process (a)
   begin
      
      for i in 0 to 7 loop 
         if CONV_INTEGER(a) = i then y(i) <= '1';
         else y(i) <= '0';
         end if;
      end loop;   
   end process;       
          
end beh_for;  



-- Arquitectura basada en sentencia case
architecture beh_case of decoder is 
begin

   process (a)
   begin
      
      case a is 
            when "000" => y <= x"01";
            when "001" => y <= x"02";
            when "010" => y <= x"04";
            when "011" => y <= x"08";
            when "100" => y <= x"10";
            when "101" => y <= x"20";
            when "110" => y <= x"40";
            when "111" => y <= x"80";
            when others => y <= "XXXXXXXX";
      end case;                
   end process;       
          
end beh_case;  
           

