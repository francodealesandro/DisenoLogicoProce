library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ir is
    port ( ir_input : in  STD_LOGIC_VECTOR (15 downto 0);
           ir_output : out  STD_LOGIC_VECTOR (15 downto 0);
           ir_we : in  STD_LOGIC;
           ir_clk : in STD_LOGIC;
           ir_rst : in STD_LOGIC
          );
end ir;

architecture ir_arq of ir is
  
  signal instruction : STD_LOGIC_VECTOR (15 downto 0);
  
begin 
  
  sync: process(ir_clk, ir_rst)
	begin
	  if ir_rst = '1' then
	    ir_output <= (others => '0');
		elsif (rising_edge(ir_clk)) then
			ir_output <= instruction;
		end if;
	end process;
	
	process(ir_input, ir_we)
	begin
	  if ir_we = '1' then
	    instruction <= ir_input;
		end if;
	end process;

end ir_arq;