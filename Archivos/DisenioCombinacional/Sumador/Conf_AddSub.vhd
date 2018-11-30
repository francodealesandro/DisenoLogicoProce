-- Configuración para testbench de 
-- Sumador/Restador de 8 bits
-- Martín Vázquez - UNCPBA

configuration conf_addsub of addsub_tb is 
   for practica
      for UUT: addsub
         --use entity work.addsub(beh_basic);
         --use entity work.addsub(beh_compact);
         use entity work.addsub(beh_geninst);         
      end for;   
   end for; 
   
      
end conf_addsub;

