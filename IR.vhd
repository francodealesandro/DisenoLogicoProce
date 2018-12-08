library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ir is
    port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           we : in  STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC
          );
end ir;

architecture ir_arq of ir is
  
  signal instruction : STD_LOGIC_VECTOR (15 downto 0);
  
begin 
  
  sync: process(clk, rst)
	begin
	  if rst = '1' then
	    output <= (others => '0');
		elsif (rising_edge(clk)) then
			output <= instruction;
		end if;
	end process;
	
	process(input, we)
	begin
	  if we = '1' then
	    instruction <= input;
		end if;
	end process;

end ir_arq;