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
    port ( clk, rst, we : in  std_logic;
           rd, rs : in  std_logic_vector (3 downto 0);
           din : in  std_logic_vector (7 downto 0);
           dout : out  std_logic_vector (7 downto 0));
end component;

component reg_a 
    port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           we, clk, rst : in  STD_LOGIC);
end component;

component reg_out
    port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           we, clk, rst : in  STD_LOGIC);
end component;

component ir
    port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           we, clk, rst : in  STD_LOGIC);
end component;
          
component alu port ( op: in  std_logic_vector(2 downto 0);
           a, b : in  std_logic_vector (7 downto 0);
           s : out  std_logic_vector (7 downto 0));
end component;

component rom_prog port (addr : in  std_logic_vector (6 downto 0);
					output : out  std_logic_vector (15 downto 0));
end component; 


component decode port (input : in  std_logic_vector (7 downto 0);
					reg_we, out_we, reg_a_we : out std_logic;
					alu_op : out  std_logic_vector (2 downto 0);
					bus_sel : out  std_logic_vector (1 downto 0));
end component; 

component pc port (output : out STD_LOGIC_VECTOR(6 downto 0);
        clk, rst : in  STD_LOGIC);
end component; 
  
-- ======================
-- Declaración de señales :

signal PC_ROM: STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
signal ROM_IR, IR_OUTPUT: std_logic_vector (15 downto 0) := (others => '0');
signal DECO_WE_REGO, DECO_WE_REGS, DECO_WE_REGA: std_logic;
signal DECO_OP_ALU: std_logic_vector (2 downto 0) := (others => '0');
signal DECO_BUS_SEL_MUX: std_logic_vector (1 downto 0) := (others => '0');
signal REGA_ALU, REGO_INPUT, MUX_OUTPUT, REGS_MUX: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

-- ======================

begin

-- Instaciación de componentes utilizados:

-- PC
ePC: pc port map (
output => PC_ROM,
clk => clk,
rst => rst);

-- ROM de programa
eROM_Prog: rom_prog port map (
addr => PC_ROM,
output => ROM_IR);

-- IR
eIR: ir port map (
input => ROM_IR,
output => IR_OUTPUT,
we => '1',
clk => clk,
rst => rst);

-- Banco de registros
eregs:  regs Port map (
clk => clk, 
rst => rst, 
we => DECO_WE_REGS, 
rd => IR_OUTPUT(7 downto 4), 
rs => IR_OUTPUT(3 downto 0), 
din => REGO_INPUT, 
dout => REGS_MUX); 

-- ALU
eAlu: alu port map (op => DECO_OP_ALU, 
					          a => MUX_OUTPUT,
							      b => REGA_ALU,
							      s => REGO_INPUT);

-- Decodificador de la instrucción
eDecode: decode port map (
input => IR_OUTPUT(15 downto 8),
reg_we => DECO_WE_REGS,
out_we => DECO_WE_REGO,
reg_a_we => DECO_WE_REGA,
alu_op => DECO_OP_ALU,
bus_sel => DECO_BUS_SEL_MUX);

-- Registro A
eReg_A: reg_a port map (
input => MUX_OUTPUT,
output => REGA_ALU,
we => DECO_WE_REGA,
clk => clk,
rst => rst);

-- Registro Out
eReg_Out: reg_out port map (
input => REGO_INPUT,
output => output, 
we => DECO_WE_REGO,
clk => clk,
rst => rst);

-- Descripción del mux que funciona como "bus":
-- *controlado por bus_sel

MUX_OUTPUT <= input when DECO_BUS_SEL_MUX = "10" else
              IR_OUTPUT(7 downto 0) when DECO_BUS_SEL_MUX = "01" else
              REGS_MUX;
           
-- ================

-- Descripción de los almacenamientos
-- Los almacenamientos que se deben decribir aca son: 
-- <reg_a> 8 bits
-- <reg_out> de 8 bits
-- <pc> de 8 bits
-- <ir> de 16 bits

end Beh_Proc;