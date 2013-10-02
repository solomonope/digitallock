----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:36:08 11/14/2012 
-- Design Name: 
-- Module Name:    DisplayMultiplexer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DisplayMultiplexer is
port(
NA:in std_logic_vector(15 downto 0);
digitM : out  STD_LOGIC_VECTOR (3 downto 0);
DV: out std_logic_vector(3 downto 0);
clkM: in std_logic
);
attribute LOC:string;
end DisplayMultiplexer;

architecture Behavioral of DisplayMultiplexer is
signal count  : std_logic_vector (31 downto 0):=x"00000000";
signal control :std_logic_vector(1 downto 0) :="00";
begin
process (clkM)
begin

if (rising_edge(clkM))
then count <= count + x"00000001";
end if;

end process;

control<=count(10 downto 9);

DV <= NA(3 downto 0) when control="00" 
		else NA(7 downto 4)  when control="01" 
		else NA(11 downto 8) when control="10"
		else NA(15 downto 12) ;
		
digitM <= "0111" when control="00"
			ELSE "1011" when control="01"
			ELSE "1101" when control="10"
			ELSE "1110";
end Behavioral;

