-- Configuración para testbench de 
-- Decodificador 3 a 8 bits

configuration conf_Decoder of decoder_tb is 
   for practica
      for UUT: Decoder
         use entity work.Decoder(asg_sel);
         --use entity work.Decoder(beh_for);
         --use entity work.Decoder(beh_case);   
      end for;   
   end for; 
      
end conf_Decoder;
