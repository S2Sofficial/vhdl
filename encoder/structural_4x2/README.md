# 4x2 Encoder in VHDL - Structural Modeling

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Encoder Explanation](#encoder-explanation)  
   - [Truth Table](#truth-table)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [Images](#images)  

---

## Project Overview  
A **4x2 Encoder** is a combinational circuit that encodes four input lines into a **two-bit** binary representation. Only one input should be high at a time.  

This project implements a **4x2 Encoder using Structural Modeling** in **VHDL**, simulates it in **Xilinx Vivado**, and verifies its correctness.  

---

## Theory  

### Encoder Explanation  
A **4x2 Encoder** has:  
- **4 Input lines:** `D(0) - D(3)`  
- **2 Output lines:** `Y(1) - Y(0)`  

The outputs are determined based on which input line is high.  

### Truth Table  

| D(3) | D(2) | D(1) | D(0) | Y(1) | Y(0) |  
|------|------|------|------|------|------|  
| 0    | 0    | 0    | 1    | 0    | 0    |  
| 0    | 0    | 1    | 0    | 0    | 1    |  
| 0    | 1    | 0    | 0    | 1    | 0    |  
| 1    | 0    | 0    | 0    | 1    | 1    |  

---

## VHDL Code Implementation  
The **Structural Modeling** approach is used to build the encoder using basic logic gates.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_4x2 is
    Port ( D : in STD_LOGIC_VECTOR(3 downto 0);
           Y : out STD_LOGIC_VECTOR(1 downto 0)
           );
end encoder_4x2;

architecture Structural of encoder_4x2 is

begin
    Y(1) <= D(2) or D(3);
    Y(0) <= D(1) or D(3);

end Structural;
```

---

## Simulation in Xilinx Vivado  
The **4x2 Encoder** functionality was verified by simulating its VHDL implementation in **Xilinx Vivado**.  
![image](https://github.com/user-attachments/assets/3d132d3f-526a-4796-b83d-671cea146bda)


### Testbench Creation  
A testbench was written to apply all possible input combinations.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_4x2_struct_tb is
end encoder_4x2_struct_tb;

architecture Behavioral of encoder_4x2_struct_tb is
    signal D : STD_LOGIC_VECTOR(3 downto 0);
    signal Y : STD_LOGIC_VECTOR(1 downto 0);
begin
    -- Instantiate UUT (Unit Under Test)
    uut: entity work.encoder_4x2 port map (D => D, Y => Y);

    process
    begin
        -- Test different inputs
        D <= "0001"; wait for 20 ns;
        D <= "0010"; wait for 20 ns;
        D <= "0100"; wait for 20 ns;
        D <= "1000"; wait for 20 ns;
        wait;
    end process;
end Behavioral;
```

### Waveform Analysis  
The simulation results confirm that the **encoder correctly maps the input to the corresponding binary output**.  

| **D(3)** | **D(2)** | **D(1)** | **D(0)** | **Y(1)** | **Y(0)** |  
|----------|----------|----------|----------|----------|----------|  
| 0        | 0        | 0        | 1        | 0        | 0        |  
| 0        | 0        | 1        | 0        | 0        | 1        |  
| 0        | 1        | 0        | 0        | 1        | 0        |  
| 1        | 0        | 0        | 0        | 1        | 1        |  

---

## Images  
Here are the screenshots of the **4x2 Encoder simulation results**:  

![image](https://github.com/user-attachments/assets/13e7ee33-b97f-45f4-938c-69cb6bc1158a)

---

Made by **Swaroop Kumar Yadav**  
