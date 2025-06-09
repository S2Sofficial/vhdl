----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 04:10:07 PM
-- Design Name: 
-- Module Name: up_down_counter_SyncRst - Behavioral
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


-- File: up_down_counter_SyncRst.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity up_down_counter_SyncRst is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;                        -- Synchronous reset
        load     : in  STD_LOGIC;                        -- Synchronous load enable
        up_down  : in  STD_LOGIC;                        -- '1' = count up, '0' = count down
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0);     -- Parallel load data
        count    : out STD_LOGIC_VECTOR(7 downto 0)      -- Current count value
    );
end up_down_counter_SyncRst;

architecture Behavioral of up_down_counter_SyncRst is
    signal cnt : UNSIGNED(7 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt <= (others => '0');
            elsif load = '1' then
                cnt <= UNSIGNED(data_in);
            elsif up_down = '1' then
                cnt <= cnt + 1;
            else
                cnt <= cnt - 1;
            end if;
        end if;
    end process;

    count <= STD_LOGIC_VECTOR(cnt);

end Behavioral;
