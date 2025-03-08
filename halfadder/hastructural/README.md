# Half Adder using Structural modelling 

I’m excited to share my **VHDL journey** with the implementation of a **Half Adder**! This project covers **design, simulation in Xilinx Vivado, and FPGA implementation on the Artix-7 Nexys A7-100T**. 🚀  

---
## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory and Logic](#2-theory-and-logic)  
3. [VHDL Code Implementation](#3-vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#4-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [FPGA Implementation](#5-fpga-implementation)    
6. [RTL Design](#8-rtl-design)  

---

## **1. Project Overview**  
The goal was to **design, simulate, and implement** a **Half Adder** using **VHDL and FPGA technology**.  

A **Half Adder** is a basic combinational circuit that adds **two binary bits** and produces **two outputs**:  
- **Sum (S)**
- **Carry (C)**  

This project provided hands-on experience in **hardware description languages (HDL), combinational logic, and FPGA-based circuit implementation**.  

---

## **2. Theory and Logic**  
A **Half Adder** follows these logic equations:  

### **Boolean Expressions**  
- **Sum (S) = A ⊕ B** *(XOR operation)*  
- **Carry (C) = A · B** *(AND operation)*  

### **Truth Table**  
| **A** | **B** | **Sum (S)** | **Carry (C)** |  
|---|---|---|---|  
| 0 | 0 | 0 | 0 |  
| 0 | 1 | 1 | 0 |  
| 1 | 0 | 1 | 0 |  
| 1 | 1 | 0 | 1 |  

---

## **3. VHDL Code Implementation**  
The Half Adder was implemented using **VHDL**, with an **entity** for inputs (`A`, `B`) and outputs (`Sum`, `Carry`). The **structural architecture** used **XOR** and **AND** gates for logic operations.  

 ```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_structural is
    port (A, B : in std_logic ;
    SUM, CARRY : out std_logic );
end half_adder_structural;

architecture Structural of half_adder_structural is
    component xor_gate 
        port (X,Y : in std_logic ;
        Z : out std_logic );
        end component ;
        
    component and_gate
        port (X, Y: in std_logic ;
        Z : out std_logic );
        end component ;
begin
    xor1: xor_gate port map ( X => A, Y => B, Z => SUM);
    and1: and_gate port map (X => A, Y => B, Z => CARRY);

end Structural;

```
For `Xor_Gate.vhd`
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Z : out STD_LOGIC);
end xor_gate;

architecture Behavioral of xor_gate is

begin
    Z <= X xor Y;

end Behavioral;
```
For `And_gate.vhd`
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate is
    port (X, Y: in std_logic ;
    Z : out std_logic );
end and_gate;

architecture Behavioral of and_gate is

begin
    Z <= X and Y ; -- AND Gate Logic
end Behavioral;
```
---

## **4. Simulation in Xilinx Vivado**  
### **Testbench Creation**  
To verify functionality, a **testbench** was created to apply different input combinations (`00`, `01`, `10`, `11`) and check the expected outputs (`Sum`, `Carry`).  
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_half_adder is
--  Port ( );
end tb_half_adder;

architecture test of tb_half_adder is
    signal  A, B, SUM, CARRY: std_logic ;
    
    component half_adder_structural 
        port (A, B : in std_logic ;
        SUM, CARRY : out std_logic );
        end component ;
begin
    uut: half_adder_structural port map (A => A, B => B, SUM => SUM, CARRY => CARRY);
    process 
    begin
        A <= '0'; B <= '0'; wait for 20ns;
        A <= '0'; B <= '1'; wait for 20ns;
        A <= '1'; B <= '0'; wait for 20ns;
        A <= '1'; B <= '1'; wait for 20ns;
        wait;
    end process ;
end test;
```

### **Waveform Analysis**  
The **Vivado waveform viewer** confirmed the correctness of the design, matching the **truth table outputs**.  

| **A** | **B** | **Sum** | **Carry** |  
|---|---|---|---|  
| 0 | 0 | 0 | 0 |  
| 0 | 1 | 1 | 0 |  
| 1 | 0 | 1 | 0 |  
| 1 | 1 | 0 | 1 |  

![image](https://github.com/user-attachments/assets/f30fa50f-4b02-4ab0-b664-38caa894eb3c)

---

## **5. FPGA Implementation**  
The Half Adder was implemented on the **Artix-7 Nexys A7-100T FPGA board** with real-time testing.  

---

## **6. RTL Design**  
📸 **Project screenshots & FPGA setup:**  
![RTL Design](https://github.com/user-attachments/assets/615d8134-43ac-465b-b90a-3a80c75eecc1)

---
## **GitHub Repository**  
🔗 **Check out the full project on GitHub:** [https://s2sofficial.github.io/vhdl/]  

---

**Made by Swaroop Kumar Yadav**  
