LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE behavior OF ALU_tb IS 

	COMPONENT ALU
	PORT(
		    A, B : in  STD_LOGIC_VECTOR (7 downto 0);
        S : out  STD_LOGIC_VECTOR (7 downto 0);
        op : in  STD_LOGIC_VECTOR (2 downto 0)
		);
	END COMPONENT;

	-- Señales de estímulo
	SIGNAL A :  std_logic_vector(7 downto 0) := "10000000";
	SIGNAL B :  std_logic_vector(7 downto 0) := "00000001";
  SIGNAL op : std_logic_vector(2 downto 0) := "000";
  
	-- Señales a observar
	SIGNAL S:  std_logic_vector(7 downto 0);

  constant delay: time:= 7 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		A => A,
		B => B,
		S => S,
		op => op
	);

   POP: process 
   begin
      op <= op + 1; 
      wait for delay;
   end process; 

END;


