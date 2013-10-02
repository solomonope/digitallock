----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:12 11/15/2012 
-- Design Name: 
-- Module Name:    InternalClock - Behavioral 
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

entity InternalClock is
    Port ( CLK : in  STD_LOGIC;
           OCLK : out  STD_LOGIC);
end InternalClock;

architecture Behavioral of InternalClock is
signal count  : std_logic_vector (31 downto 0):=x"00000000";
begin
process (CLK)
begin

if (rising_edge(CLK))
then count <= count + x"00000001";
end if;

end process;

OCLK<=count(15);
end Behavioral;

