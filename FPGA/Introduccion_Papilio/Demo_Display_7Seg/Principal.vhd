library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Principal is
   Port (clk:       in   STD_LOGIC;
         botones:     in   STD_LOGIC_VECTOR (1 downto 0);
         anodos:    out  STD_LOGIC_VECTOR (1 downto 0);
         segmentos: out  STD_LOGIC_VECTOR (6 downto 0));
end Principal;

architecture Comportamiento of Principal is
   component DriverDisplay7Seg
      port (ClkIn: in STD_LOGIC;
				ClkEn: in STD_LOGIC;
				DatDig0: in STD_LOGIC_VECTOR (3 downto 0);
				DatDig1: in STD_LOGIC_VECTOR (3 downto 0);
				SalSeg: out STD_LOGIC_VECTOR (6 downto 0);
				SalAC: out STD_LOGIC_VECTOR (1 downto 0));
	end component;

   component Timer32
      port (ClkIn: in STD_LOGIC;
            ClkOut: out STD_LOGIC;
            Periodo: in STD_LOGIC_VECTOR(31 downto 0));
   end component;

   signal SalidaTimer: STD_LOGIC;
   signal BotonAnt: STD_LOGIC_VECTOR(1 downto 0);
   signal BotonAct: STD_LOGIC_VECTOR(1 downto 0);
   signal Conteo: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
   DriverDisplay: DriverDisplay7Seg
	port map (clk, SalidaTimer, conteo(3 downto 0), Conteo(7 downto 4),
             segmentos, anodos);

   Timer: Timer32
   port map (clk, SalidaTimer, std_logic_vector(to_unsigned(320000, 32)));

   BotonAct <= botones when rising_edge(clk) and SalidaTimer = '1' else BotonAct;
   BotonAnt <= BotonAct when rising_edge(clk) and SalidaTimer = '1' else BotonAnt;

   process (clk) begin
      if rising_edge(clk) and SalidaTimer = '1' then
         if BotonAct(0) = '0' and BotonAnt(0) = '1' then
            Conteo <= Conteo + 1;
         elsif BotonAct(1) = '0' and BotonAnt(1) = '1' then
            Conteo <= Conteo - 1;
         end if;
      end if;
   end process;
end Comportamiento;

-------------------------------
-- Entidad DriverDisplay7Seg --
-------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DriverDisplay7Seg is
	port (ClkIn:    in STD_LOGIC;
			ClkEn:    in STD_LOGIC;
			DatDig0:  in STD_LOGIC_VECTOR (3 downto 0); --Dato HEX que entra aldigito 0
			DatDig1:  in STD_LOGIC_VECTOR (3 downto 0); --Dato HEX que entra aldigito 1
			SalSeg:  out STD_LOGIC_VECTOR (6 downto 0); --Salidas de segmentos A-G
			SalAC:   out STD_LOGIC_VECTOR (1 downto 0)); --Salidas de anodo comun
end DriverDisplay7Seg;

architecture Funcionamiento of DriverDisplay7Seg is
	signal NumDigAct: STD_LOGIC := '0'; --Numero/conteo de digito actual
	signal DatDigAct: STD_LOGIC_VECTOR(3 downto 0); --Dato del digito actual

begin
	--Hace que el digito actual mostrado sea rotado con cada flanco de reloj:
	NumDigAct <= not NumDigAct when rising_edge(ClkIn) and ClkEn = '1' else NumDigAct;

	--Se activa el anodo del display que corresponde al digito actual:
	SalAC <= "01" when NumDigAct = '0' else "10";

	--Se selecciona el dato del digito actual (MUX):
	DatDigAct <= DatDig0 when NumDigAct = '0' else DatDig1;

	--Se envia a la salida la configuracion de segmentos A-G y Dp:
	--Orden:  GFEDCBA
	SalSeg <= "1000000" when DatDigAct = X"0" else
				 "1111001" when DatDigAct = X"1" else
				 "0100100" when DatDigAct = X"2" else
				 "0110000" when DatDigAct = X"3" else
				 "0011001" when DatDigAct = X"4" else
				 "0010010" when DatDigAct = X"5" else
				 "0000010" when DatDigAct = X"6" else
				 "1111000" when DatDigAct = X"7" else
				 "0000000" when DatDigAct = X"8" else
				 "0010000" when DatDigAct = X"9" else
				 "0001000" when DatDigAct = X"A" else
				 "0000011" when DatDigAct = X"B" else
				 "1000110" when DatDigAct = X"C" else
				 "0100001" when DatDigAct = X"D" else
				 "0000110" when DatDigAct = X"E" else
				 "0001110";
end Funcionamiento;