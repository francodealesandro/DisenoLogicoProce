library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity reg_a is
    port ( reg_a_input : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_a_output : out  STD_LOGIC_VECTOR (7 downto 0);
           reg_a_we : in  STD_LOGIC;
           reg_a_clk : in STD_LOGIC;
           reg_a_rst : in STD_LOGIC
          );
end reg_a;

architecture reg_a_arq of reg_a is
  
  signal reg : STD_LOGIC_VECTOR (7 downto 0);
  
begin 
  
  sync: process(reg_a_clk, reg_a_rst)
	begin
	  if reg_a_rst = '1' then
	    reg_a_output <= (others => '0');
		elsif (rising_edge(reg_a_clk)) then
			reg_a_output <= reg;
		end if;
	end process;
	
	process(reg_a_input, reg_a_we)
	begin
	  if reg_a_we = '1' then
	    reg <= reg_a_input;
		end if;
	end process;

end reg_a_arq;