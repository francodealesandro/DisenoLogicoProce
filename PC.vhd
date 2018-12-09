library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity pc is
    port (
        pc_output : out STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
        pc_clk, pc_rst  : in  STD_LOGIC
    );
end pc;
 
architecture pc_arq of pc is
    
    signal count : STD_LOGIC_VECTOR(6 downto 0);
    
begin
  
    sync: process (pc_clk, pc_rst) 
    begin
      if pc_rst = '1' then
	      count <= (others => '0');
	      pc_output <= (others => '0');
      elsif rising_edge(pc_clk) then
        count <= count+1;
        pc_output <= count;
      end if;
    end process;
    
end pc_arq;