library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity reg_out is
    port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           we : in  STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC
          );
end reg_out;

architecture reg_out_arq of reg_out is
  
  signal reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  
begin 
  
  sync: process(clk, rst)
	begin
	  if rst = '1' then
	    reg <= (others => '0');
		elsif (rising_edge(clk)) and we = '1' then
	     reg <= input;
		end if;
	end process;
	
	output <= reg;

end reg_out_arq;
