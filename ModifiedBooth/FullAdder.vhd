
library ieee;
use ieee.std_logic_1164.all;

Entity FullAdder is 
port(
		FANum1 , FANum2 , Cin : std_logic;
      FAsum , FACout       : out std_logic
	 );
End FullAdder;

Architecture FullAdder of FullAdder is

BEGIN
		FAsum <= FANum1 xor FANum2 xor Cin;
		FACout  <= (FANum1 and FANum2) or (FANum1 and Cin) or ( FANum2 and Cin); 
End FullAdder;