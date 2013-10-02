----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:38:24 11/15/2012 
-- Design Name: 
-- Module Name:    MessageMultiplexer - Behavioral 
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

entity MessageMultiplexer is
    Port ( MA : in  STD_LOGIC_VECTOR (15 downto 0);
           MB : in  STD_LOGIC_VECTOR (15 downto 0);
           MC : out  STD_LOGIC_VECTOR (15 downto 0);
           CLK : in  STD_LOGIC;
			  START: in STD_LOGIC
			  );
end MessageMultiplexer;

architecture Behavioral of MessageMultiplexer is
signal count  : std_logic_vector (31 downto 0):=x"00000000";
signal control: std_logic;
begin
process (CLK)
begin

if (rising_edge(CLK))
then count <= count + x"00000001";
end if;

end process;
control<=count(26);
MC <= MA when control ='0' and START ='1' else
		MB  when control= '1' and START='1' else
		MA;
end Behavioral;

