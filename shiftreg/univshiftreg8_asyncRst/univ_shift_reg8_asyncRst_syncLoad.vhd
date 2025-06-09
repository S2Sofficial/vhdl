----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2025 02:51:46 AM
-- Design Name: 
-- Module Name: univ_shift_reg8_asyncRst_syncLoad - Behavioral
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


-- File: univ_shift_reg8_asyncRst_syncLoad.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity univ_shift_reg8_asyncRst_syncLoad is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;                         -- Async reset
        load    : in  STD_LOGIC;                         -- Sync parallel load
        shift   : in  STD_LOGIC_VECTOR(1 downto 0);      -- "00"=hold, "01"=left, "10"=right
        data_in : in  STD_LOGIC_VECTOR(7 downto 0);      -- Parallel data
        Q       : out STD_LOGIC_VECTOR(7 downto 0)       -- Register output
    );
end univ_shift_reg8_asyncRst_syncLoad;

architecture Behavioral of univ_shift_reg8_asyncRst_syncLoad is
    signal reg : STD_LOGIC_VECTOR(7 downto 0);
begin

    process(rst, clk)
    begin
        if rst = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                reg <= data_in;
            else
                case shift is
                    when "01" => reg <= reg(6 downto 0) & '0';
                    when "10" => reg <= '0' & reg(7 downto 1);
                    when others => reg <= reg;
                end case;
            end if;
        end if;
    end process;

    Q <= reg;

end Behavioral;