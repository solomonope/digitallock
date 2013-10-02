----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:41:12 11/15/2012 
-- Design Name: 
-- Module Name:    RandomNumber - Behavioral 
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

entity RandomNumber is
Port ( CLK : in  STD_LOGIC;
		 STATUS: in STD_LOGIC;
		 RNDNB : out  STD_LOGIC_VECTOR(1 downto 0);
       RNDN : out  STD_LOGIC_VECTOR(1 downto 0));
end RandomNumber;

architecture Behavioral of RandomNumber is
begin
process (CLK)
variable RANDONE : std_logic_vector(1 downto 0):="10";
variable RANDBIT : std_logic := '0';
begin

if(rising_edge(clk)) then
RANDBIT := RANDONE(1) xor RANDONE(0);
RANDONE(1) := RANDONE(0);
RANDONE(0) := RANDBIT;
end if;
RNDN <= RANDONE;
RNDNB(0) <=Not RANDONE(0);
RNDNB(1) <=Not RANDONE(1);

end process;
end Behavioral;

