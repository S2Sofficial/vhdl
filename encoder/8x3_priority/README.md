# 8-to-3 Priority Encoder using VHDL  

## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [Priority Encoding Concept](#priority-encoding-concept)  
   - [Truth Table](#truth-table)  
3. [Working](#3-working)  
4. [VHDL Code Implementation](#4-vhdl-code-implementation)  
5. [Simulation in Xilinx Vivado](#5-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
6. [FPGA Constraints File](#6-fpga-constraints-file)  
7. [Images](#7-images)  

---

## **1. Project Overview**  
This project implements an **8-to-3 priority encoder** using **VHDL**. The encoder takes an **8-bit input (A)**, representing 8 possible signals, and produces a **3-bit output (Y)** corresponding to the highest priority active input. If multiple inputs are HIGH, the **highest priority (most significant bit) is encoded first**.  

---

## **2. Theory**  

### **Priority Encoding Concept**  
A priority encoder assigns priority to input lines, ensuring that if multiple inputs are active, the highest-priority input is encoded. The priority order is **A(7) > A(6) > A(5) > A(4) > A(3) > A(2) > A(1) > A(0)**.  

### **Truth Table**  

| **A(7:0)**       | **Y(2:0) Output** |  
|------------------|------------------|  
| 00000001 | 000 |  
| 00000010 | 001 |  
| 00000100 | 010 |  
| 00001000 | 011 |  
| 00010000 | 100 |  
| 00100000 | 101 |  
| 01000000 | 110 |  
| 10000000 | 111 |  
| 00000000 | 000 (Default) |  

---

## **3. Working**  

1. The **8-bit input (A)** represents eight possible signal lines.  
2. The priority encoder scans **from A(7) to A(0)** and encodes the highest active input into a **3-bit output (Y)**.  
3. If multiple inputs are HIGH, the highest priority bit **from left to right (MSB to LSB)** is chosen.  
4. If all inputs are LOW, the output defaults to `"000"`.  

---

## **4. VHDL Code Implementation**  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_8to3 is
    Port ( A : in  STD_LOGIC_VECTOR(7 downto 0);  
           Y : out  STD_LOGIC_VECTOR(2 downto 0)  
           );
end encoder_8to3;

architecture Behavioral of encoder_8to3 is
begin
    process(A)
    begin
        if    (A(7) = '1') then Y <= "111";  -- Highest priority
        elsif (A(6) = '1') then Y <= "110";
        elsif (A(5) = '1') then Y <= "101";
        elsif (A(4) = '1') then Y <= "100";
        elsif (A(3) = '1') then Y <= "011";
        elsif (A(2) = '1') then Y <= "010";
        elsif (A(1) = '1') then Y <= "001";
        elsif (A(0) = '1') then Y <= "000";  -- Lowest priority
        else                   Y <= "000";  -- Default case (all inputs are '0')
        end if;
    end process;
end Behavioral;
```

---

## **5. Simulation in Xilinx Vivado**  

### **Testbench Creation**  
A testbench was written to verify the encoder's output for all possible input combinations.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_encoder_8to3 is
end tb_encoder_8to3;

architecture behavior of tb_encoder_8to3 is
    
    component encoder_8to3
        Port ( A : in  STD_LOGIC_VECTOR(7 downto 0);
               Y : out  STD_LOGIC_VECTOR(2 downto 0) 
               );
    end component;

    
    signal A : STD_LOGIC_VECTOR(7 downto 0);  
    signal Y : STD_LOGIC_VECTOR(2 downto 0);  

begin
    
    uut: encoder_8to3
        Port map ( A => A, Y => Y );

   
    stim_proc: process
    begin
        
        A <= "10000000"; wait for 10 ns;
        A <= "01000000"; wait for 10 ns;
        A <= "00100000"; wait for 10 ns;
        A <= "00010000"; wait for 10 ns;
        A <= "00001000"; wait for 10 ns;
        A <= "00000100"; wait for 10 ns;
        A <= "00000010"; wait for 10 ns;
        A <= "00000001"; wait for 10 ns;
        A <= "00000000"; wait for 10 ns; 

       
        wait;
    end process;
end behavior;

```

### **Waveform Analysis**  
The simulation results confirm that the priority encoder correctly encodes the highest active bit.  

| **A Input** | **Y Output** |  
|------------|------------|  
| 00000001 | 000 |  
| 00000010 | 001 |  
| 00000110 | 010 (Priority on A(2)) |  
| 01010100 | 110 (Priority on A(6)) |  
| 10011011 | 111 (Priority on A(7)) |  
| 00000000 | 000 (Default) |  

---

## **6. FPGA Constraints File**  

```xdc
set_property PACKAGE_PIN J15 [get_ports {A[7]}]
set_property PACKAGE_PIN L16 [get_ports {A[6]}]
set_property PACKAGE_PIN M13 [get_ports {A[5]}]
set_property PACKAGE_PIN R15 [get_ports {A[4]}]
set_property PACKAGE_PIN R17 [get_ports {A[3]}]
set_property PACKAGE_PIN T18 [get_ports {A[2]}]
set_property PACKAGE_PIN U18 [get_ports {A[1]}]
set_property PACKAGE_PIN R13 [get_ports {A[0]}]
set_property PACKAGE_PIN H17 [get_ports {Y[2]}]
set_property PACKAGE_PIN K15 [get_ports {Y[1]}]
set_property PACKAGE_PIN J13 [get_ports {Y[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[0]}]
```

---

## **7. Images**  
Below are the **simulation waveform results** and **FPGA output images** showcasing the encoder's functionality.  
- **Elaborated Design:**
  ![Elaborated_Design](https://github.com/user-attachments/assets/ef0ec3a5-9d9e-4abe-a81c-611f74fbbc40)
- **Implementation Design:**
  ![Implementation_Design](https://github.com/user-attachments/assets/ded7a7ae-896e-4f94-a44b-8982b14933a3)
- **Waveform Analysis:**
  ![Waveform](https://github.com/user-attachments/assets/c0d4ce32-318d-4d68-807b-bd111dadb71a)
---

Made by **Swaroop Kumar Yadav**
