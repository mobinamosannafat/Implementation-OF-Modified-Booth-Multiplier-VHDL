library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

-- main entity
entity ModifiedBooth is   
	port(
		multiplier    : in std_logic_vector (7 downto 0);
		multiplicand  : in std_logic_vector (7 downto 0);
		result        : out std_logic_vector (15 downto 0);  --result of multipication
		clk           : in std_logic
	 );
end ModifiedBooth;

architecture ModifiedBoothArc of ModifiedBooth is

signal Reg11, Reg21, Reg31, Reg41 		 : std_logic_vector (8 downto 0);    --the register that use for saving
																									 --information between stage1 and stage2
																									 --Reg11 + Reg21 + Reg31 + Reg41 = register1
signal Reg12, Reg22, Reg32, Reg42 , Reg43 : std_logic_vector (15 downto 0); 
--reg12 , reg22 , reg32 and sum1 , carry1 are using in stage 2 for calling wallace twice continuously
--reg42 , reg43 , sum2 , sum3 , carry2 , carry3 are used as a register between stage2 and stage3
--
signal sum1, carry1     : std_logic_vector (15 downto 0);
signal sum2, carry2     : std_logic_vector (15 downto 0);
signal sum3, carry3     : std_logic_vector (15 downto 0);
signal sum4, carry4     : std_logic_vector (15 downto 0);


--this component is used for stage1
component Decoder is 
	port(
		Dval        : in std_logic_vector (7 downto 0);      --getting multiplier
		ThreeBits        : in std_logic_vector (2 downto 0); --variable for seprating bits
		Dresult        : out std_logic_vector (8 downto 0)   --result of decoding
	);
end component;


--this component is used for stage2   
--it works like wallace three 
--it add three partial products of decoder
--we use this component 2 times for stage2
component Wallace is
    Port ( 
			  num1  : in  STD_LOGIC_VECTOR (15 downto 0);  --first product of decoding
           num2  : in  STD_LOGIC_VECTOR (15 downto 0);  --second product of decoding
           num3  : in  STD_LOGIC_VECTOR (15 downto 0);  --third product of decoding
           sum   : out  STD_LOGIC_VECTOR (15 downto 0); --result of adding this 3 products
           carry : out  STD_LOGIC_VECTOR (15 downto 0)  
			  );
end component;

--this component is used for stage3(final stage)
--this carry lookahead adder get two 16 bits product from last stage and carry bit and do sum opration  
component CLAadder IS
    PORT
        (
         Numin1   :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
         Numin2   :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
         Cin      :  IN   STD_LOGIC;
         CLAsum   :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);  --result of opration
         Cout     :  OUT  STD_LOGIC
        );
END component;
		
begin
	
	--calling decoder component for each  two bits we seprated from right side concatinantion of them with the
	--first right side bit and saving results in register1
	dec1 : Decoder port map (multiplier, multiplicand(1 downto 0) & '0', Reg11);
	dec2 : Decoder port map (multiplier, multiplicand(3 downto 1), Reg21);
	dec3 : Decoder port map (multiplier, multiplicand(5 downto 3), Reg31);
	dec4 : Decoder port map (multiplier, multiplicand(7 downto 5), Reg41);

	wal1 : Wallace port map (Reg12, Reg22, Reg32, sum1, carry1); --calling wallace component for first 3 products
	wal2 : Wallace port map (sum2, carry2, Reg43, sum3, carry3); --calling wallace component for result of last calling
																					 --wallace and forth product

	
	CLA : CLAadder port map (sum4, carry4, '0', result);
	
	process(clk)
	begin
		if(clk 'event and clk='1') then  --extending to 16 bits with extending significant bit and adding 0 to right side
         Reg12 <= Reg11(8) & Reg11(8) & Reg11(8) & Reg11(8) & Reg11(8) & Reg11(8) & Reg11(8) & Reg11; 
	      Reg22 <= Reg21(8) & Reg21(8) & Reg21(8) & Reg21(8) & Reg21(8) & Reg21 & "00"; 
	      Reg32 <= Reg31(8) & Reg31(8) & Reg31(8) & Reg31 & "0000"; 
	      Reg42 <= Reg41(8) & Reg41 & "000000";
		   Reg43 <= Reg42;	

			sum2 <= sum1;     
			carry2 <= carry1;
			sum4 <= sum3;
			carry4 <= carry3;
		end if;
	end process;
end ModifiedBoothArc;