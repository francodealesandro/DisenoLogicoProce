-- Configuraci�n para testbench de 
-- FSM de semaforo
-- Lucas Leiva y Mart�n V�zquez - UNCPBA

configuration conf_semaforo of semaforo_tb is
  for behavior
    for uut : semaforo
      --use entity work.semaforo(Moore_oreg);
      --use entity work.semaforo(Moore_ocomb);
      use entity work.semaforo(Mealy);
    end for;
  end for;
end conf_semaforo;

