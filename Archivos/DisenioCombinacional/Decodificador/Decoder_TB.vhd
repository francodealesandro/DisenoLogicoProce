--
-- TestBench Decodificador 3 a 8 bits
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_arith.ALL;

entity decoder_tb is
end decoder_tb;


architecture practica of decoder_tb is 

   -- declaración de componente de unidad bajo testeo
   component decoder
   port(
         a: in std_logic_vector(2 downto 0);
         y: out std_logic_vector(7 downto 0));              
   end component;             
   
   -- Señal de estímulo
   signal a: std_logic_vector(2 downto 0);
   
   -- Señal a observar
   signal y: std_logic_vector(7 downto 0);
   
   constant delay: time:= 20 ns;
	
	--signal result:std_logic_vector(7 downto 0);	
	-- para ver que ocurre con memoria
   
begin
   
   -- Unit Under Test port map
   UUT: decoder port map (
               a => a, y => y);


   -- TestBench
   process 
   
      procedure CONV_INT_STD(i: integer; signal s: out std_logic_vector(2 downto 0) ) is
      begin
          case i is
             when 0 => s <= "000";
             when 1 => s <= "001"; 
             when 2 => s <= "010";
             when 3 => s <= "011"; 
             when 4 => s <= "100";
             when 5 => s <= "101"; 
             when 6 => s <= "110";
             when 7 => s <= "111"; 
             when others => s <= "XXX"; 
          end case;
      end; 
      
      variable result:std_logic_vector(7 downto 0);

   begin               

			-- Funcionamiento normal
         for i in 0 to 7 loop
            
            CONV_INT_STD(i,a);
				--a <= CONV_STD_LOGIC_VECTOR(i, 3);
							
				wait for delay;
            
				result := (others => '0');
				result(i) := '1';
				
            assert Y=result report "Error en el decodificador" severity error;
				
			end loop;
                           
         report "TestBench finalizado";
         wait;    
   end process;          
end practica; 

