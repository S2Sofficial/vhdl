# 8-bit Universal Shift Register with Async Reset & Sync Load  
![image](https://github.com/user-attachments/assets/7ad97155-ad33-428c-9cce-5194abe3c326)

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Control Signals](#control-signals)  
   - [Operation Modes](#operation-modes)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [FPGA Constraints File](#fpga-constraints-file)  
6. [Images](#images)  

---

## Project Overview  
An **8-bit universal shift register** that supports:  
- **Asynchronous reset** (`rst`)  
- **Synchronous parallel load** (`load`)  
- **Shift-left** and **shift-right** operations via a 2-bit `shift` control  
- **Hold** state when no operation is selected  

This register is implemented in **VHDL** (entity `univ_shift_reg8_asyncRst_syncLoad`) and verified in **Xilinx Vivado**.  

---

## Theory  

### Control Signals  
- `clk` : Clock input  
- `rst` : Asynchronous reset (active high)  
- `load` : Synchronous parallel load enable  
- `shift` : 2-bit control (`"00"`=hold, `"01"`=shift-left, `"10"`=shift-right)  
- `data_in` : 8-bit parallel data input  
- `Q` : 8-bit parallel register output  

### Operation Modes  
1. **Reset**: When `rst='1'`, register clears to `00000000` immediately.  
2. **Load**: On rising edge when `load='1'`, register takes value of `data_in`.  
3. **Shift-Left**: When `shift="01"` and `load='0'`, bits shift left, LSB ≤ ‘0’.  
4. **Shift-Right**: When `shift="10"` and `load='0'`, bits shift right, MSB ≤ ‘0’.  
5. **Hold**: When `shift="00"` or `"11"`, register retains its value.  

---

## VHDL Code Implementation  

```vhdl
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
```

---

## Simulation in Xilinx Vivado  

### Testbench Creation  

```vhdl
-- File: tb_univ_shift_reg8_asyncRst_syncLoad.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_univ_shift_reg8_asyncRst_syncLoad is
end tb_univ_shift_reg8_asyncRst_syncLoad;

architecture Behavioral of tb_univ_shift_reg8_asyncRst_syncLoad is
    component univ_shift_reg8_asyncRst_syncLoad
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            load    : in  STD_LOGIC;
            shift   : in  STD_LOGIC_VECTOR(1 downto 0);
            data_in : in  STD_LOGIC_VECTOR(7 downto 0);
            Q       : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal clk_sig     : STD_LOGIC := '0';
    signal rst_sig     : STD_LOGIC := '0';
    signal load_sig    : STD_LOGIC := '0';
    signal shift_sig   : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal data_in_sig : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Q_sig       : STD_LOGIC_VECTOR(7 downto 0);
begin

    UUT: univ_shift_reg8_asyncRst_syncLoad
        Port map (
            clk     => clk_sig,
            rst     => rst_sig,
            load    => load_sig,
            shift   => shift_sig,
            data_in => data_in_sig,
            Q       => Q_sig
        );

    -- Clock generation (10 ns period)
    clk_process: process
    begin
        while true loop
            clk_sig <= '0'; wait for 5 ns;
            clk_sig <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Apply async reset
        rst_sig <= '1'; wait for 15 ns;
        rst_sig <= '0'; wait for 15 ns;

        -- Parallel load 0xA5
        data_in_sig <= x"A5"; load_sig <= '1';
        wait for 10 ns; load_sig <= '0'; wait for 20 ns;

        -- Shift left 3 cycles
        shift_sig <= "01"; wait for 30 ns;

        -- Shift right 3 cycles
        shift_sig <= "10"; wait for 30 ns;

        -- Hold for 20 ns
        shift_sig <= "00"; wait for 20 ns;

        wait;  -- End simulation
    end process;

end Behavioral;
```

### Waveform Analysis  

| Time (ns) | rst | load | shift | data_in | Q (hex) |
|----------:|-----|------|-------|---------|---------|
|    0–15   |  1  |  0   | 00    | --      | 00      |
|   15–30   |  0  |  1   | 00    | A5      | A5      |
|   30–60   |  0  |  0   | 01    | A5      | 4A, 25, 12 |
|   60–90   |  0  |  0   | 10    | --      | 09, 04, 02 |
|   90–110  |  0  |  0   | 00    | --      | 02      |

---

## FPGA Constraints File  

```xdc
# Clock
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset, Load, Shift[1:0]
# set_property PACKAGE_PIN V17 [get_ports rst]
# set_property PACKAGE_PIN U17 [get_ports load]
# set_property PACKAGE_PIN T17 [get_ports shift[0]]
# set_property PACKAGE_PIN R17 [get_ports shift[1]]

# Data_in[7:0]
# set_property PACKAGE_PIN T19 [get_ports data_in[0]]
# ... repeat for data_in[1]..data_in[7]

# Q[7:0]
# set_property PACKAGE_PIN R19 [get_ports Q[0]]
# ... repeat for Q[1]..Q[7]
```

---

## Images  
Simulation waveform and FPGA output screenshots go here.

---

Made by **Swaroop Kumar Yadav**  
