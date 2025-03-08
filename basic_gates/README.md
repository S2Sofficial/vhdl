# Basic Gates

I’m excited to share my first hands-on experience with **VHDL (VHSIC Hardware Description Language)**! As part of my journey into digital design, I successfully designed and simulated **ALL basic logic gates (AND, OR, NOT, XOR)** in a **single VHDL program** using **Xilinx Vivado**. Here’s a detailed breakdown of the process and what I learned:  

---
## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [VHDL Code Implementation](#2-vhdl-code-implementation)  
3. [Simulation in Xilinx Vivado](#3-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
4. [Challenges and Learnings](#4-challenges-and-learnings)  
5. [Tools and Resources](#5-tools-and-resources)  
6. [Images](#6-images)

---

## **1. Project Overview**  
The goal was to create a **single VHDL program** that implements **AND, OR, NOT, and XOR gates**, simulate their behavior, and verify their functionality using Xilinx Vivado’s simulation tools. This project served as my introduction to hardware description languages and FPGA design workflows.  

---

## **2. VHDL Code Implementation**  
Here’s the VHDL code I wrote to implement all four gates in a single program:  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity basic_gates is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           AND_OUT : out  STD_LOGIC;
           OR_OUT  : out  STD_LOGIC;
           XOR_OUT : out  STD_LOGIC;
           NOT_A   : out  STD_LOGIC);
end basic_gates;

architecture Behavioral of basic_gates is
begin
    AND_OUT <= A AND B;
    OR_OUT  <= A OR B;
    XOR_OUT <= A XOR B;
    NOT_A   <= NOT A;
end Behavioral;

```  

This code defines a single entity (`ALL_GATES`) with two inputs (`A` and `B`) and four outputs (`AND_OUT`, `OR_AND`, `NOT_A`, and `XOR_OUT`), each corresponding to the output of a specific gate.  

---

## **3. Simulation in Xilinx Vivado**  
After writing the VHDL code, I used Xilinx Vivado to simulate the design. Here’s how I approached it:  

### **Testbench Creation**  
I wrote a testbench to apply different input combinations (e.g., `00`, `01`, `10`, `11`) to the inputs `A` and `B` and observed the outputs for all four gates.  
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity basic_gates_tb is
end basic_gates_tb;

architecture Behavioral of basic_gates_tb is
    -- Initialize inputs to avoid simulation warnings
    signal A, B : STD_LOGIC := '0';
    signal AND_OUT, OR_OUT, XOR_OUT, NOT_A : STD_LOGIC;
    
begin
    -- Instantiate the basic_gates module
    uut: entity work.basic_gates
        port map (
            A => A, 
            B => B, 
            AND_OUT => AND_OUT, 
            OR_OUT => OR_OUT, 
            XOR_OUT => XOR_OUT, 
            NOT_A => NOT_A
            );

    -- Test process
    process
    begin
        -- Test Case 1: A = 0, B = 0
        A <= '0'; B <= '0'; wait for 10 ns;
        -- Test Case 2: A = 0, B = 1
        A <= '0'; B <= '1'; wait for 10 ns;
        -- Test Case 3: A = 1, B = 0
        A <= '1'; B <= '0'; wait for 10 ns;
        -- Test Case 4: A = 1, B = 1
        A <= '1'; B <= '1'; wait for 10 ns;
        wait; -- Stop simulation
    end process;
 
end Behavioral;

```

### **Waveform Analysis**  
The simulation results were visualized using Vivado’s waveform viewer, which confirmed the correct functionality of each gate.  

Here’s an example of the expected outputs for each gate:  

| **Input A** | **Input B** | **Y_AND** | **Y_OR** | **Y_NOT** | **Y_XOR** |  
|-------------|-------------|-----------|----------|-----------|-----------|  
| 0           | 0           | 0         | 0        | 1         | 0         |  
| 0           | 1           | 0         | 1        | 1         | 1         |  
| 1           | 0           | 0         | 1        | 0         | 1         |  
| 1           | 1           | 1         | 1        | 0         | 0         |  

![image](https://github.com/user-attachments/assets/b229c906-84dd-4d97-9efe-1bb81a7df5e7)

---

## **4. Challenges and Learnings**  
- **Code Structure**: Combining multiple gates into a single program required careful planning of the entity and architecture to ensure clean and readable code.  
- **Testbench Design**: Creating a comprehensive testbench to validate all four gates simultaneously was a great exercise in understanding input-output relationships.  
- **Debugging**: Identifying and fixing errors in the code (e.g., incorrect signal assignments or syntax errors) was a valuable learning experience.  

---

## **5. Tools and Resources**  
- **Xilinx Vivado**: For synthesis, simulation, and waveform analysis.  
- **Online Tutorials and Documentation**: These were invaluable for understanding VHDL basics and Vivado’s workflow.  

---

## **6. Images**  
Here are the screenshots for project execution. 
![image](https://github.com/user-attachments/assets/f60e753a-3b23-445c-8e72-475d8fecd4bf)


---

Made by Swaroop Kumar Yadav
