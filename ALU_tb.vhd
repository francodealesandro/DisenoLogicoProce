library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture alu_behavior of alu_tb is 

	component alu
	port(
		    alu_a, alu_b : in  STD_LOGIC_VECTOR (7 downto 0);
        alu_s : out  STD_LOGIC_VECTOR (7 downto 0);
        alu_op : in  STD_LOGIC_VECTOR (2 downto 0);
        alu_clk : in STD_LOGIC;
		    alu_rst : in STD_LOGIC
		);
	end component;

	-- alu_señales de estímulo
	signal alu_a :  STD_LOGIC_VECTOR (7 downto 0) := "10110100";
	signal alu_b :  STD_LOGIC_VECTOR (7 downto 0) := "10001010";
  signal alu_op : STD_LOGIC_VECTOR (2 downto 0) := "110";
  signal alu_clk :  STD_LOGIC := '0';
	signal alu_rst :  STD_LOGIC := '0';
	
	-- alu_señales a observar
	signal alu_s:  std_logic_vector(7 downto 0);

  constant delay: time:= 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: alu port map(
		alu_a => alu_a,
		alu_b => alu_b,
		alu_s => alu_s,
		alu_op => alu_op,
		alu_clk => alu_clk,
		alu_rst => alu_rst
	);

   Pop: process 
   begin
      alu_op <= alu_op + 1; 
      wait for delay;
   end process;
   
  Passert: process(alu_s)
  begin
    if alu_rst = '1' then
      assert alu_s = "00000000" report "Error al inducir alu_rst" severity failure;
    else
      case alu_op is
        when "000" =>
          assert alu_s = alu_a report "Error al asignar alu_s <= alu_a" severity failure;
        when "001" =>
          assert alu_s = (alu_a(6 downto 0) & '0') report "Error al asignar alu_s <= alu_a sll 1" severity failure;
        when "010" =>
          assert alu_s = (alu_a + alu_b) report "Error al asignar alu_s <= alu_a + alu_b" severity failure;
        when "011" =>
          assert alu_s = (alu_a - alu_b) report "Error al asignar alu_s <= alu_a - alu_b" severity failure;
        when "100" =>
          assert alu_s = (alu_a and alu_b) report "Error al asignar alu_s <= alu_a and alu_b" severity failure;
        when "101" =>
          assert alu_s = (alu_a or alu_b) report "Error al asignar alu_s <= alu_a or alu_b" severity failure;
        when "110" =>
          assert alu_s = (alu_a xor alu_b) report "Error al asignar alu_s <= alu_a xor alu_b" severity failure;
        when "111" =>
          assert alu_s = ('0' & alu_a(7 downto 1)) report "Error al asignar alu_s <= alu_a srl 1" severity failure;
        when others =>
          assert alu_s = alu_a report "Error al asignar alu_s <= alu_a" severity failure;
        end case;
    end if;
   end process;
   
   Pclk: process 
   begin
      alu_clk <= '0';
      wait for delay/2;
      alu_clk <= '1';
      wait for delay/2;
   end process;       
   
   PRst: process 
   begin
      alu_rst <= '1'; 
      wait for delay;
      alu_rst <= '0';     
      wait for delay*16;
      alu_rst <= '1'; 
      wait for delay;
      alu_rst <= '0';     
      wait;
   end process; 

end;