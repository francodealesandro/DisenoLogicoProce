----------------------------------------------------------------------------------
-- Realizado por la catedra  Dise�o L�gico (UNTREF) en 2015
-- Tiene como objeto brindarle a los alumnos un template del procesador requerido
-- Profesores Mart�n V�zquez - Lucas Leiva
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Proc is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end Proc;

architecture Beh_Proc of Proc is

-- ================
-- Declaraci�n de los componentes utilziados

component regs 
    Port ( regs_clk, regs_rst, regs_we : in  std_logic;
           regs_rd, regs_rs : in  std_logic_vector (3 downto 0);
           regs_din : in  std_logic_vector (7 downto 0);
           regs_dout : out  std_logic_vector (7 downto 0));
end component;

component reg_a 
    Port ( reg_a_input : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_a_output : out  STD_LOGIC_VECTOR (7 downto 0);
           reg_a_we, reg_a_clk, reg_a_rst : in  STD_LOGIC);
end component;

component reg_out
    Port ( reg_out_input : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_out_output : out  STD_LOGIC_VECTOR (7 downto 0);
           reg_out_we, reg_out_clk, reg_out_rst : in  STD_LOGIC);
end component;

component ir
    Port ( ir_input : in  STD_LOGIC_VECTOR (15 downto 0);
           ir_output : out  STD_LOGIC_VECTOR (15 downto 0);
           ir_we, ir_clk, ir_rst : in  STD_LOGIC);
end component;
          
component alu port ( alu_op: in  std_logic_vector(3 downto 0);
           alu_a, alu_b : in  std_logic_vector (7 downto 0);
           alu_s : out  std_logic_vector (7 downto 0);
           alu_clk, alu_rst : in  std_logic);
end component;

component rom_prog port (rom_prog_addr : in  std_logic_vector (6 downto 0);
					rom_prog_output : out  std_logic_vector (15 downto 0);
          rom_prog_clk, rom_prog_rst : in  std_logic);
end component; 


component decode port (decode_input : in  std_logic_vector (8 downto 0);
					decode_reg_we, decode_out_we, decode_reg_a_we : out  std_logic;
					decode_alu_op : out  std_logic_vector (2 downto 0);
					decode_bus_sel : out  std_logic_vector (1 downto 0));
end component; 

component pc port (pc_output : out STD_LOGIC_VECTOR(6 downto 0);
        pc_clk, pc_rst : in  STD_LOGIC);
end component; 
  

-- ================

-- ================
-- declaraci�n de se�ales usadas 

-- Banco de registros
signal we: std_logic; -- senal para escribir en el banco de registro 
signal rd, rs: std_logic_vector(3 downto 0);
signal pre_out, mux_out: std_logic_vector(7 downto 0);
-- signal ....

-- ================

begin

-- ================
-- Instaciacion de componentes utilziados

-- PC
ePC: pc port map (pc_clk => clk,
pc_rst => rst);

-- La ROM de programa
eROM_Prog: rom_prog port map (rom_prog_addr => pc_output,
rom_prog_output => ir_input,
rom_prog_clk => clk,
rom_prog_rst => rst);

-- IR
eIR: ir port map (ir_input,
ir_output,
ir_we => we,
ir_clk => clk,
ir_rst => rst);

-- Banco de registros
eregs:  regs Port map (regs_clk => clk, 
regs_rst => rst, 
regs_we => decode_reg_we, 
								regs_rd => ir_output(3 downto 0), 
								regs_rs => ir_output(7 downto 4), 
								regs_din => pre_out, 
								regs_dout => mux_out); 
-- La ALU
eAlu: alu port map (alu_op => decode_alu_op, 
					          alu_a => mux_out,
							      alu_b =>,
							      alu_s => pre_out,
							      alu_clk => clk,
							      alu_rst => rst);

-- El decodificador de la instrucci�n
eDecode: decode port map (decode_input => ir_output(15 downto 8),
decode_reg_we => regs_we,
decode_out_we => reg_out_we,
decode_reg_a_we => reg_a_we,
decode_alu_op => alu_op,
decode_bus_sel);

-- Registro A
eReg_A: reg_a Port map (reg_a_input => mux_out,
reg_a_output => alu_b,
reg_a_we,
reg_a_clk => clk,
reg_a_rst => rst);

-- Registro Out
eReg_Out: reg_out Port map (reg_a_input => pre_out,
reg_out_output => output,
reg_out_we,
reg_out_clk => clk,
reg_out_rst => rst);

-- ================


-- ================
-- Descripci�n de mux que funciona como "bus"
-- controlado por bus_sel
mux_out <= input when decode_bus_sel = "10" else
           ir_output when decode_bus_sel = "01" else
           reg_dout;
-- ================


-- ================
-- Descripci�n de los almacenamientos
-- Los almacenamientos que se deben decribir aca son: 
-- <reg_a> 8 bits
-- <reg_out> de 8 bits
-- <pc> de 8 bits
-- <ir> de 16 bits

	process (clk, rst)
	
	begin
	     if (rst='1') then 
		  
		  elsif (rising_edge(clk)) then
		  
		  end if;
		  
	end process;
-- ================


end Beh_Proc;

