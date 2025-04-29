# 8-bit Up/Down Counter with Async Reset & Sync Load in VHDL  
![image](https://github.com/user-attachments/assets/37808541-1790-42b0-9c27-6cad62df2a51)


## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Counter Modes](#counter-modes)  
   - [Operation](#operation)  
3. [Working](#working)  
4. [VHDL Code Implementation](#vhdl-code-implementation)  
5. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
6. [FPGA Constraints File](#fpga-constraints-file)  
7. [Images](#images)  

---

## Project Overview  
An **8-bit up/down counter** that supports:  
- **Asynchronous reset** (`rst`) to clear the count.  
- **Synchronous load** (`load`) to preset the count from `data_in`.  
- **Direction control** (`up_down`): up (`'1'`) or down (`'0'`).  

This design is implemented in **VHDL**, simulated in **Xilinx Vivado**, and ready for FPGA deployment.  

---

## Theory  

### Counter Modes  
- **Up Mode:** Increment on each rising clock edge.  
- **Down Mode:** Decrement on each rising clock edge.  
- **Load Mode:** On `load = '1'`, synchronously load `data_in` value.  
- **Reset:** On `rst = '1'`, asynchronously clear count to zero.  

### Operation  
1. **Async Reset:** Immediately clears count to `0x00`.  
2. **On Clock Edge:**  
   - If `load = '1'` → `count <= data_in`.  
   - Else if `up_down = '1'` → `count <= count + 1`.  
   - Else → `count <= count - 1`.  

---

## Working  
- **clk:** Drives all synchronous operations.  
- **rst:** Asynchronous, active-high.  
- **load:** When high at clock edge, loads `data_in` into counter.  
- **up_down:** Selects increment or decrement.  
- **data_in:** 8-bit parallel data for synchronous loading.  
- **count:** 8-bit output representing current count.  

---

## VHDL Code Implementation  

```vhdl
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
```

---

## Simulation in Xilinx Vivado  

### Testbench Creation  
A testbench applies reset, load, up/down commands, and verifies the counter behavior.

```vhdl
-- File: tb_up_down_counter_AsyncRst.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_up_down_counter_AsyncRst is
end tb_up_down_counter_AsyncRst;

architecture Behavioral of tb_up_down_counter_AsyncRst is
    -- Component declaration for the Unit Under Test (UUT)
    component up_down_counter_AsyncRst
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            load     : in  STD_LOGIC;
            up_down  : in  STD_LOGIC;
            data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
            count    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal clk_sig     : STD_LOGIC := '0';
    signal rst_sig     : STD_LOGIC := '0';
    signal load_sig    : STD_LOGIC := '0';
    signal up_down_sig : STD_LOGIC := '1';
    signal data_in_sig : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal count_sig   : STD_LOGIC_VECTOR(7 downto 0);
begin

    -- Instantiate UUT
    UUT: up_down_counter_AsyncRst
        Port map (
            clk     => clk_sig,
            rst     => rst_sig,
            load    => load_sig,
            up_down => up_down_sig,
            data_in => data_in_sig,
            count   => count_sig
        );

    -- Clock generation: 100 MHz (10 ns period)
    clk_process: process
    begin
        while true loop
            clk_sig <= '0';
            wait for 5 ns;
            clk_sig <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply asynchronous reset
        rst_sig <= '1';
        wait for 20 ns;
        rst_sig <= '0';
        wait for 20 ns;

        -- Synchronous load test
        data_in_sig <= x"AA";  -- load 0xAA
        load_sig <= '1';
        wait for 10 ns;        -- on next rising edge, count = 0xAA
        load_sig <= '0';
        wait for 20 ns;

        -- Count up for 5 cycles
        up_down_sig <= '1';
        wait for 50 ns;

        -- Count down for 5 cycles
        up_down_sig <= '0';
        wait for 50 ns;

        -- Load new value and count up again
        data_in_sig <= x"0F";  
        load_sig <= '1';
        wait for 10 ns;
        load_sig <= '0';
        up_down_sig <= '1';
        wait for 40 ns;

        -- Finish simulation
        wait;
    end process;

end Behavioral;


```

### Waveform Analysis  
The simulation waveform should show:  
| Time | rst | load | up_down | data_in  | count    |  
|------|-----|------|---------|----------|----------|  
| 0 ns | 1   | 0    | X       | XXXX     | 00000000 |  
| 20 ns| 0   | 1    | X       | 10101010 | 10101010 |  
| 40 ns| 0   | 0    | 1       | XXXX     | 10101011 |  
| 60 ns| 0   | 0    | 0       | XXXX     | 10101010 |  

---

## FPGA Constraints File  

```xdc
# Clock
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset
# set_property PACKAGE_PIN V17 [get_ports rst]
# set_property IOSTANDARD LVCMOS33 [get_ports rst]

# Load, Direction
# set_property PACKAGE_PIN U17 [get_ports load]
# set_property PACKAGE_PIN U16 [get_ports up_down]
# set_property IOSTANDARD LVCMOS33 [get_ports {load, up_down}]

# Data inputs
# set_property PACKAGE_PIN T19 [get_ports data_in[0]]
# ... repeat for data_in[1]..data_in[7]

# Count outputs
# set_property PACKAGE_PIN R19 [get_ports count[0]]
# ... repeat for count[1]..count[7]
```

---

## Images  
Simulation waveform and FPGA LED output. 
![image](https://github.com/user-attachments/assets/c96b66f2-ff60-430d-b90b-b42bf8269183)


---

Made by **Swaroop Kumar Yadav**
