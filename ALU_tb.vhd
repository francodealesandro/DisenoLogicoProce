library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU_tb is
end ALU_tb;

architecture behavior of ALU_tb is 

	component ALU
	port(
		    A, B : in  STD_LOGIC_VECTOR (7 downto 0);
        S : out  STD_LOGIC_VECTOR (7 downto 0);
        op : in  STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	-- Señales de estímulo
	signal A :  std_logic_vector(7 downto 0) := "10000000";
	signal B :  std_logic_vector(7 downto 0) := "00000001";
  signal op : std_logic_vector(2 downto 0) := "000";
  
	-- Señales a observar
	signal S:  std_logic_vector(7 downto 0);

  constant delay: time:= 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU port map(
		A => A,
		B => B,
		S => S,
		op => op
	);

   POP: process 
   begin
      op <= op + 1; 
      if (op = "000") then
        wait;
      else
        wait for delay;
      end if;
   end process; 

end;