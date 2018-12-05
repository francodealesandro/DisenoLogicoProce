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
        clk : in STD_LOGIC;
		    rst : in STD_LOGIC
		);
	end component;

	-- Señales de estímulo
	signal A :  STD_LOGIC_VECTOR (7 downto 0) := "10110100";
	signal B :  STD_LOGIC_VECTOR (7 downto 0) := "10001010";
  signal op : STD_LOGIC_VECTOR (2 downto 0) := "110";
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
      wait for delay;
   end process;
   
  Passert: process(S)
  begin
    if rst = '1' then
      assert S = "00000000" report "Error al inducir rst" severity failure;
    else
      case op is
        when "000" =>
          assert S = A report "Error al asignar S <= A" severity failure;
        when "001" =>
          assert S = (A(6 downto 0) & '0') report "Error al asignar S <= A sll 1" severity failure;
        when "010" =>
          assert S = (A + B) report "Error al asignar S <= A + B" severity failure;
        when "011" =>
          assert S = (A - B) report "Error al asignar S <= A - B" severity failure;
        when "100" =>
          assert S = (A and B) report "Error al asignar S <= A and B" severity failure;
        when "101" =>
          assert S = (A or B) report "Error al asignar S <= A or B" severity failure;
        when "110" =>
          assert S = (A xor B) report "Error al asignar S <= A xor B" severity failure;
        when "111" =>
          assert S = ('0' & A(7 downto 1)) report "Error al asignar S <= A srl 1" severity failure;
        when others =>
          assert S = A report "Error al asignar S <= A" severity failure;
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