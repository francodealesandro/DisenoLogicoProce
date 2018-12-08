----------------------------------------------------------------------------------
-- Realizado por la catedra  Diseño Lógico (UNTREF) en 2015
-- Tiene como objeto brindarle a los alumnos un template del procesador requerido
-- Profesores Martín Vázquez - Lucas Leiva
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Proc is
    port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end Proc;

architecture Beh_Proc of Proc is

-- ================
-- Declaración de los componentes utilziados

component regs 
    port ( regs_clk, regs_rst, regs_we : in  std_logic;
           regs_rd, regs_rs : in  std_logic_vector (3 downto 0);
           regs_din : in  std_logic_vector (7 downto 0);
           regs_dout : out  std_logic_vector (7 downto 0));
end component;

component reg_a 
    port ( reg_a_input : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_a_output : out  STD_LOGIC_VECTOR (7 downto 0);
           reg_a_we, reg_a_clk, reg_a_rst : in  STD_LOGIC);
end component;

component reg_out
    port ( reg_out_input : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_out_output : out  STD_LOGIC_VECTOR (7 downto 0);
           reg_out_we, reg_out_clk, reg_out_rst : in  STD_LOGIC);
end component;

component ir
    port ( ir_input : in  STD_LOGIC_VECTOR (15 downto 0);
           ir_output : out  STD_LOGIC_VECTOR (15 downto 0);
           ir_we, ir_clk, ir_rst : in  STD_LOGIC);
end component;
          
component alu port ( alu_op: in  std_logic_vector(2 downto 0);
           alu_a, alu_b : in  std_logic_vector (7 downto 0);
           alu_s : out  std_logic_vector (7 downto 0);
           alu_clk, alu_rst : in  std_logic);
end component;

component rom_prog port (rom_prog_addr : in  std_logic_vector (6 downto 0);
					rom_prog_output : out  std_logic_vector (15 downto 0);
          rom_prog_clk, rom_prog_rst : in  std_logic);
end component; 


component decode port (decode_input : in  std_logic_vector (7 downto 0);
					decode_reg_we, decode_out_we, decode_reg_a_we : out  std_logic;
					decode_alu_op : out  std_logic_vector (2 downto 0);
					decode_bus_sel : out  std_logic_vector (1 downto 0));
end component; 

component pc port (pc_output : out STD_LOGIC_VECTOR(6 downto 0);
        pc_clk, pc_rst : in  STD_LOGIC);
end component; 
  
  
-- ======================


-- Declaración de señales :
-- *colocadas (la mayoría) en orden de salida de los componentes

-- PC
signal sig_pc_output: STD_LOGIC_VECTOR(6 downto 0);

-- ROM de programa
signal sig_rom_prog_output: std_logic_vector (15 downto 0);

-- IR
signal sig_ir_output: std_logic_vector (15 downto 0);
signal sig_ir_we: std_logic;

-- Decode
signal sig_decode_out_we, sig_decode_reg_we, sig_decode_reg_a_we: std_logic;
signal sig_decode_alu_op: std_logic_vector (2 downto 0);
signal sig_decode_bus_sel: std_logic_vector (1 downto 0);

-- Registro A
signal sig_reg_a_output: STD_LOGIC_VECTOR (7 downto 0);

-- Registro out
signal sig_reg_out_input, sig_reg_out_output: STD_LOGIC_VECTOR (7 downto 0);

-- Mux
signal sig_mux_out: STD_LOGIC_VECTOR (7 downto 0);


-- ======================


begin

-- Instaciación de componentes utilizados:

-- PC
ePC: pc port map (
pc_output => sig_pc_output,
pc_clk => clk,
pc_rst => rst);

-- ROM de programa
eROM_Prog: rom_prog port map (rom_prog_addr => sig_pc_output,
rom_prog_output => sig_rom_prog_output,
rom_prog_clk => clk,
rom_prog_rst => rst);

-- IR
eIR: ir port map (ir_input => sig_rom_prog_output,
ir_output => sig_ir_output,
ir_we => sig_ir_we,
ir_clk => clk,
ir_rst => rst);

-- Banco de registros
eregs:  regs Port map (regs_clk => clk, 
regs_rst => rst, 
regs_we => sig_decode_reg_we, 
								regs_rd => sig_ir_output(3 downto 0), 
								regs_rs => sig_ir_output(7 downto 4), 
								regs_din => sig_reg_out_input, 
								regs_dout => sig_mux_out); 
-- ALU
eAlu: alu port map (alu_op => sig_decode_alu_op, 
					          alu_a => sig_mux_out,
							      alu_b => sig_reg_a_output,
							      alu_s => sig_reg_out_input,
							      alu_clk => clk,
							      alu_rst => rst);

-- Decodificador de la instrucción
eDecode: decode port map (decode_input => sig_ir_output(15 downto 8),
decode_reg_we => sig_decode_reg_we,
decode_out_we => sig_decode_out_we,
decode_reg_a_we => sig_decode_reg_a_we,
decode_alu_op => sig_decode_alu_op,
decode_bus_sel => sig_decode_bus_sel);

-- Registro A
eReg_A: reg_a port map (reg_a_input => sig_mux_out,
reg_a_output => sig_reg_a_output,
reg_a_we => sig_decode_reg_a_we,
reg_a_clk => clk,
reg_a_rst => rst);

-- Registro Out
eReg_Out: reg_out port map (reg_out_input => sig_reg_out_input,
reg_out_output => output,
reg_out_we => sig_decode_out_we,
reg_out_clk => clk,
reg_out_rst => rst);

-- Descripción del mux que funciona como "bus":
-- *controlado por bus_sel

sig_mux_out <= input when sig_decode_bus_sel = "10" else
           sig_ir_output(7 downto 0) when sig_decode_bus_sel = "01" else
           sig_mux_out;
           
           
-- ================


-- Descripción de los almacenamientos
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

end Beh_Proc;
