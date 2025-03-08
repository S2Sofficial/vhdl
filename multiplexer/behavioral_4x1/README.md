# 4x1 Multiplexer in VHDL - Behavioral Modeling

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Multiplexer Explanation](#multiplexer-explanation)  
   - [Truth Table](#truth-table)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [Images](#images)  

---

## Project Overview  
A **4x1 Multiplexer (MUX)** is a combinational circuit that selects one of four input signals based on two **select lines** and forwards it to the output.  

This project implements a **4x1 MUX using Behavioral Modeling** in **VHDL**, simulates it in **Xilinx Vivado**, and verifies its correctness.  

---

## Theory  

### Multiplexer Explanation  
A **4x1 Multiplexer** has:  
- **4 Input lines:** `I0, I1, I2, I3`  
- **2 Select lines:** `S1, S0`  
- **1 Output line:** `Y`  

The **select lines (S1, S0)** determine which input is passed to the output.  

### Truth Table  

| S1 | S0 | Output (Y) |  
|----|----|-----------|  
|  0 |  0 | I0        |  
|  0 |  1 | I1        |  
|  1 |  0 | I2        |  
|  1 |  1 | I3        |  

---

## VHDL Code Implementation  
The **Behavioral Modeling** approach uses the `case` statement inside a process block to implement the multiplexer.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4x1_behav is
    Port ( a,b,c,d : in STD_LOGIC;
           sel : in std_logic_vector (1 downto 0);
           y : out STD_LOGIC);
end mux_4x1_behav;

architecture Behavioral of mux_4x1_behav is

begin
    process (a,b,c,d,sel)
    begin
        case sel is
            when "00" => y <= a;
            when "01" => y <= b;
            when "10" => y <= c;
            when "11" => y <= d;
            when others => y <= '0';
        end case;
        end process;
```

---

## Simulation in Xilinx Vivado  
The **4x1 MUX** functionality was verified by simulating its VHDL implementation in **Xilinx Vivado**.  
![image](https://github.com/user-attachments/assets/ef9172a3-07c8-468b-a377-0eec22a650ae)


### Testbench Creation  
A testbench was created to apply all possible input and select line combinations.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4x1_behav_tb is
end mux_4x1_behav_tb;

architecture Behavioral of mux_4x1_behav_tb is
    signal a, b, c, d, y : STD_LOGIC;
    signal sel : STD_LOGIC_VECTOR(1 downto 0);
begin
    uut: entity work.mux_4x1_behav
        port map (a => a, b=> b, c=>c , d=>d, sel=>sel, y => y);

    process
    begin
        a <= '1'; b <= '0'; c <= '0'; d <= '0'; sel <= "00"; wait for 20 ns;
        a <= '0'; b <= '1'; c <= '0'; d <= '0'; sel <= "01"; wait for 20 ns;
        a <= '0'; b <= '0'; c <= '1'; d <= '0'; sel <= "10"; wait for 20 ns;
        a <= '0'; b <= '0'; c <= '0'; d <= '1'; sel <= "11"; wait for 20 ns;

        wait;
    end process;
end Behavioral;
```

### Waveform Analysis  
The simulation results confirm that the **MUX correctly selects the input based on the select lines**.  

| **Select Inputs (S1, S0)** | **Output (Y)** |  
|--------------------------|-------------|  
| 0, 0 | Y = I0 |  
| 0, 1 | Y = I1 |  
| 1, 0 | Y = I2 |  
| 1, 1 | Y = I3 |  

---

## Images  
Here are the screenshots of the **4x1 MUX simulation results**:  

![image](https://github.com/user-attachments/assets/cbb9ce71-e007-4013-b99b-29fb5a6c4431)

---

Made by **Swaroop Kumar Yadav**  
