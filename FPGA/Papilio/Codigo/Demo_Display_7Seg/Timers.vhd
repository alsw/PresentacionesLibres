library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Timer32 is
	port (ClkIn: in STD_LOGIC;
			ClkOut: out STD_LOGIC;
			Periodo: in STD_LOGIC_VECTOR(31 downto 0));
end Timer32;

architecture Funcionamiento of Timer32 is
	signal CountVal: STD_LOGIC_VECTOR(31 downto 0) := X"00000000";

begin
	process (ClkIn)
	begin
		if rising_edge(ClkIn) then
			if CountVal = Periodo then
				CountVal <= X"00000000";
			else
				CountVal <= CountVal + 1;
			end if;
		end if;
	end process;

	ClkOut <= '1' when CountVal = Periodo else '0';
end Funcionamiento;