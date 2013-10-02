----------------------------------------------------------------------------------
-- Company: University of Birmingham
-- Engineer:Folorunsho Solomon Opeyemi
-- 
-- Create Date:    11:38:26 11/08/2012 
-- Design Name:	Combinational Lock	 
-- Module Name:    MainModule - Behavioral 
-- Project Name: 	Advanced Digital design
-- Target Devices: Spartan
-- Tool versions: 
-- Description: 
--
-- Dependencies: Display
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

entity MainModule is
port(
CLK				: in	STD_LOGIC;
SWITCHES			: in  STD_LOGIC_VECTOR (7 downto 0);
BUTTONS 			: in  STD_LOGIC_VECTOR (3 downto 0);
digit    		: out  STD_LOGIC_VECTOR (3 downto 0);		
LEDS      		: out  STD_LOGIC_VECTOR (7 downto 0);
SEVENSEGMENTS	: out std_logic_vector(7 downto 0)
);
			attribute LOC : string ;
         attribute LOC of CLK : signal is "T9";
         attribute LOC of SWITCHES : signal is "K13,K14,J13,J14,H13,H14,G12,F12";
         attribute LOC of BUTTONS : signal is "L14,L13,M14,M13";
         attribute LOC of LEDS : signal is "P11,P12,N12,P13,N14,L12,P14,K12";
         attribute LOC of digit : signal is "E13,F14,G14,D14";
         attribute LOC of SEVENSEGMENTS : signal is "P16,N16,F13,R16,P15,N15,G13,E14";
end MainModule;

architecture Behavioral of MainModule is

