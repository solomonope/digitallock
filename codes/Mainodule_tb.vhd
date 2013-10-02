--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:46:01 12/03/2012
-- Design Name:   
-- Module Name:   Y:/Documents/DesignsHDL/CombinationalLock/Mainodule_tb.vhd
-- Project Name:  CombinationalLock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MainModule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Mainodule_tb IS
END Mainodule_tb;
 
ARCHITECTURE behavior OF Mainodule_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MainModule
    PORT(
         CLK : IN  std_logic;
         SWITCHES : IN  std_logic_vector(7 downto 0);
         BUTTONS : IN  std_logic_vector(3 downto 0);
         digit : OUT  std_logic_vector(3 downto 0);
         LEDS : OUT  std_logic_vector(7 downto 0);
			RdnA:OUT std_logic_vector(1 downto 0);
			RdnB:OUT std_logic_vector(1 downto 0);
         SEVENSEGMENTS : OUT  std_logic_vector(7 downto 0)
			
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal SWITCHES : std_logic_vector(7 downto 0) := (others => '0');
   signal BUTTONS : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal digit : std_logic_vector(3 downto 0);
   signal LEDS : std_logic_vector(7 downto 0);
   signal SEVENSEGMENTS : std_logic_vector(7 downto 0);
	signal RdnA :std_logic_vector(1 downto 0);
	signal RdnB :std_logic_vector(1 downto 0);
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MainModule PORT MAP (
          CLK => CLK,
          SWITCHES => SWITCHES,
          BUTTONS => BUTTONS,
          digit => digit,
          LEDS => LEDS,
			 RdnA =>RdnA,
			 RdnB =>RdnB,
          SEVENSEGMENTS => SEVENSEGMENTS
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
--valid sequence	
	BUTTONS(1) <= '1';   
        wait for 20 ns;
        BUTTONS(1) <= '0';   
        wait for 80 ns;
       
        SWITCHES <="00000001";
        wait for 80 ns;
        BUTTONS(1) <= '1';   
        wait for 20 ns;
        BUTTONS(1) <= '0';   
        wait for 80 ns;
       
        SWITCHES <="00000010";
        wait for 80 ns;
        BUTTONS(1) <= '1';   
        wait for 20 ns;
        BUTTONS(1) <= '0';   
        wait for 80 ns;
       
        SWITCHES <="00000100";
        wait for 80 ns;
        BUTTONS(1) <= '1';   
        wait for 20 ns;
        BUTTONS(1) <= '0';   
        wait for 80 ns;
       
        BUTTONS(1) <= '1';   
        wait for 20 ns;
        BUTTONS(1) <= '0';
       
        wait for 100 ns;
      ---Invalid Sequence
		wait for 50 ns;
		BUTTONS(0) <= '1';	
		wait for 10 ns;
		BUTTONS(0) <= '0';
		
		wait for 100 ns;
		
		SWITCHES <="00000001";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
		SWITCHES <="00000001";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
		SWITCHES <="00000001";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
		SWITCHES <="00000001";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';
		
		
		
		---Invalid Random Number
		wait for 50 ns;
		BUTTONS(0) <= '1';	
		wait for 10 ns;
		BUTTONS(0) <= '0';
		
		wait for 100 ns;
		
		BUTTONS(2) <= '1';	
		wait for 20 ns;
		BUTTONS(2) <= '0';	
		wait for 80 ns;
		
		SWITCHES <="00000000";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
		
		
		SWITCHES <="00000100";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
	---valid random number	
		
		wait for 50 ns;
		BUTTONS(0) <= '1';	
		wait for 10 ns;
		BUTTONS(0) <= '0';
		
		wait for 100 ns;
		
		BUTTONS(2) <= '1';	
		wait for 20 ns;
		BUTTONS(2) <= '0';	
		wait for 80 ns;
		
		CASE RdnA IS
		WHEN  "00"  => 
		SWITCHES <="00000000";
	
		WHEN  "01"  =>  
		SWITCHES <="00000001";	
		
		WHEN  "10"  =>
		SWITCHES <="00000010";
		WHEN  "11"  => 
		SWITCHES <="00000100";
		WHEN OTHERS => SWITCHES <="00000000";
		END CASE;
		
		SWITCHES <="00000000";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
		
		
		
		CASE RdnB IS
		WHEN  "00"  => 
		SWITCHES <="00000000";
	
		WHEN  "01"  =>  
		SWITCHES <="00000001";	
		
		WHEN  "10"  =>
		SWITCHES <="00000010";
		WHEN  "11"  => 
		SWITCHES <="00000100";
		WHEN OTHERS => SWITCHES <="00000000";
		END CASE;
		
		SWITCHES <="00000000";
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';
		wait for 80 ns;
		BUTTONS(1) <= '1';	
		wait for 20 ns;
		BUTTONS(1) <= '0';	
		wait for 80 ns;
   end process;

END;
