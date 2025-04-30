# Mealy “01” Sequence Detector
![image](https://github.com/user-attachments/assets/5bbed358-ffad-4172-a474-cef0d93726dd)

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [FPGA Constraints File](#fpga-constraints-file)  
6. [Images](#images)  

---

## Project Overview  
This project implements a **Mealy finite-state machine** that detects the overlapping bit pattern **“01”** on a serial input. When the detector sees a `0` followed immediately by `1`, it asserts the output `dout` for one clock cycle.

---

## Theory  
A Mealy machine’s output depends on **both** its current state and its current input. For the “01” detector we use **two states**:  
- **IDLE**: waiting for `0`  
- **S0**: saw `0`, now waiting for `1`  

Transitions:  
- **IDLE → S0** on `din='0'`, output `0`  
- **S0 → IDLE** on `din='1'`, output `1` (detected “01”)  
- **S0 → S0** on `din='0'`, output `0`  
- **IDLE → IDLE** on `din='1'`, output `0`  

Because the output is generated in the same cycle as the final `1` arrives, this is a Mealy implementation with **overlapping** detection.

---

## VHDL Code Implementation  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mealy_seq01_det is
    Port (
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;      -- synchronous reset
        din  : in  STD_LOGIC;      -- serial data input
        dout : out STD_LOGIC       -- pulses when “01” detected
    );
end mealy_seq01_det;

architecture Behavioral of mealy_seq01_det is
    type state_type is (IDLE, S0);
    signal state : state_type := IDLE;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= IDLE;
                dout  <= '0';
            else
                case state is

                    when IDLE =>
                        dout <= '0';
                        if din = '0' then
                            state <= S0;
                        end if;

                    when S0 =>
                        if din = '1' then
                            dout  <= '1';  -- “01” detected
                            state <= IDLE; -- restart for next detection
                        else
                            dout  <= '0';
                            state <= S0;   -- stay if another ‘0’
                        end if;

                end case;
            end if;
        end if;
    end process;
end Behavioral;
```

---

## Simulation in Xilinx Vivado  

### Testbench Creation  

```vhdl
-- File: tb_mealy_seq01_det.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mealy_seq01_det is
end tb_mealy_seq01_det;

architecture Behavioral of tb_mealy_seq01_det is
    component mealy_seq01_det
        Port (
            clk  : in  STD_LOGIC;
            rst  : in  STD_LOGIC;
            din  : in  STD_LOGIC;
            dout : out STD_LOGIC
        );
    end component;

    signal clk_sig, rst_sig, din_sig, dout_sig : STD_LOGIC := '0';
begin
    uut: mealy_seq01_det
        port map (
            clk  => clk_sig,
            rst  => rst_sig,
            din  => din_sig,
            dout => dout_sig
        );

    -- Clock: 10 ns period
    clk_proc: process
    begin
        clk_sig <= '0'; wait for 5 ns;
        clk_sig <= '1'; wait for 5 ns;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Apply reset
        rst_sig <= '1'; wait for 20 ns;
        rst_sig <= '0'; wait for 20 ns;

        -- Input: 1,1 → no detection
        din_sig <= '1'; wait for 10 ns;
        din_sig <= '1'; wait for 10 ns;

        -- Input: 0,1 → detection at second cycle
        din_sig <= '0'; wait for 10 ns;
        din_sig <= '1'; wait for 10 ns;

        -- Input: 0,0 → no detection
        din_sig <= '0'; wait for 10 ns;
        din_sig <= '0'; wait for 10 ns;

        -- Input: 0,1 → detection again
        din_sig <= '0'; wait for 10 ns;
        din_sig <= '1'; wait for 10 ns;

        wait;  -- end simulation
    end process;
end Behavioral;
```

### Waveform Analysis  

| Step | rst | din | dout | Description                      |
|-----:|:---:|:---:|:----:|----------------------------------|
| 1    | 1   |  X  |  0   | Reset asserted                   |
| 2    | 0   |  1  |  0   | In IDLE, seeing ‘1’              |
| 3    | 0   |  1  |  0   | Still IDLE                       |
| 4    | 0   |  0  |  0   | Move to S0 on ‘0’                |
| 5    | 0   |  1  |  1   | “01” detected → dout pulses ‘1’  |
| 6    | 0   |  0  |  0   | Back to IDLE or S0, no detect    |
| 7    | 0   |  1  |  1   | “01” detected again              |

---

## FPGA Constraints File

```xdc
# Clock
# set_property PACKAGE_PIN <pin> [get_ports clk]

# Reset
# set_property PACKAGE_PIN <pin> [get_ports rst]

# Data Input
# set_property PACKAGE_PIN <pin> [get_ports din]

# Output
# set_property PACKAGE_PIN <pin> [get_ports dout]
```

---

## Images  

![image](https://github.com/user-attachments/assets/37e32025-8c20-4b4b-9256-367644ce682c)

---

Made by **Swaroop Kumar Yadav**  
