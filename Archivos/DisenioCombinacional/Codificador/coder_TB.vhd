--
-- Codificador con prioridad de 8 a 3 bits
-- Elías Todorovich - EPS - UAM
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_arith.ALL;

entity coder_tb is
end coder_tb;


architecture practica of coder_tb is 

   -- declaración de componente de unidad bajo testeo
   component coder
   port(
         a: in std_logic_vector(7 downto 0);
         y: out std_logic_vector(2 downto 0);
         valid: out std_logic);              
   end component;             
   
   -- Señal de estímulo
   signal a: std_logic_vector(7 downto 0);
   
   -- Señales a observar
   signal y: std_logic_vector(2 downto 0);
   signal v: std_logic;
   
   
   type correspondencia is record
      codificado: std_logic_vector(2 downto 0);
      decodificado: std_logic_vector(7 downto 0);
      valido: std_logic;
   end record;
   
   type tabla_pruebas is array(0 to 15) of correspondencia;    
   
   constant tabla: tabla_pruebas:=
      (("000","00000000",'0'),
      ("001","00000010",'1'),
      ("001","00000011",'1'),
      ("010","00000100",'1'),
      ("010","00000111",'1'),
      ("011","00001000",'1'),
      ("011","00001111",'1'),
      ("100","00010000",'1'),
      ("100","00011111",'1'),
      ("101","00100000",'1'),
      ("101","00111111",'1'),
      ("110","01000000",'1'),
      ("110","01111111",'1'),
      ("111","10000000",'1'),
      ("111","11111111",'1'),
      ("000","00000000",'0'));
                     
   constant delay: time:= 20 ns;
	
   
begin
   
   -- Unit Under Test port map
   UUT: coder port map (
               a => a, y => y, valid => v);


   -- TestBench
   process 
   
   begin               

         for i in 0 to 15 loop
            
				a <= tabla(i).decodificado;

				wait for delay;
            
            assert (y=tabla(i).codificado)
               report "Error en el codificador" severity error;
				
            assert (v=tabla(i).valido)
               report "Error en el codificador (por valid)" severity error;
				
			end loop;
                           
         report "TestBench finalizado";
         wait;    
   end process;          
end practica; 

