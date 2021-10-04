library ieee;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Booth is
port (
          
        multiplier, multiplicand: in  std_logic_vector(7 downto 0);  --variables are 8 bits
		   clk   : in  std_logic;
			result     : out std_logic_vector(15 downto 0)  --result of multipication can be at most 16 bits
		);
end Booth;	
			
architecture booth of Booth is


signal counter : std_logic_vector(3 downto 0) := "0000";  --because we have 9 level

signal s       : std_logic;  

   begin
	
	process( clk )
	
	variable arr : std_logic_vector(15 downto 0);

	begin 

	 if (clk 'event and clk='1' and counter <  9 ) then
	 
	    if ( counter = "0000" ) then  --first level : initializing arr
	    
		 
		     arr (7 downto 0) := multiplicand;           
			  
			  arr (15 downto 8) := "00000000";
			  
			  s <= '0';
			  		 
       elsif ( arr (0) = '0' and  s = '1' ) then   --Based on table
		 
		
		     arr (15 downto 8) := arr (15 downto 8) + multiplier;
			
		     s <= arr (0);									--Previous value is move down to result
			
		     arr (14 downto 0) := arr (15 downto 1);  --shift to right (it act like shift to left when we write
																	 -- partical products in 8 row)
			  			
		 elsif ( arr (0) = '1' and s = '0' ) then     --Based on table
		
		     arr (15 downto 8) := arr (15 downto 8) + not multiplier + 1 ;

		     s <= arr (0);									--Previous value is move down to result
		
	   	  arr (14 downto 0) := arr (15 downto 1); --shift to right (it act like shift to left when we write
																	-- partical products in 8 row)
			  		
		 else                                        --Based on table
		
		    s <= arr (0); 									--Previous value is move down to result
		
		    arr (14 downto 0) := arr (15 downto 1); 	--shift to right (it act like shift to left when we write
																	-- partical products in 8 row)
		
		 end if; 
      
	  counter <= counter + 1;  --increasing counter

	 end if;
	 
	  result <= arr;  --result of multipication
	 
	end process;

	end booth;
	
	
	
