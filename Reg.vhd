library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity reg_a is
    port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           we : in  STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC
          );
end reg_a;

architecture reg_a_arq of reg_a is
  
  signal reg : STD_LOGIC_VECTOR (7 downto 0);
  
begin 
  
  sync: process(clk, rst)
	begin
	  if rst = '1' then
	    output <= (others => '0');
		elsif (rising_edge(clk)) then
			output <= reg;
		end if;
	end process;
	
	process(input, we)
	begin
	  if we = '1' then
	    reg <= input;
		end if;
	end process;

end reg_a_arq;