library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity rom_prog is
    port (
        addr : in  STD_LOGIC_VECTOR(6 downto 0);
        output : out STD_LOGIC_VECTOR(15 downto 0);
        clk  : in  STD_LOGIC;
        rst : in  STD_LOGIC  
    );
end rom_prog;
 
architecture rom_arq of rom_prog is
  
    type memoria_rom is array (0 to 127) of STD_LOGIC_VECTOR (15 downto 0);
    signal ROM : memoria_rom;
    
begin
  
    process (clk, rst) 
    begin
      if rst = '1' then
	      output <= (others => '0');
      elsif rising_edge(clk) then
        output <= ROM(conv_integer(addr));
      end if;
    end process;
    
end rom_arq;
