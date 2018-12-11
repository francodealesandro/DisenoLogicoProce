library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is 

	component alu
	port(
		    a, b : in  STD_LOGIC_VECTOR (7 downto 0);
        s : out  STD_LOGIC_VECTOR (7 downto 0);
        op : in  STD_LOGIC_VECTOR (2 downto 0);
        clk : in STD_LOGIC;
		    rst : in STD_LOGIC
		);
	end component;

	-- se�ales de est�mulo
	signal a :  STD_LOGIC_VECTOR (7 downto 0) := "10110100";
	signal b :  STD_LOGIC_VECTOR (7 downto 0) := "10001010";
  signal op : STD_LOGIC_VECTOR (2 downto 0) := "110";
  signal clk :  STD_LOGIC := '0';
	signal rst :  STD_LOGIC := '0';
	
	-- se�ales a observar
	signal s:  std_logic_vector(7 downto 0);

  constant delay: time:= 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: alu port map(
		a => a,
		b => b,
		s => s,
		op => op,
		clk => clk,
		rst => rst
	);

   Pop: process 
   begin
      op <= op + 1; 
      wait for delay;
   end process;
   
  Passert: process(s)
  begin
    if rst = '1' then
      assert s = "00000000" report "Error al inducir rst" severity failure;
    else
      case op is
        when "000" =>
          assert s = a report "Error al asignar s <= a" severity failure;
        when "001" =>
          assert s = (a(6 downto 0) & '0') report "Error al asignar s <= a sll 1" severity failure;
        when "010" =>
          assert s = (a + b) report "Error al asignar s <= a + b" severity failure;
        when "011" =>
          assert s = (a - b) report "Error al asignar s <= a - b" severity failure;
        when "100" =>
          assert s = (a and b) report "Error al asignar s <= a and b" severity failure;
        when "101" =>
          assert s = (a or b) report "Error al asignar s <= a or b" severity failure;
        when "110" =>
          assert s = (a xor b) report "Error al asignar s <= a xor b" severity failure;
        when "111" =>
          assert s = ('0' & a(7 downto 1)) report "Error al asignar s <= a srl 1" severity failure;
        when others =>
          assert s = a report "Error al asignar s <= a" severity failure;
        end case;
    end if;
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
      wait for delay*16;
      rst <= '1'; 
      wait for delay;
      rst <= '0';     
      wait;
   end process; 

end;