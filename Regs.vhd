library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity regs is
    port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           rd : in  STD_LOGIC_VECTOR (3 downto 0);
           rs : in  STD_LOGIC_VECTOR (3 downto 0);
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end regs;

architecture registers_table_arq of regs is

  constant reg_tam : INTEGER := 16;
  type mem is array(reg_tam-1 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
  signal reg: mem := (others => (others => '0'));
  
begin 

  sync: process (clk, rst)
  begin
    if rst= '1' then
      for i in 0 to reg_tam-1 loop
        reg(i) <= (others => '0');
      end loop; 
    elsif (rising_edge(clk)) then
      if (we = '1') then
        reg(conv_integer(rd)) <= din;
      end if;
    end if; 
  end process; 

dout <= reg(conv_integer(rs)); 

end registers_table_arq;