-- Configuración para testbench de 
-- Multiplexor 2 a 1 de N bits

configuration conf_muxNtb of muxN_tb is 
   for practica
      for UUT: muxN
         --use entity work.muxN(asg_conc);
         use entity work.muxN(gen_inst);
      end for;   
   end for; 
      
end conf_muxNtb;
