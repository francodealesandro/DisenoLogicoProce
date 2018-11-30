--
-- TestBench Sumador/Restador de 8 bits
-- Martín Vázquez - UNCPBA
--


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_arith.ALL;

use IEEE.STD_LOGIC_TEXTIO.ALL; 
use std.textio.ALL;


entity addsub_tb is
end addsub_tb;


architecture practica of addsub_tb is 

   -- declaración de componente de unidad bajo testeo
   component addsub 
      port (
            a, b: in std_logic_vector(7 downto 0);
            n : in std_logic;
            s: out std_logic_vector(7 downto 0);
            cout: out std_logic);              
   end component;
   
   -- Señales de estímulo
   signal a, b: std_logic_vector(7 downto 0);
   signal n: std_logic;
   
   -- Señales a observar
   signal s: std_logic_vector(7 downto 0);
   signal cout: std_logic;
   
   constant delay: time:= 5 ns;
	
  
begin
   
   -- Unit Under Test port map
   UUT: addsub port map (
               a => a,
               b => b,
               n => n,
               s => s,
               cout => cout);


   -- TestBench
   process 

	file ResFile : TEXT open write_mode is "FileRes.txt";

   variable l : line;
   
   begin               

         write(l,string'("   a    op    b     =  cout     s"));
         writeline(ResFile,l);
			n <= '0';
         
         for i in 0 to 2**7-1 loop
            for j in 0 to 2**7-1 loop

               a <= CONV_STD_LOGIC_VECTOR(i, 8);
               b <= CONV_STD_LOGIC_VECTOR(j, 8);

               --write(l,a);
               --write(l,string'(" + "));
               --write(l,b);
               --write(l,string'(" = "));
               --writeline(ResFile,l);
               
               wait for delay;
                 
               write(l,a);
               write(l,string'(" + "));
               write(l,b);
               write(l,string'(" =   "));
               write(l,cout);
               write(l,string'("    "));               
               write(l,s);
               writeline(ResFile,l);

             end loop;
         end loop;                 

			n <= '1';
         
         for i in 0 to 2**7-1 loop
            for j in 0 to 2**7-1 loop

               a <= CONV_STD_LOGIC_VECTOR(i, 8);
               b <= CONV_STD_LOGIC_VECTOR(j, 8);
               
               wait for delay;
                 
               write(l,a);
               write(l,string'(" - "));
               write(l,b);
               write(l,string'(" =   "));
               write(l,cout);
               write(l,string'("    "));               
               write(l,s);
               writeline(ResFile,l);

             end loop;
         end loop;         

         report "TestBench finalizado";
         wait;    
   end process;          
end practica; 


