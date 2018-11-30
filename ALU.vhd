
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           op : in  STD_LOGIC_VECTOR (2 downto 0));
end ALU;

architecture alu_arq of ALU is

begin 

  process (op,A,B)
  begin
    case op is
      when "000" =>
        S <= A;
      when "001" =>
        S <= A(6 downto 0) & A(7);
      when "010" =>
        S <= A + B;
      when "011" =>
        S <= A - B;
      when "100" =>
        S <= A AND B;
      when "101" =>
        S <= A OR B;
      when "110" =>
        S <= A XOR B;
      when "111" =>
        S <= A(0) & A(7 downto 1);
      when others =>
        S <= A;
    end case;
  end process; 

end alu_arq;



