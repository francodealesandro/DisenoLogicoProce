library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity pc is
    port (
        output : out STD_LOGIC_VECTOR(6 downto 0);
        clk  : in  STD_LOGIC;
        rst : in  STD_LOGIC  
    );
end pc;
 
architecture pc_arq of pc is
    
    signal count : STD_LOGIC_VECTOR(6 downto 0);
    
begin
  
    process (clk, rst) 
    begin
      if rst = '1' then
	      count <= (others => '0');
	      output <= (others => '0');
      elsif rising_edge(clk) then
        count <= count+1;
        output <= count;
      end if;
    end process;
    
end pc_arq;