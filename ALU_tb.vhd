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
        op : in  STD_LOGIC_VECTOR (2 downto 0);
        clk : IN STD_LOGIC;
		    rst : IN STD_LOGIC
		);
	end component;

	-- Señales de estímulo
	signal A :  STD_LOGIC_VECTOR (7 downto 0) := "10000000";
	signal B :  STD_LOGIC_VECTOR (7 downto 0) := "00000001";
  signal op : STD_LOGIC_VECTOR (2 downto 0) := "000";
  signal clk :  STD_LOGIC := '0';
	signal rst :  STD_LOGIC := '0';
	
	-- Señales a observar
	signal S:  std_logic_vector(7 downto 0);

  constant delay: time:= 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU port map(
		A => A,
		B => B,
		S => S,
		op => op,
		clk => clk,
		rst => rst
	);

   Pop: process 
   begin
      op <= op + 1; 
   end process; 
   
   Pclk: process 
   begin
      clk <= '0';
      wait for delay/2;
      clk <= '1';
      wait for delay/2;
   end process;       
   
   PRst: process 
   begin
      rst <= '1'; 
      wait for delay;
      rst <= '0';     
      wait for delay*12;
      rst <= '1'; 
      wait for delay;
      rst <= '0';     
      wait;
   end process; 

end;