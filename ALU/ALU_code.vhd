----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2025 07:11:43 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-bit ALU supporting basic arithmetic and logical operations
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Always use numeric_std for arithmetic operations

entity ALU is
    Port (
        A       : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input A
        B       : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input B
        ALU_op  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit operation selector
        Result  : out STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit result
        Zero    : out STD_LOGIC                     -- Zero flag
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, ALU_op)
    variable temp_result : STD_LOGIC_VECTOR(7 downto 0);
    begin
        -- Default assignment
        temp_result := (others => '0');  

        case ALU_op is

            -- Addition (A + B)
            when "000" =>  
                temp_result := std_logic_vector(unsigned(A) + unsigned(B));

            -- Subtraction (A - B) [Using Signed to handle underflow correctly]
            when "001" =>  
                temp_result := std_logic_vector(signed(A) - signed(B));

            -- AND operation (A AND B)
            when "010" =>  
                temp_result := A and B;

            -- OR operation (A OR B)
            when "011" =>  
                temp_result := A or B;

            -- XOR operation (A XOR B)
            when "100" =>  
                temp_result := A xor B;

            -- NOT operation (NOT A)
            when "101" =>  
                temp_result := not A;

            -- Default case for invalid ALU operations
            when others =>  
                temp_result := (others => '0');  -- Set result to zero for undefined operations
        end case;

        -- Assign result
        Result <= temp_result;

        -- Set Zero flag: if result is all zeros, Zero flag is set to '1'
        if temp_result = "00000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end Behavioral;
