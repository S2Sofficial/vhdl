# Moore “01” Sequence Detector
![image](https://github.com/user-attachments/assets/5e2ead66-ebb5-4219-afd0-3a8d463d1ec9)

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
This project implements a **Moore finite‐state machine** that detects the overlapping bit pattern **“01”** on a serial input. When the detector has just transitioned into the detect state, it asserts `dout = '1'` for one clock cycle.  

---

## Theory  
In a **Moore** FSM the output depends **only on the current state**. To detect “01” we use three states:  
- **IDLE**      – no relevant history, `dout=0`  
- **S0**        – saw a `0`, `dout=0`  
- **S01_DETECT**– saw “01”, `dout=1`  

**State Transitions** (on each rising clock, `rst` synchronous):  
- **IDLE**  
  - `din='0'` → **S0**  
  - `din='1'` → **IDLE**  
- **S0**  
  - `din='1'` → **S01_DETECT**  
  - `din='0'` → **S0**  
- **S01_DETECT**  
  - `din='0'` → **S0**  (allow overlap)  
  - `din='1'` → **IDLE**  

**Output**:  
- `dout='1'` only in **S01_DETECT**, `dout='0'` in all other states.

---

## VHDL Code Implementation  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moore_seq01_det is
    Port (
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;   -- synchronous reset
        din  : in  STD_LOGIC;   -- serial data input
        dout : out STD_LOGIC    -- high in detect state
    );
end moore_seq01_det;

architecture Behavioral of moore_seq01_det is
    type state_type is (IDLE, S0, S01_DETECT);
    signal state : state_type := IDLE;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= IDLE;
            else
                case state is
                    when IDLE =>
                        if din = '0' then
                            state <= S0;
                        else
                            state <= IDLE;
                        end if;

                    when S0 =>
                        if din = '1' then
                            state <= S01_DETECT;
                        else
                            state <= S0;
                        end if;

                    when S01_DETECT =>
                        if din = '0' then
                            state <= S0;
                        else
                            state <= IDLE;
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Moore output logic
    dout <= '1' when state = S01_DETECT else '0';
end Behavioral;
```

---

## Simulation in Xilinx Vivado  

### Testbench Creation  

```vhdl
-- File: tb_moore_seq01_det.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_moore_seq01_det is
end tb_moore_seq01_det;

architecture Behavioral of tb_moore_seq01_det is
    component moore_seq01_det
        Port ( clk  : in  STD_LOGIC;
               rst  : in  STD_LOGIC;
               din  : in  STD_LOGIC;
               dout : out STD_LOGIC );
    end component;

    signal clk_sig, rst_sig, din_sig, dout_sig : STD_LOGIC := '0';
begin
    uut: moore_seq01_det
        port map (
            clk  => clk_sig,
            rst  => rst_sig,
            din  => din_sig,
            dout => dout_sig
        );

    -- Clock generation (10 ns period)
    clk_proc: process
    begin
        clk_sig <= '0'; wait for 5 ns;
        clk_sig <= '1'; wait for 5 ns;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        rst_sig <= '1'; wait for 20 ns;
        rst_sig <= '0'; wait for 20 ns;

        -- apply bits: 1,1 (no detect)
        din_sig <= '1'; wait for 10 ns;
        din_sig <= '1'; wait for 10 ns;

        -- sequence 0,1 (detect)
        din_sig <= '0'; wait for 10 ns;
        din_sig <= '1'; wait for 10 ns;  -- dout='1' in next cycle

        -- sequence overlap: 0,1 again
        din_sig <= '0'; wait for 10 ns;
        din_sig <= '1'; wait for 10 ns;  -- dout='1'

        wait;  -- end simulation
    end process;
end Behavioral;
```

### Waveform Analysis  

| Step | rst | din | state          | dout | Description                     |
|-----:|:---:|:---:|----------------|:----:|---------------------------------|
| 1    | 1   |  X  | IDLE           | 0    | Reset                           |
| 2    | 0   |  1  | IDLE           | 0    | Remain in IDLE                  |
| 3    | 0   |  1  | IDLE           | 0    | No detection on “11”            |
| 4    | 0   |  0  | S0             | 0    | Saw ‘0’                         |
| 5    | 0   |  1  | S01_DETECT     | 1    | In detect state → dout=1        |
| 6    | 0   |  0  | S0             | 0    | Overlap, saw ‘0’                |
| 7    | 0   |  1  | S01_DETECT     | 1    | Detect again on overlapping “01”|

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

![image](https://github.com/user-attachments/assets/8dfb59c3-cd1a-4090-8ed5-d4db2f3b832a)

Output via Force Test.

![image](https://github.com/user-attachments/assets/57b523dc-53a8-4d7f-b54e-194e7e2d3ad4)

Output via Testbench.

---

Made by **Swaroop Kumar Yadav**  
