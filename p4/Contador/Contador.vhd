----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:02 03/21/2018 
-- Design Name: 
-- Module Name:    Contador - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (3 downto 0));
end Contador;

architecture Behavioral of Contador is
	
	COMPONENT ffD_reset
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		ce : IN std_logic;
		d : IN std_logic;          
		q : OUT std_logic
		);
	END COMPONENT;
	signal qa, qb, qc, qd : std_logic;
	signal da, db, dc, dd : std_logic;
	
begin

Unit_A: ffD_reset PORT MAP(
		clk => clk,
		reset => reset,
		ce => ce,
		d => da,
		q => qa
	);
	
	Unit_B: ffD_reset PORT MAP(
		clk => clk,
		reset => reset,
		ce => ce,
		d => db ,
		q => qb
	);
	
	Unit_C: ffD_reset PORT MAP(
		clk => clk,
		reset => reset,
		ce => ce,
		d => dc,
		q => qc
	);
	
	Unit_D: ffD_reset PORT MAP(
		clk => clk,
		reset => reset,
		ce => ce,
		d => dd,
		q => qd
	);
	
	dd <= not qd;
	dc <= (not qa) and (qc xor qd);
	db <= (qb and (not qc or not qd) ) or (not qb and (qc and qd));
	da <= (qa and not qd) or ((qb and qc) and qd);
	
		count <= qa & qb & qc & qd;

	count(0) <= qd;
	count(1) <= qc;
	count(2) <= qb;
	count(3) <= qa;
	
end Behavioral;

