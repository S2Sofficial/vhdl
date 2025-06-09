----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2025 12:18:04 PM
-- Design Name: 
-- Module Name: univ_shift_reg8_syncRst_syncLoad - Behavioral
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity univ_shift_reg8_syncRst_syncLoad is
    Port ( clk     : in  STD_LOGIC;
           rst     : in  STD_LOGIC;
           load    : in  STD_LOGIC;
           shift   : in  STD_LOGIC_VECTOR(1 downto 0); -- "00" hold, "01" left, "10" right
           data_in : in  STD_LOGIC_VECTOR(7 downto 0);
           Q       : out STD_LOGIC_VECTOR(7 downto 0));
end univ_shift_reg8_syncRst_syncLoad;

architecture Behavioral of univ_shift_reg8_syncRst_syncLoad is
    signal reg : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= (others => '0');  -- Reset the register on reset signal
            elsif load = '1' then
                reg <= data_in;          -- Load the data input when load is active
            else
                case shift is
                    when "01" => reg <= reg(6 downto 0) & '0';  -- Shift Left
                    when "10" => reg <= '0' & reg(7 downto 1);  -- Shift Right
                    when others => reg <= reg;                  -- Hold
                end case;
            end if;
        end if;
    end process;

    Q <= reg;  -- Output the value of the register
end Behavioral;