type LockState is (init,Key_0,Key_1,Key_2,Key_3,Key_4,GFRN,RFRN,GSRN,RSRN,VERN,Validate,ValidationSuccess,ValidationFailed);
signal presentstate :LockState:=init;
signal enterednumber : std_logic_vector(7 downto 0):="11111111";
signal fourbit :std_logic_vector(3 downto 0);
signal LargeNumber:std_logic_vector(15 downto 0):="0000000000000000";
signal BtnOneHistory:std_logic;
signal BtnTwoHistory:std_logic;
signal MyClk:std_logic;
signal Message: std_logic_vector(15 downto 0) :="0000000000000000";
signal MessageM: std_logic_vector(15 downto 0) :="0000000000000000";
signal START: std_logic:='0';
signal RNDN :std_logic_vector(1 downto 0);
signal RNDNB :std_logic_vector(1 downto 0);
signal FirstRandNo :std_logic_vector(1 downto 0);
signal SecondRandNo :std_logic_vector(1 downto 0);
COMPONENT Display
	PORT(
		number : IN std_logic_vector(3 downto 0);          
		segs : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DisplayMultiplexer
	PORT(
		NA:in std_logic_vector(15 downto 0);
		digitM : out  STD_LOGIC_VECTOR (3 downto 0);
		DV: out std_logic_vector(3 downto 0);
		clkM: in std_logic
		);
	END COMPONENT;
	
	COMPONENT InternalClock
	
		Port 
		( 
			 CLK : in  STD_LOGIC;
           OCLK : out  STD_LOGIC
			  );
	
	END COMPONENT;
	
	COMPONENT MessageMultiplexer
	
		Port ( MA : in  STD_LOGIC_VECTOR (15 downto 0);
           MB : in  STD_LOGIC_VECTOR (15 downto 0);
           MC : out  STD_LOGIC_VECTOR (15 downto 0);
           CLK : in  STD_LOGIC;
			  START: in STD_LOGIC
			  );
	
	END COMPONENT;
	
	COMPONENT RandomNumber
	
		Port ( 
		CLK : 	in  STD_LOGIC;
		RNDNB : out  STD_LOGIC_VECTOR(1 downto 0);
      RNDN : 	out  STD_LOGIC_VECTOR(1 downto 0));
	
	END COMPONENT;
begin

		  
process(CLK,BUTTONS(0))
variable IsFRNV : std_logic;
variable IsSRNV : std_logic;
begin
if(BUTTONS(0) = '1') then
--reset
presentstate <= init;
LargeNumber<="0000000000000000";
START <= '0';
elsif (rising_edge(MyClk)) then

BtnOneHistory <=BUTTONS(1);
BtnTwoHistory <=BUTTONS(2);
case presentstate is

when init => if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				 
				LargeNumber(3 downto 0) <= switches(3 downto 0);
				presentstate <= Key_1;
				elsif  BUTTONS(2)= '0' and BtnTwoHistory = '1' then
				FirstRandNo <= RNDN;
				SecondRandNo <= RNDNB;
				presentstate <= GFRN;
				else 
				 presentstate <= init;
				 end if;
when Key_1 => if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				 
				 LargeNumber(7 downto 4) <= switches(3 downto 0);
				 presentstate <= Key_2;
				 else 
				 presentstate <= Key_1;
				 end if;
when Key_2 => if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				
				  LargeNumber(11 downto 8) <= switches(3 downto 0);
				   presentstate <= Key_3;
				 else 
				 presentstate <= Key_2;
				 end if;
when Key_3 => if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				
				  LargeNumber(15 downto 12) <= switches(3 downto 0);
				   presentstate <= Key_4;
				 else 
				 presentstate <= Key_3;
				 end if;
when Key_4 =>
if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				
 if LargeNumber(3 downto 0) ="00000000" and LargeNumber(7 downto 4)="00000001" and LargeNumber(11 downto 8)="00000010" and LargeNumber(15 downto 12)="00000100" then 
  presentstate<=ValidationSuccess;
  Message <="0000000010110000";
  START <= '1';
 else
  presentstate<=ValidationFailed;
  Message<="0000101010101110";
  START <= '1';
  end if;
end if;	

when GFRN=>

LargeNumber(3 downto 0) <= "00" & FirstRandNo;
presentstate <=RFRN;

when RFRN=>
					if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				
				  LargeNumber(11 downto 8) <= switches(3 downto 0);
				   presentstate <= GSRN;
					
				 else 
				 presentstate <= RFRN;
				 end if;
when GSRN=>

LargeNumber(7 downto 4) <= "00" & SecondRandNo;
presentstate <=RSRN;

when RSRN=>
				if BUTTONS(1)= '0' and BtnOneHistory = '1' then
				
				  LargeNumber(15 downto 12) <= switches(3 downto 0);
				   presentstate <= VERN;
					
				 else 
				 presentstate <= RSRN;
				 end if;
when VERN=>


CASE FirstRandNo IS
    WHEN  "00"  => 
	if LargeNumber(11 downto 8) = "0000" then 
	IsFRNV := '1';
	else
	IsFRNV :=  '0';
	end if;
    WHEN  "01"  =>  
		if LargeNumber(11 downto 8) = "0001" then 
		IsFRNV := '1';
		else
		IsFRNV :=  '0';
	end if;
    WHEN  "10"  =>
		if LargeNumber(11 downto 8) = "0010" then 
		IsFRNV := '1';
		else
		IsFRNV :=  '0';
		end if;
    WHEN  "11"  => 
	 if LargeNumber(11 downto 8) = "0100" then 
		IsFRNV := '1';
		else
		IsFRNV :=  '0';
		end if;
    WHEN OTHERS =>  IsFRNV := '0';
  END CASE;
  
  
  CASE SecondRandNo IS
    WHEN  "00"  => 
	if LargeNumber(15 downto 12) = "0000" then 
	IsSRNV := '1';
	else
	IsSRNV :=  '0';
	end if;
    WHEN  "01"  =>  
		if LargeNumber(15 downto 12) = "0001" then 
		IsSRNV := '1';
		else
		IsSRNV :=  '0';
	end if;
    WHEN  "10"  =>
		if LargeNumber(15 downto 12) = "0010" then 
		IsSRNV := '1';
		else
		IsSRNV :=  '0';
		end if;
    WHEN  "11"  => 
	 if LargeNumber(15 downto 12) = "0100" then 
		IsSRNV := '1';
		else
		IsSRNV :=  '0';
		end if;
    WHEN OTHERS =>  IsSRNV := '0';
  END CASE;
  
if IsSRNV ='1' and IsFRNV ='1' then
presentstate<=ValidationSuccess;
Message <="0000000010110000";
 START <= '1';
else
presentstate <= ValidationFailed;
Message<="0000101010101110";
  START <= '1';
end if;
when ValidationSuccess => presentstate <= ValidationSuccess; 
when ValidationFailed => presentstate <= ValidationFailed;   	  		 		 
when others =>presentstate<= init;				 
end case;
end if;
end process;


LEDS <= 	"11111111"  when  presentstate = ValidationSuccess else
         "00111111" when presentstate = ValidationFailed else
			"00000011" when presentstate = RFRN else
			"00001111" when presentstate = RSRN 
			 else "00000000";

  
dd: Display PORT MAP(number=>fourbit,segs=> SEVENSEGMENTS);
DM :DisplayMultiplexer PORT MAP(clkM=>CLK,NA=>MessageM,digitM=>digit,DV=>fourbit);
MC:InternalClock PORT MAP(CLK=>CLK,OCLK=>MyClk);
MM :MessageMultiplexer PORT MAP(CLK=>CLK,MA=>LargeNumber,MB=>Message,MC=>MessageM,START=>START);
RN :RandomNumber PORT MAP(CLK=>CLK,RNDN=>RNDN,RNDNB=>RNDNB);
end Behavioral;

