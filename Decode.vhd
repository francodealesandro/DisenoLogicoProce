library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity decode is
    port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           out_we : out  STD_LOGIC;
           reg_we : out  STD_LOGIC;
           reg_a_we : out  STD_LOGIC;
           alu_op : out  STD_LOGIC_VECTOR (2 downto 0);
           bus_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end decode;

architecture decode_arq of decode is
  
begin
  
  process (clk,rst)
    begin
		if rst= '1' then
			bus_sel <= "00";
			reg_a_we <= '0';
			reg_we <= '0';
			out_we <= '0';
			alu_op <= "000";
		elsif rising_edge(clk) then
			if (input = "00000010") then
				out_we <= '1';
			else
				out_we <= '0';
			end if;
		  
			if (input = "00000100" or input = "00000101") then
				reg_a_we <= '1';
			else
				reg_a_we <= '0';
			end if;
			
			if (input = "00000010" or input = "00000100" or input = "00000101") then
				reg_we <= '0';
			else
				reg_we <= '1';
			end if;
			
			case input is
				when "00010000" =>
					alu_op <= "010";
				when "00010001" =>
					alu_op <= "011";
				when "00010010" =>
					alu_op <= "100";
				when "00010011" =>
					alu_op <= "101";
				when "00010100" =>
					alu_op <= "110";
				when "00100000" =>
					alu_op <= "001";
				when "00100001" =>
					alu_op <= "111";
				when others =>
					alu_op <= "000";
			end case;
				
			case input is
				when "00000001" =>
					bus_sel <= "10";
				when "00000101" =>
					bus_sel <= "01";
				when others =>
					bus_sel <= "00";
			end case;
		
      end if; 
  end process; 

end decode_arq;