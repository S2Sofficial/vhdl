# 8-bit Universal Shift Register with Synchronous Reset and Load
![image](https://github.com/user-attachments/assets/249b9368-dcdf-4218-a5e4-963a426d023a)

## Description

This design implements an 8-bit universal shift register with a synchronous reset and load functionality. The shift register can perform the following operations based on the control signals:
- **Shift Left**
- **Shift Right**
- **Hold the current value**
- **Load a new value**

The operations are controlled using the `shift` input signal, where:
- `"00"`: Hold (No shift)
- `"01"`: Shift Left
- `"10"`: Shift Right

When asserted, the `load` input signal loads a new value into the shift register.

### Key Features
- **Synchronous Reset**: Resets the register value to zero when `rst = '1'` during the clock edge.
- **Synchronous Load**: Loads the 8-bit data from `data_in` when `load = '1'`.
- **Shift Operations**: Based on the `shift` input, the register can shift left or right.

## VHDL Code

### Entity

```vhdl
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
```

### Architecture

```vhdl
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
```

## Testbench

### Testbench Code

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_univ_shift_reg8_syncRst_syncLoad is
end tb_univ_shift_reg8_syncRst_syncLoad;

architecture Behavioral of tb_univ_shift_reg8_syncRst_syncLoad is
    -- Component Declaration for the Unit Under Test (UUT)
    component univ_shift_reg8_syncRst_syncLoad
        Port ( clk     : in  STD_LOGIC;
               rst     : in  STD_LOGIC;
               load    : in  STD_LOGIC;
               shift   : in  STD_LOGIC_VECTOR(1 downto 0);
               data_in : in  STD_LOGIC_VECTOR(7 downto 0);
               Q       : out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    -- Signals to connect to the UUT
    signal clk     : STD_LOGIC := '0';
    signal rst     : STD_LOGIC := '0';
    signal load    : STD_LOGIC := '0';
    signal shift   : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal data_in : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal Q       : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: univ_shift_reg8_syncRst_syncLoad
        Port map ( clk => clk,
                   rst => rst,
                   load => load,
                   shift => shift,
                   data_in => data_in,
                   Q => Q );

    -- Clock Generation Process
    clk_process :process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        -- Test Load Operation
        load <= '1';
        data_in <= "10101010"; -- Load 0xAA
        wait for 20 ns;
        load <= '0';

        -- Test Shift Left
        shift <= "01";
        wait for 20 ns;

        -- Test Shift Right
        shift <= "10";
        wait for 20 ns;

        -- Test Hold
        shift <= "00";
        wait for 20 ns;

        -- End simulation
        wait;
    end process;
end Behavioral;
```

## Constraints File

```plaintext
# Constraints for clock signal (Assume 50 MHz clock input)
set_property PACKAGE_PIN V17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 20 [get_pins clk]

# Constraints for Reset signal (Assume button for reset)
set_property PACKAGE_PIN U15 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# Constraints for load signal
set_property PACKAGE_PIN V15 [get_ports load]
set_property IOSTANDARD LVCMOS33 [get_ports load]

# Constraints for shift signals
set_property PACKAGE_PIN U14 [get_ports shift[0]]
set_property PACKAGE_PIN T14 [get_ports shift[1]]
set_property IOSTANDARD LVCMOS33 [get_ports shift]

# Constraints for data_in signal (Assume switches for input)
set_property PACKAGE_PIN W15 [get_ports data_in[0]]
set_property PACKAGE_PIN W14 [get_ports data_in[1]]
set_property PACKAGE_PIN T13 [get_ports data_in[2]]
set_property PACKAGE_PIN T12 [get_ports data_in[3]]
set_property PACKAGE_PIN R12 [get_ports data_in[4]]
set_property PACKAGE_PIN R11 [get_ports data_in[5]]
set_property PACKAGE_PIN P10 [get_ports data_in[6]]
set_property PACKAGE_PIN P9 [get_ports data_in[7]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in]

# Constraints for output signal Q
set_property PACKAGE_PIN N8 [get_ports Q[0]]
set_property PACKAGE_PIN M8 [get_ports Q[1]]
set_property PACKAGE_PIN L8 [get_ports Q[2]]
set_property PACKAGE_PIN K8 [get_ports Q[3]]
set_property PACKAGE_PIN J8 [get_ports Q[4]]
set_property PACKAGE_PIN H8 [get_ports Q[5]]
set_property PACKAGE_PIN G8 [get_ports Q[6]]
set_property PACKAGE_PIN F8 [get_ports Q[7]]
set_property IOSTANDARD LVCMOS33 [get_ports Q]
```

## Working

### Entity Description

This design implements an 8-bit universal shift register with synchronous reset and load functionality. The shift register operates based on the following control signals:
- **Synchronous Reset (`rst`)**: When asserted (`rst = '1'`), the register is reset to `0x00` (all bits are zero).
- **Load (`load`)**: When asserted (`load = '1'`), the data from `data_in` is loaded into the register.
- **Shift Operations (`shift`)**: The shift operations are controlled by the `shift` input signal, where:
  - `"01"`: Shift Left
  - `"10"`: Shift Right
  - `"00"`: Hold the current value (no shift)

### Architecture Explanation

The shift register operation is controlled by the `clk` signal. On each rising edge of the clock:
- If `rst` is `1`, the register is reset.
- If `load` is `1`, the register loads the value from `data_in`.
- If neither `rst` nor `load` are active, the shift register performs the operation based on the `shift` signal:
  - **Shift Left**: The bits are shifted left by one position, and the rightmost bit is filled with `0`.
  - **Shift Right**: The bits are shifted right by one position, and the leftmost bit is filled with `0`.
  - **Hold**: The register holds the current value.

The value of the register is output through the `Q` signal.

Here is a **truth table** that summarizes the behavior of the **8-bit Universal Shift Register with Synchronous Reset and Load** based on different input combinations of `rst`, `load`, and `shift`:

### 🚦 Output Behavior Table

| `clk ↑` | `rst` | `load` | `shift` | Operation Performed           | Description                        | `Q (next state)`                    |
|--------|-------|--------|---------|-------------------------------|------------------------------------|-------------------------------------|
|   ↑    |  1    |   X    |   XX    | Reset                         | All bits reset to 0                | `"00000000"`                        |
|   ↑    |  0    |   1    |   XX    | Load                          | Load `data_in` into register       | `data_in`                           |
|   ↑    |  0    |   0    |  "00"   | Hold                          | Retain previous value              | `Q <= Q`                            |
|   ↑    |  0    |   0    |  "01"   | Shift Left                    | Shift left, LSB becomes `0`        | `Q(6 downto 0) & '0'`               |
|   ↑    |  0    |   0    |  "10"   | Shift Right                   | Shift right, MSB becomes `0`       | `'0' & Q(7 downto 1)`               |
|   ↑    |  0    |   0    |  "11"   | Invalid / Hold (default case) | No defined operation, retain value| `Q <= Q` (same as hold behavior)    |

![image](https://github.com/user-attachments/assets/6dd4cc32-9d41-4f3b-a5b1-b79a6eafdbb2)

## Conclusion

This design provides a simple and efficient 8-bit universal shift register with synchronous reset and load. The testbench code verifies the functionality by testing all the control signals (`rst`, `load`, and `shift`). You can adjust the constraints file to match your FPGA board for implementation.
