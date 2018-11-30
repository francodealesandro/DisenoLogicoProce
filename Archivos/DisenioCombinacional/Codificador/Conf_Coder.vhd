-- Configuración para testbench de 
-- Codificador 8 a 3 bits con prioridad
-- Martín Vázquez - UNCPBA 

configuration conf_coder of coder_tb is 
   for practica
      for UUT: coder
         --use entity work.coder(asg_conc);
         use entity work.coder(beh_if);
      end for;   
   end for; 
      
end conf_coder;


