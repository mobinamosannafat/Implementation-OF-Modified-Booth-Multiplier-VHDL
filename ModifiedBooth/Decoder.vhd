library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity Decoder is 
	port(
		Dval       : in std_logic_vector (7 downto 0);
		ThreeBits  : in std_logic_vector (2 downto 0);
		Dresult    : out std_logic_vector (8 downto 0)
	);
end Decoder;

architecture DecoderArc of Decoder is

	signal temp  : std_logic_vector (8 downto 0);
	
begin

	temp <= Dval(7) & Dval;  --extending significant bit
	
	
	Dresult <= "000000000" when ThreeBits = "000" or ThreeBits = "111"  --value = 0 --> value * multiplicand = 0
		else temp when ThreeBits = "001" or ThreeBits = "010"            --value = 1 --> value * multiplicand =  multiplicand
		else not temp + 1 when ThreeBits = "110" or ThreeBits = "101"    --value = -1 --> value * multiplicand = -multiplicand
		else not temp(7 downto 0 ) + 1 & '0' when ThreeBits = "100"		  --value = -2 --> value * multiplicand = -2multiplicand
		else temp(7 downto 0) & '0';												  --value = 2 --> value * multiplicand = 2multiplicand

end DecoderArc;