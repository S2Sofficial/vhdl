library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSegment is
    Port ( binary_in : in STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input (0-15)
           hex_out   : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment output
           mode      : in STD_LOGIC);  -- '0' = Hex, '1' = Decimal
end SevenSegment;

architecture Behavioral of SevenSegment is
    -- Active LOW 7-segment encoding (Common Anode)
    type seg_array is array (0 to 15) of STD_LOGIC_VECTOR(6 downto 0);
    signal seg_map : seg_array := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- B
        "1000110", -- C
        "0100001", -- D
        "0000110", -- E
        "0001110"  -- F
    );
begin
    process(binary_in, mode)
    begin
        if mode = '0' then
            -- Hex Mode (0-F)
            hex_out <= seg_map(to_integer(unsigned(binary_in)));
        else
            -- Decimal Mode (0-9), blank for invalid inputs
            case to_integer(unsigned(binary_in)) is
                when 0 to 9 => hex_out <= seg_map(to_integer(unsigned(binary_in)));
                when others => hex_out <= "1111111"; -- Blank (Active-Low Display)
            end case;
        end if;
    end process;
end Behavioral;
