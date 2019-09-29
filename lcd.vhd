----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2019 07:55:49 AM
-- Design Name: 
-- Module Name: lcd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
library UNISIM;
use UNISIM.VComponents.all;

entity lcd is
	port (
		clk200_n:  in std_logic;
        clk200_p:  in std_logic;
		rst          : in  std_logic;
		lcd_e        : out std_logic;
		lcd_rs       : out std_logic;
		lcd_rw       : out std_logic;
		lcd_db       : out std_logic_vector(7 downto 4)
		);
		
end lcd;

architecture Behavioral of lcd is
        
     signal clk: std_logic;    
	COMPONENT lcd16x2_ctrl IS
	  PORT(
	  
      clk          : in  std_logic;
      rst          : in  std_logic;
      lcd_e        : out std_logic;
      lcd_rs       : out std_logic;
      lcd_rw       : out std_logic;
      lcd_db       : out std_logic_vector(7 downto 4);
      line1_buffer : in  std_logic_vector(127 downto 0);  -- 16x8bit
      line2_buffer : in  std_logic_vector(127 downto 0)); 
	END COMPONENT;
	
	-- These lines can be configured to be input from anything. 
	-- 8 bits per character
	signal top_line : std_logic_vector(127 downto 0) := x"4d617975722773204650474120202020"; -- Translates to Mayur's FPGA
	signal bottom_line : std_logic_vector(127 downto 0) := x"5445535420666f72204c434420202020";

begin

IBUFDS_inst : IBUFGDS
   generic map (
      DIFF_TERM => FALSE, -- Differential Termination 
      IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "DEFAULT")
   port map (
      O => clk,  -- Buffer output
      I => clk200_p,  -- Diff_p buffer input (connect directly to top-level port)
      IB => clk200_n -- Diff_n buffer input (connect directly to top-level port)
   );


LCD: lcd16x2_ctrl port map(
	clk => clk,
	rst => rst,
	lcd_e => lcd_e,
	lcd_rs => lcd_rs,
	lcd_rw => lcd_rw,
	lcd_db => lcd_db,
	line1_buffer => top_line,
	line2_buffer => bottom_line 
);

end Behavioral;
