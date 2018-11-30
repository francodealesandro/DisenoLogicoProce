-- semaforo.vhd
-- Maquina de estados (FSM)para controlar semáforo simple
-- Lucas Leiva y Martín Vázquez. UNCPBA


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity semaforo is
	 port (
	 	clk: in std_logic;
	 	rst: in std_logic;
	 	s1,s2 : out std_logic_vector(2 downto 0)
	-- rojo en posición sx(2)
	-- amarillo en 1 sx(1)
	-- verde en 1 sx(0)	
	 );
end semaforo;


-- esta arquitectura es una máquina de Moore
-- con salidas combinacionales decodificadas a partir de los estados
architecture Moore_ocomb of semaforo is

	type state_type is (VR, AR, RV, RA); 

   constant delay: std_logic_vector(2 downto 0):= "111";
   
   signal state, next_state : state_type;
	signal count, next_count: std_logic_vector(2 downto 0);
	signal rst_count: std_logic;

begin

	sync: process(clk,rst)
	begin
		if rst = '1' then
			state <= VR;
			count <= (others => '0');
		elsif (rising_edge(clk)) then
			state <= next_state;
			count <= next_count;
		end if;
	end process;
	

   comb: process(count,state)
	begin

		rst_count <= '0';
      next_state <= state;		

		case (state)is

			when  VR => 
				if count = delay then
					next_state <= AR;
					rst_count <= '1';
				end if;

			when  AR => 
				next_state <= RV;
				rst_count <= '1';

			when  RV => 
				if count = delay then
					next_state <= RA;
					rst_count <= '1';
				end if;

			when  RA => 
				next_state <= VR;
				rst_count <= '1';

			when others =>
				next_state <= VR;
				rst_count <= '1';
		end case;				
	end process;

	next_count <= (others => '0') when rst_count = '1' else
						count + 1;		
 --outputs	


	s1(2) <= '1' when (state = RV) or  (state = RA) else '0';
	-- correspondiente a rojo semaforo 1
	s1(1) <= '1' when (state = AR)  else '0';
	-- correspondiente a amarillo semaforo 1
	s1(0) <= '1' when (state = VR)  else '0';
	-- correspondiente a verde semaforo 1

	s2(2) <= '1' when (state = VR) or  (state = AR) else '0';
	-- correspondiente a rojo semaforo 2
	s2(1) <= '1' when (state = RA)  else '0';
	-- correspondiente a amarillo semaforo 2
	s2(0) <= '1' when (state = RV)  else '0';
	-- correspondiente a verde semaforo 2
	
end Moore_ocomb;


-- esta arquitectura es una máquina de Moore
-- con salidas registradas decodificadas a partir de los estados
architecture Moore_oreg of semaforo is
	
	type state_type is (VR,AR,RV, RA); 
   constant delay: std_logic_vector(2 downto 0):= "111";
   signal state : state_type;
	signal count: std_logic_vector(2 downto 0);


begin

	sync: process(clk,rst)
	begin
		if rst = '1' then
			state <= VR;
			count <= (others => '0');
			s1 <= "001";
			s2 <= "100";

		elsif (rising_edge(clk)) then

         count <= count +1 ;
         
			case (state)is
				when  VR => 
					if count = delay then
						s1 <= "010";
                  s2 <= "100";
						state <= AR;
					   count <= (others => '0');	
					end if;

				when  AR => 
					
					s1 <= "100";
               s2 <= "001";
		         state <= RV;
					count <= (others => '0');	

				when  RV => 
					if count = delay then
	            			s1 <= "100";
                  s2 <= "010";
						state <= RA;
						count <= (others => '0');	
					end if;

				when  RA => 
	            s1 <= "001";
               s2 <= "100";
					state <= VR;
					count <= (others => '0');	

				when others =>
	            s1 <= "001";
               s2 <= "100";
					state <= VR;
					count <= (others => '0');	
			end case;				
		end if;
	end process;

end Moore_oreg;



-- esta arquitectura es una máquina de Mealy
architecture Mealy of semaforo is

   type state_type is (VR,RV); 
   signal state : state_type;
	signal count: std_logic_vector(3 downto 0);
	
	signal f: std_logic; 
	
begin


	sync: process(clk,rst)
	begin

		if rst = '1' then
			state <= VR;
			count <= "0001";
			
		elsif (rising_edge(clk)) then
         
         count <= count + 1;
         
			case (state)is
				when  VR => 
					if count = "1000" then
						state <= RV;
						count <= (others => '0');
					end if;
					
				when  RV => 
					if count = "1000" then
						state <= VR;
						count <= (others => '0');
					end if;

				when others =>
					state <= VR;
					count <= (others => '0');
			end case;				
		end if;
	end process;

   f <= '1' when count="0000" else '0';

   s1(2)<= '1' when ((state=RV) and (f='0')) or
                    ((state=VR) and (f='1'))else '0';
   -- correspondiente al rojo de semaforo 1;
   s1(1)<= '1' when (state=RV) and (f='1') else '0';
   -- correspondiente al amarillo de semaforo 1;
   s1(0)<= '1' when (state=VR) and (f='0') else '0';
   -- correspondiente al verde de semaforo 1;

   s2(2)<= '1' when ((state=VR) and (f='0')) or 
                    ((state=RV) and (f='1')) else '0';
   -- correspondiente al rojo de semaforo 2;
   s2(1)<= '1' when (state=VR) and (f='1') else '0';
   -- correspondiente al amarillo de semaforo 2;
   s2(0)<= '1' when (state=RV) and (f='0') else '0';
   -- correspondiente al verde de semaforo 2;
   
end Mealy;



