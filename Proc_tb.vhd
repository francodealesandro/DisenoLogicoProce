library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity proc_tb is
end proc_tb;

architecture proc_behavior of proc_tb is 

	component proc
	port(
		    clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        input : in  STD_LOGIC_VECTOR (7 downto 0);
        output : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;

	-- Señales de estímulo
	signal clk, rst : STD_LOGIC := '0';
  signal input : STD_LOGIC_VECTOR (7 downto 0) := (others => '1');
  
	-- Señales a observar
	signal output : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	
  constant delay: time:= 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: proc port map(
		input => input,
		output => output,
		clk => clk,
		rst => rst
	);

  Passert: process
  begin
    wait for delay*3;
    --assert output = "00000000" report "Error al inducir rst" severity failure;
    wait for delay*8;
    --assert output = "11111111" report "Instruccion 7: r3" severity failure;
    wait for delay;
    --assert output = "11111110" report "Instruccion 8: r4" severity failure;
    wait for delay;
    --assert output = "00000001" report "Instruccion 9: r5" severity failure;
    wait for delay;
    --assert output = "11111111" report "Instruccion 10: r6" severity failure;
    wait for delay;
    --assert output = "00000000" report "Instruccion 11: r7" severity failure;
    wait for delay;
    --assert output = "00000000" report "Instruccion 12: r8" severity failure;
    wait for delay;
    --assert output = "00000000" report "Instruccion 13: r13" severity failure;
    wait for delay;
    --assert output = "11111111" report "Instruccion 14: r14" severity failure;
    wait;
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
      wait;
   end process; 

end;
