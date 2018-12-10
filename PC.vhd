library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity pc is
    port (output : out STD_LOGIC_VECTOR(6 downto 0);
          clk, rst  : in  STD_LOGIC);
end pc;
 
architecture pc_arq of pc is
    
    signal count : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    
begin
  
    sync: process (clk, rst) 
    begin
      if rst = '1' then
	      count <= (others => '0');
      elsif rising_edge(clk) then
        count <= count+1;
      end if;
    end process;
    
    output <= count;
    
end pc_arq;