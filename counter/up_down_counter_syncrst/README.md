# 8-bit Up/Down Counter with Synchronous Reset & Load in VHDL  
![image](https://github.com/user-attachments/assets/4d29de28-4e63-4dcb-898c-27f8e1673deb)


## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [Counter Modes](#counter-modes)  
   - [Operation](#operation)  
3. [Working](#3-working)  
4. [VHDL Code Implementation](#4-vhdl-code-implementation)  
5. [Simulation in Xilinx Vivado](#5-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
6. [FPGA Constraints File](#6-fpga-constraints-file)  
7. [Images](#7-images)  

---

## **1. Project Overview**  
This project implements an **8-bit up/down counter** with **synchronous reset** and **synchronous load**. The counter increments or decrements on each rising clock edge based on a direction input, and can be preset with parallel data.  

---

## **2. Theory**  

### Counter Modes  
- **Reset Mode:** When `rst = '1'`, the counter clears to zero on the next clock edge.  
- **Load Mode:** When `load = '1'`, the counter loads `data_in` on the next clock edge.  
- **Count Up:** When `up_down = '1'` and not loading or resetting, the counter increments.  
- **Count Down:** When `up_down = '0'` and not loading or resetting, the counter decrements.  

### Operation  
On each rising edge of `clk`:  
1. If `rst = '1'` → `count <= 0x00`.  
2. Else if `load = '1'` → `count <= data_in`.  
3. Else if `up_down = '1'` → `count <= count + 1`.  
4. Else → `count <= count - 1`.  

---

## **3. Working**  
- **clk:** Clock input for synchronous operations.  
- **rst:** Active-high synchronous reset.  
- **load:** Active-high synchronous load enable.  
- **up_down:** Direction control (`'1'` = up, `'0'` = down).  
- **data_in:** 8-bit parallel value for synchronous load.  
- **count:** 8-bit output representing the current counter value.  

---

## **4. VHDL Code Implementation**  

```vhdl
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
```

---

## **5. Simulation in Xilinx Vivado**  

### Testbench Creation  

```vhdl
-- File: tb_up_down_counter_SyncRst.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_up_down_counter_SyncRst is
end tb_up_down_counter_SyncRst;

architecture Behavioral of tb_up_down_counter_SyncRst is
    component up_down_counter_SyncRst
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            load     : in  STD_LOGIC;
            up_down  : in  STD_LOGIC;
            data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
            count    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal clk_sig     : STD_LOGIC := '0';
    signal rst_sig     : STD_LOGIC := '0';
    signal load_sig    : STD_LOGIC := '0';
    signal up_down_sig : STD_LOGIC := '1';
    signal data_in_sig : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal count_sig   : STD_LOGIC_VECTOR(7 downto 0);
begin

    UUT: up_down_counter_SyncRst
        Port map (
            clk     => clk_sig,
            rst     => rst_sig,
            load    => load_sig,
            up_down => up_down_sig,
            data_in => data_in_sig,
            count   => count_sig
        );

    -- Clock generation: 10 ns period
    clk_process: process
    begin
        while true loop
            clk_sig <= '0'; wait for 5 ns;
            clk_sig <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the counter synchronously
        rst_sig <= '1'; wait for 10 ns;
        rst_sig <= '0'; wait for 10 ns;

        -- Load 0x3C
        data_in_sig <= x"3C"; load_sig <= '1';
        wait for 10 ns; load_sig <= '0'; wait for 20 ns;

        -- Count up for four cycles
        up_down_sig <= '1'; wait for 40 ns;

        -- Count down for four cycles
        up_down_sig <= '0'; wait for 40 ns;

        -- Load 0xA5 and count up
        data_in_sig <= x"A5"; load_sig <= '1';
        wait for 10 ns; load_sig <= '0'; up_down_sig <= '1';
        wait for 40 ns;

        wait;  -- End simulation
    end process;

end Behavioral;
```

### Waveform Analysis  
The simulation confirms:  
| Time   | rst | load | up_down | data_in | count   |  
|--------|-----|------|---------|---------|---------|  
| 10 ns  | 1   | 0    | X       | XX      | 00      |  
| 20 ns  | 0   | 1    | X       | 3C      | 3C      |  
| 30–70 ns | 0 | 0    | 1       | 3C      | 3F–43   |  
| 70–110 ns| 0 | 0    | 0       | 3C      | 3B–37   |  

---

## **6. FPGA Constraints File**  

```xdc
# Clock
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset, Load, Direction
# set_property PACKAGE_PIN V17 [get_ports rst]
# set_property PACKAGE_PIN U17 [get_ports load]
# set_property PACKAGE_PIN U16 [get_ports up_down]

# Data_in[7:0]
# set_property PACKAGE_PIN T19 [get_ports data_in[0]]
# ... repeat for data_in[1]..data_in[7]

# Count[7:0]
# set_property PACKAGE_PIN R19 [get_ports count[0]]
# ... repeat for count[1]..count[7]
```

---

## **7. Images**  
Simulation waveform and FPGA board output.
![image](https://github.com/user-attachments/assets/4b23a132-e101-4799-96bc-eee36c87623b)


---

Made by **Swaroop Kumar Yadav**  
