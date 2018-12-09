library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity decode is
    port ( decode_input : in STD_LOGIC_VECTOR (7 downto 0);
           decode_out_we : out  STD_LOGIC;
           decode_reg_we : out  STD_LOGIC;
           decode_reg_a_we : out  STD_LOGIC;
           decode_alu_op : out  STD_LOGIC_VECTOR (2 downto 0);
           decode_bus_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           decode_clk : in  STD_LOGIC;
           decode_rst : in  STD_LOGIC);
end decode;

architecture decode_arq of decode is
  
begin
  
  sync: process (decode_clk,decode_rst)
    begin
		if decode_rst= '1' then
			decode_bus_sel <= "00";
			decode_reg_a_we <= '0';
			decode_reg_we <= '0';
			decode_out_we <= '0';
			decode_alu_op <= "000";
		elsif rising_edge(decode_clk) then
			if (decode_input = "00000010") then
				decode_out_we <= '1';
			else
				decode_out_we <= '0';
			end if;
		  
			if (decode_input = "00000100" or decode_input = "00000101") then
				decode_reg_a_we <= '1';
			else
				decode_reg_a_we <= '0';
			end if;
			
			if (decode_input = "00000010" or decode_input = "00000100" or decode_input = "00000101") then
				decode_reg_we <= '0';
			else
				decode_reg_we <= '1';
			end if;
			
			case decode_input is
				when "00010000" =>
					decode_alu_op <= "010";
				when "00010001" =>
					decode_alu_op <= "011";
				when "00010010" =>
					decode_alu_op <= "100";
				when "00010011" =>
					decode_alu_op <= "101";
				when "00010100" =>
					decode_alu_op <= "110";
				when "00100000" =>
					decode_alu_op <= "001";
				when "00100001" =>
					decode_alu_op <= "111";
				when others =>
					decode_alu_op <= "000";
			end case;
				
			case decode_input is
				when "00000001" =>
					decode_bus_sel <= "10";
				when "00000101" =>
					decode_bus_sel <= "01";
				when others =>
					decode_bus_sel <= "00";
			end case;
		
      end if; 
  end process; 

end decode_arq;