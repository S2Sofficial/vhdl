----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 03:23:43 PM
-- Design Name: 
-- Module Name: up_down_counter_AsyncRst - Behavioral
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
-- 8-bit Up/Down Counter with Asyncronous Reset and Synchronous Load 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity up_down_counter_AsyncRst is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        load     : in  STD_LOGIC;
        up_down  : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
        count    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end up_down_counter_AsyncRst;

architecture Behavioral of up_down_counter_AsyncRst is
    signal cnt : UNSIGNED(7 downto 0);
begin
    process(rst, clk)
    begin
        if rst = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
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