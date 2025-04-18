# Flip‑Flop Implementations in VHDL  

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [D Flip‑Flop](#d-flip-flop)  
   - [T Flip‑Flop](#t-flip-flop)  
   - [JK Flip‑Flop](#jk-flip-flop)  
   - [SR Flip‑Flop](#sr-flip-flop)  
3. [Working](#working)  
4. [VHDL Code Implementation](#vhdl-code-implementation)  
5. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
6. [FPGA Constraints File](#fpga-constraints-file)  
7. [Images](#images)  

---

## **1. Project Overview**  
This project implements four fundamental flip‑flops—**D, T, JK, and SR**—in a single VHDL entity. Each flip‑flop is triggered on the rising edge of a common clock and can be asynchronously reset.  

---

## **2. Theory**  

### D Flip‑Flop  
Captures the value of **D** at the rising edge of **clk** and holds it until the next clock.  

### T Flip‑Flop  
Toggles its output when **T = '1'** on the rising edge of **clk**; holds state when **T = '0'**.  

### JK Flip‑Flop  
When **J = '1'** and **K = '0'**, sets output; when **J = '0'** and **K = '1'**, resets; when **J = K = '1'**, toggles.  

### SR Flip‑Flop  
When **S = '1'** and **R = '0'**, sets output; when **S = '0'** and **R = '1'**, resets; when **S = R = '0'**, holds; **S = R = '1'** is invalid.  

---

## **3. Working**  
1. An **asynchronous reset** initializes all outputs to `'0'`.  
2. On each **rising edge of clk**, each flip‑flop updates according to its input and characteristic equation.  
3. All four are tested in parallel under varying input sequences.  

---

## **4. VHDL Code Implementation**  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlops is
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        D     : in  STD_LOGIC;
        T     : in  STD_LOGIC;
        J, K  : in  STD_LOGIC;
        S, R  : in  STD_LOGIC;
        Q_D   : out STD_LOGIC;
        Q_T   : out STD_LOGIC;
        Q_JK  : out STD_LOGIC;
        Q_SR  : out STD_LOGIC
    );
end FlipFlops;

architecture Behavioral of FlipFlops is
begin
    -- D Flip‑Flop
    process(clk, rst) begin
        if rst = '1' then
            Q_D <= '0';
        elsif rising_edge(clk) then
            Q_D <= D;
        end if;
    end process;

    -- T Flip‑Flop
    process(clk, rst) begin
        if rst = '1' then
            Q_T <= '0';
        elsif rising_edge(clk) then
            if T = '1' then
                Q_T <= not Q_T;
            end if;
        end if;
    end process;

    -- JK Flip‑Flop
    process(clk, rst) begin
        if rst = '1' then
            Q_JK <= '0';
        elsif rising_edge(clk) then
            case (J & K) is
                when "10" => Q_JK <= '1';
                when "01" => Q_JK <= '0';
                when "11" => Q_JK <= not Q_JK;
                when others => null;
            end case;
        end if;
    end process;

    -- SR Flip‑Flop
    process(clk, rst) begin
        if rst = '1' then
            Q_SR <= '0';
        elsif rising_edge(clk) then
            if (S = '1' and R = '0') then
                Q_SR <= '1';
            elsif (S = '0' and R = '1') then
                Q_SR <= '0';
            elsif (S = '1' and R = '1') then
                Q_SR <= 'X';  -- invalid
            end if;
        end if;
    end process;
end Behavioral;
```

---

5. Simulation in Xilinx Vivado

Testbench Creation

A testbench applies various stimulus patterns to D, T, J/K, and S/R along with clk and rst to verify each flip‑flop’s behavior.
```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlops_TB is
end FlipFlops_TB;

architecture test of FlipFlops_TB is
    signal clk, rst : STD_LOGIC := '0';
    signal D, T, J, K, S, R : STD_LOGIC := '0';
    signal Q_D, Q_T, Q_JK, Q_SR : STD_LOGIC;
begin
    UUT: entity work.FlipFlops port map (
        clk => clk, rst => rst,
        D => D, T => T, J => J, K => K, S => S, R => R,
        Q_D => Q_D, Q_T => Q_T, Q_JK => Q_JK, Q_SR => Q_SR
    );

    -- Clock generation
    clk_process: process begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

    -- Stimulus process
    stim: process
    begin
        rst <= '1'; wait for 10 ns; rst <= '0';
        -- Test D
        D <= '1'; wait for 10 ns; D <= '0'; wait for 10 ns;
        -- Test T
        T <= '1'; wait for 40 ns; T <= '0'; wait for 10 ns;
        -- Test JK
        J <= '1'; K <= '0'; wait for 10 ns;
        J <= '0'; K <= '1'; wait for 10 ns;
        J <= '1'; K <= '1'; wait for 20 ns;
        -- Test SR
        S <= '1'; R <= '0'; wait for 10 ns;
        S <= '0'; R <= '1'; wait for 10 ns;
        S <= '1'; R <= '1'; wait for 10 ns;
        wait;
    end process;
end test;
```
---

Waveform Analysis

The simulation confirms correct capture, toggle, set/reset, and priority behaviors for each flip‑flop under test.


---

6. FPGA Constraints File

# FPGA Constraints for Flip‑Flops
# Map clk, rst, inputs and outputs to FPGA pins as needed


---

7. Images

Simulation waveform and (if implemented) FPGA LED output images go here.


---

Made by Swaroop Kumar Yadav
