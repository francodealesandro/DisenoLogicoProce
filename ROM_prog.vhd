library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity rom_prog is
    port (addr : in  STD_LOGIC_VECTOR(6 downto 0);
        output : out STD_LOGIC_VECTOR(15 downto 0));
end rom_prog;
 
architecture rom_arq of rom_prog is
  
    constant rom_tam : INTEGER := 15;
    type memoria_rom is array (0 to rom_tam-1) of STD_LOGIC_VECTOR (15 downto 0);
    signal ROM : memoria_rom := (
      "0000000100110000", --in r3
	    "0000010000000011", --lda r3
	    "0001000001000011", --add r4 r3
	    "0001000101010100", --sub r5 r4
	    "0001001101100100", --or r6 r4
	    "0001001001110000", --and r7 r0
	    "0000001111100100", --mov r14 r4
	    "0000001000000011", --out r3
	    "0000001000000100", --out r4
	    "0000001000000101", --out r5
	    "0000001000000110", --out r6
	    "0000001000001000", --out r7
	    "0000001000001001", --out r8
	    "0000001000001101", --out r13
	    "0000001000001110"  --out r14
    );
    
begin
  
    output <= ROM(conv_integer(addr)) when addr <= (rom_tam-1) else (others => '0');
    
end rom_arq;