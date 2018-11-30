-- Configuración para testbench de 
-- Contador 8 bits
-- Martín Vázquez - UNCPBA

configuration conf_count8tb of count8_tb is 
   for practica
      for UUT: count8
         use entity work.count8(beh_inst);
         --use entity work.count8(beh_proc);
      end for;   
   end for; 
     
end conf_count8tb;
