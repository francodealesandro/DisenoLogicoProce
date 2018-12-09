library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity regs is
    port ( regs_clk : in  STD_LOGIC;
           regs_rst : in  STD_LOGIC;
           regs_we : in  STD_LOGIC;
           regs_rd : in  STD_LOGIC_VECTOR (3 downto 0);
           regs_rs : in  STD_LOGIC_VECTOR (3 downto 0);
           regs_din : in  STD_LOGIC_VECTOR (7 downto 0);
           regs_dout : out  STD_LOGIC_VECTOR (7 downto 0) := (others => '0'));
end regs;

architecture registers_table_arq of regs is

  constant reg_tam : INTEGER := 16;
  type mem is array(reg_tam-1 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
  signal reg: mem := (others => (others => '0'));
  
begin 

  sync: process (regs_clk, regs_rst)
  begin
    if regs_rst= '1' then
      for i in 0 to reg_tam-1 loop
        reg(i) <= (others => '0');
      end loop; 
    elsif (rising_edge(regs_clk)) then
      if (regs_we = '1') then
        reg(conv_integer(regs_rd)) <= regs_din;
      end if;
    end if; 
  end process; 

regs_dout <= reg(conv_integer(regs_rs)); 

end registers_table_arq;