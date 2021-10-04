library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Wallace is
    Port (
			  num1  : in  STD_LOGIC_VECTOR (15 downto 0);
           num2  : in  STD_LOGIC_VECTOR (15 downto 0);
           num3  : in  STD_LOGIC_VECTOR (15 downto 0);
           sum   : out  STD_LOGIC_VECTOR (15 downto 0);
           carry : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end Wallace;

architecture Behavioral of Wallace is

--using full adder component
component FullAdder is 
port(
		FANum1 , FANum2 , Cin : std_logic;
      FAsum , FACout       : out std_logic
	  );
End component;


signal Cout : std_logic;

begin 

--calling full adder for adding every bit of every column of first 3 product
FAdder0  : FullAdder port map(num1(0),num2(0),num3(0),sum(0),carry(1));
FAdder1  : FullAdder port map(num1(1),num2(1),num3(1),sum(1),carry(2));
FAdder2  : FullAdder port map(num1(2),num2(2),num3(2),sum(2),carry(3));
FAdder3  : FullAdder port map(num1(3),num2(3),num3(3),sum(3),carry(4));
FAdder4  : FullAdder port map(num1(4),num2(4),num3(4),sum(4),carry(5));
FAdder5  : FullAdder port map(num1(5),num2(5),num3(5),sum(5),carry(6));
FAdder6  : FullAdder port map(num1(6),num2(6),num3(6),sum(6),carry(7));
FAdder7  : FullAdder port map(num1(7),num2(7),num3(7),sum(7),carry(8));
FAdder8  : FullAdder port map(num1(8),num2(8),num3(8),sum(8),carry(9));
FAdder9  : FullAdder port map(num1(9),num2(9),num3(9),sum(9),carry(10));
FAdder10 : FullAdder port map(num1(10),num2(10),num3(10),sum(10),carry(11));
FAdder11 : FullAdder port map(num1(11),num2(11),num3(11),sum(11),carry(12));
FAdder12 : FullAdder port map(num1(12),num2(12),num3(12),sum(12),carry(13));
FAdder13 : FullAdder port map(num1(13),num2(13),num3(13),sum(13),carry(14));
FAdder14 : FullAdder port map(num1(14),num2(14),num3(14),sum(14),carry(15));
FAdder15 : FullAdder port map(num1(15),num2(15),num3(15),sum(15),Cout);

end Behavioral;