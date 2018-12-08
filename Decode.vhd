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
  signal out_we_next : STD_LOGIC;
  signal reg_we_next : STD_LOGIC;
  signal reg_a_we_next : STD_LOGIC;
  signal alu_op_next : STD_LOGIC_VECTOR (2 downto 0);
  signal bus_sel_next : STD_LOGIC_VECTOR (1 downto 0);
begin 

bus_sel_next <= "00" when rst = '1' else
           bus_sel_next when (rising_edge(clk)) else
           "10" when input = x"01" else
           "01" when input = x"05" else
           "00";
 
bus_sel <= bus_sel_next;
            
reg_a_we_next <= '0' when rst = '1' else
                 reg_a_we_next when (rising_edge(clk)) else
                 '1' when input = x"04" 
                       or input = x"05" else '0';

reg_a_we <= reg_a_we_next;

out_we_next <= '0' when rst = '1' else
               out_we_next when (rising_edge(clk)) else
               '1' when input = x"02" else '0';
          
out_we <= out_we_next;

reg_a_we_next <= '0' when rst = '1' else
                 reg_a_we_next when (rising_edge(clk)) else
                 '0' when input = x"02" 
                     or input = x"04" 
                     or input = x"05" else '1';
                  
reg_a_we <= reg_a_we_next;

alu_op_next <= "000" when rst = '1' else
                alu_op_next when (rising_edge(clk)) else
                "010" when input = x"10" else
                "011" when input = x"11" else
                "100" when input = x"12" else
                "101" when input = x"13" else
                "110" when input = x"14" else
                "001" when input = x"20" else
                "111" when input = x"21" else
                "000";
                
alu_op <= alu_op_next;

end decode_arq;