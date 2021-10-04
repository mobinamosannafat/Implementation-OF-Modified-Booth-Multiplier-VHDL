LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CLAadder IS
    PORT
        (
         Numin1   :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
         Numin2   :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
         Cin     :  IN   STD_LOGIC;
         CLAsum  :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
         Cout    :  OUT  STD_LOGIC
        );
END CLAadder;

ARCHITECTURE behavioral OF CLAadder IS

SIGNAL    Csum       :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    CGenerate  :    STD_LOGIC_VECTOR(15 DOWNTO 0);  --generation bit
SIGNAL    CPropagate :    STD_LOGIC_VECTOR(15 DOWNTO 0);  --propagation bit
SIGNAL    CarryIn	   :    STD_LOGIC_VECTOR(15 DOWNTO 1);

BEGIN
    Csum <= Numin1 XOR Numin2;
    CGenerate <= Numin1 AND Numin2;
    CPropagate <= Numin1 OR Numin2;
	 
    PROCESS (CGenerate,CPropagate,CarryIn)
    BEGIN
	 
    CarryIn(1) <= CGenerate(0) OR (CPropagate(0) AND Cin);
	 
        inst: FOR i IN 1 TO 14 LOOP
              CarryIn(i+1) <= CGenerate(i) OR (CPropagate(i) AND CarryIn(i));
              END LOOP;
    Cout <= CGenerate(15) OR (CPropagate(15) AND CarryIn(15));
    END PROCESS;

    CLAsum (0) <= Csum(0) XOR Cin;
    CLAsum (15 DOWNTO 1) <= Csum(15 DOWNTO 1) XOR CarryIn (15 DOWNTO 1);
END behavioral;