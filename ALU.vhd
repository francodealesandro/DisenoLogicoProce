library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ALU is
    port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           op : in  STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC
          );
end ALU;

architecture alu_arq of ALU is
  
  signal next_state : STD_LOGIC_VECTOR (7 downto 0);
  
begin 
  
  sync: process(clk)
	begin
	  if rst = '1' then
	    S <= (others => '0');
		elsif (rising_edge(clk)) then
			S <= next_state;
		end if;
	end process;

  process (op,A,B)
  begin
    case op is
      when "000" =>
        next_state <= A;
      when "001" =>
        --next_state <= A sll 1;
        next_state <= A(6 downto 0) & '0';
      when "010" =>
        next_state <= A + B;
      when "011" =>
        next_state <= A - B;
      when "100" =>
        next_state <= A and B;
      when "101" =>
        next_state <= A or B;
      when "110" =>
        next_state <= A xor B;
      when "111" =>
        --next_state <= A srl 1;
        next_state <= '0' & A(7 downto 1);
      when others =>
        next_state <= A;
    end case;
  end process; 

end alu_arq;