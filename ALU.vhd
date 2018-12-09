library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity alu is
    port ( alu_a : in  STD_LOGIC_VECTOR (7 downto 0);
           alu_b : in  STD_LOGIC_VECTOR (7 downto 0);
           alu_s : out  STD_LOGIC_VECTOR (7 downto 0);
           alu_op : in  STD_LOGIC_VECTOR (2 downto 0);
           alu_clk : in STD_LOGIC;
           alu_rst : in STD_LOGIC
          );
end alu;

architecture alu_arq of alu is
  
  signal next_state : STD_LOGIC_VECTOR (7 downto 0);
  
begin 
  
  sync: process(alu_clk, alu_rst)
	begin
	  if alu_rst = '1' then
	    alu_s <= (others => '0');
		elsif (rising_edge(alu_clk)) then
			alu_s <= next_state;
		end if;
	end process;

next_state <= alu_a(6 downto 0) & '0' when alu_op = "001" else
              alu_a + alu_b when alu_op = "010" else
              alu_a - alu_b when alu_op = "011" else
              alu_a and alu_b when alu_op = "100" else
              alu_a or alu_b when alu_op = "101" else
              alu_a xor alu_b when alu_op = "110" else
              '0' & alu_a(7 downto 1) when alu_op = "111" else
              alu_a;
end alu_arq;