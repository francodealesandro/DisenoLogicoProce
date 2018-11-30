-- semaforo_tb.vhd
-- Testbench para FSM de semaforo
-- Lucas Leiva y Martín Vázquez. UNCPBA

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY semaforo_tb IS
END semaforo_tb;

ARCHITECTURE behavior OF semaforo_tb IS 

	COMPONENT semaforo
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;          
		s1,s2: out std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	-- Señales de estímulo
	SIGNAL clk :  std_logic := '0';
	SIGNAL rst :  std_logic := '0';

	-- Señales a observar
	SIGNAL s1, s2:  std_logic_vector(2 downto 0);

   constant delay: time:= 7 ns;
   constant tper: time:= 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: semaforo PORT MAP(
		clk => clk,
		rst => rst,
		s1 => s1,
		s2 => s2
	);


   Pclk: process 
   begin
      clk <= '0';
      wait for tper/2;
      clk <= '1';
      wait for tper/2;
   end process;       
   
   PRst: process 
   begin
      rst <= '1'; 
      wait for delay;
      rst <= '0';
      wait for 100*delay;
      rst <= '1';
      wait for 10*delay;
      rst <= '0';        
      wait;
   end process; 

END;

