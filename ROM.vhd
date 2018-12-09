library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity rom_prog is
    port (
        rom_prog_addr : in  STD_LOGIC_VECTOR(6 downto 0);
        rom_prog_output : out STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
        rom_prog_clk  : in  STD_LOGIC;
        rom_prog_rst : in  STD_LOGIC  
    );
end rom_prog;
 
architecture rom_arq of rom_prog is
  
    type memoria_rom is array (0 to 14) of STD_LOGIC_VECTOR (15 downto 0);
    signal ROM : memoria_rom := (
      "0000000100110000", --in r3
	    "0000010000000011", --lda r3
	    "0000101001000011", --add r4 r3
	    "0000101101000101", --sub r4 r5
	    "0000110101100100", --or r6 r4
	    "0000110001110000", --and r7 r0
	    "0000001111100100", --mov r14 r4
	    "0000001000000011", --out r3
	    "0000001000000100", --out r4
	    "0000001000000101", --out r5
	    "0000001000000110", --out r6
	    "0000001000001000", --out r7
	    "0000001000001001", --out r8
	    "0000001000001101", --out r13
	    "0000001000001110" --out r14
    );
    
begin
  
    sync: process (rom_prog_clk, rom_prog_rst) 
    begin
      if rom_prog_rst = '1' then
	      rom_prog_output <= (others => '0');
      elsif rising_edge(rom_prog_clk) then
        rom_prog_output <= ROM(conv_integer(rom_prog_addr));
      end if;
    end process;
    
end rom_arq;