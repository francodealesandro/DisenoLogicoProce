library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity decode is
    port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           out_we : out  STD_LOGIC := '0';
           reg_we : out  STD_LOGIC := '0';
           reg_a_we : out  STD_LOGIC := '0';
           alu_op : out  STD_LOGIC_VECTOR (2 downto 0);
           bus_sel : out  STD_LOGIC_VECTOR (1 downto 0));
end decode;

architecture decode_arq of decode is
  
begin
  
  out_we <= '1' when input = "00000010" else '0';
  
  reg_a_we <= '1' when (input = "00000100" or input = "00000101") else '0';

  reg_we <= '0' when (input = "00000010" or input = "00000100" or input = "00000101") else '1';

  alu_op <= "010" when input = "00010000" else
            "011" when input = "00010001" else
            "100" when input = "00010010" else
            "101" when input = "00010011" else
            "110" when input = "00010100" else
            "001" when input = "00100000" else
            "111" when input = "00100001" else
            "000";
            
  bus_sel <= "10" when input = "00000001" else
             "01" when input = "00000101" else
             "00";

end decode_arq;