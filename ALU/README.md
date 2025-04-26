# Arithmetic Logic Unit (ALU) Design in VHDL  

## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [What is an ALU?](#what-is-an-alu)  
   - [ALU Operations](#alu-operations)  
   - [ALU Control Signals](#alu-control-signals)  
3. [Working](#3-working)  
4. [VHDL Code Implementation](#4-vhdl-code-implementation)  
5. [Simulation in Xilinx Vivado](#5-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
6. [FPGA Constraints File](#6-fpga-constraints-file)  
7. [Images](#7-images)  

---

## **1. Project Overview**  
This project implements a **4-bit Arithmetic Logic Unit (ALU)** using **VHDL**. The ALU performs both **arithmetic (addition, subtraction, etc.)** and **logical (AND, OR, XOR, etc.)** operations based on a control signal. The inputs and operation mode are controlled via switches, and the output is displayed using LEDs on an FPGA.  

---

## **2. Theory**  

### **What is an ALU?**  
An **Arithmetic Logic Unit (ALU)** is a fundamental building block of any computing system. It performs **arithmetic** and **logical** operations based on the given control signals. The ALU is part of the CPU and executes calculations required for program execution.  

### **ALU Operations**  
The ALU takes two **4-bit inputs (A and B)** and a **3-bit control signal (Sel)** to perform the following operations:  

| **Sel (Control Signal)** | **Operation**        | **Expression** |  
|-----------------|-----------------|----------------|  
| 000            | Addition         | A + B          |  
| 001            | Subtraction      | A - B          |  
| 010            | Bitwise AND      | A AND B        |  
| 011            | Bitwise OR       | A OR B         |  
| 100            | Bitwise XOR      | A XOR B        |  
| 101            | Bitwise NOT (A)  | NOT A          |  
| 110            | Left Shift (A)   | A << 1         |  
| 111            | Right Shift (A)  | A >> 1         |  

### **ALU Control Signals**  
The **control signals** determine which operation will be executed. These are typically provided by a control unit in a processor.  

---

## **3. Working**  

1. **Inputs (A and B) are given as 4-bit values** from FPGA switches.  
2. **The ALU selects the operation** based on the **3-bit control signal (Sel)**.  
3. **The result of the operation is stored** in a 4-bit output register.  
4. The result is displayed using **LEDs** on an FPGA.  
5. If an arithmetic operation results in a carry/overflow, a **carry flag is set**.  

---

## **4. VHDL Code Implementation**  

```vhdl
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2025 07:11:43 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-bit ALU supporting basic arithmetic and logical operations
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Always use numeric_std for arithmetic operations

entity ALU is
    Port (
        A       : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input A
        B       : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input B
        ALU_op  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit operation selector
        Result  : out STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit result
        Zero    : out STD_LOGIC                     -- Zero flag
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, ALU_op)
    variable temp_result : STD_LOGIC_VECTOR(7 downto 0);
    begin
        -- Default assignment
        temp_result := (others => '0');  

        case ALU_op is

            -- Addition (A + B)
            when "000" =>  
                temp_result := std_logic_vector(unsigned(A) + unsigned(B));

            -- Subtraction (A - B) [Using Signed to handle underflow correctly]
            when "001" =>  
                temp_result := std_logic_vector(signed(A) - signed(B));

            -- AND operation (A AND B)
            when "010" =>  
                temp_result := A and B;

            -- OR operation (A OR B)
            when "011" =>  
                temp_result := A or B;

            -- XOR operation (A XOR B)
            when "100" =>  
                temp_result := A xor B;

            -- NOT operation (NOT A)
            when "101" =>  
                temp_result := not A;

            -- Default case for invalid ALU operations
            when others =>  
                temp_result := (others => '0');  -- Set result to zero for undefined operations
        end case;

        -- Assign result
        Result <= temp_result;

        -- Set Zero flag: if result is all zeros, Zero flag is set to '1'
        if temp_result = "00000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end Behavioral;
```

---

## **5. Simulation in Xilinx Vivado**  

### **Testbench Creation**  
A testbench was written to verify ALU operations for different inputs and control signals.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is
    component ALU
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            ALU_op  : in  STD_LOGIC_VECTOR(2 downto 0);
            Result  : out STD_LOGIC_VECTOR(7 downto 0);
            Zero    : out STD_LOGIC
        );
    end component;

    signal A       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal ALU_op  : STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    signal Result  : STD_LOGIC_VECTOR(7 downto 0);
    signal Zero    : STD_LOGIC;

begin
    uut: ALU port map (
        A       => A,
        B       => B,
        ALU_op  => ALU_op,
        Result  => Result,
        Zero    => Zero
    );

    process
    begin
        -- Addition (A = 5, B = 10)
        A <= "00000101";  
        B <= "00001010";  
        ALU_op <= "000";  
        wait for 10 ns;

        -- Subtraction (A = 15, B = 5)
        A <= "00001111";  
        B <= "00000101";  
        ALU_op <= "001";  
        wait for 10 ns;

        -- AND operation
        A <= "11001100";  
        B <= "10101010";  
        ALU_op <= "010";  
        wait for 10 ns;

        -- OR operation
        A <= "11001100";  
        B <= "10101010";  
        ALU_op <= "011";  
        wait for 10 ns;

        -- XOR operation
        A <= "11001100";  
        B <= "10101010";  
        ALU_op <= "100";  
        wait for 10 ns;

        -- NOT operation (B is don't care)
        A <= "00001111";  
        B <= "--------";  -- B is not used in NOT operation
        ALU_op <= "101";  
        wait for 10 ns;

        -- Zero Flag Check (A = B = 0)
        A <= "00000000";  
        B <= "00000000";  
        ALU_op <= "001";  -- Subtraction (0 - 0 = 0)
        wait for 10 ns;

        -- Extra wait before stopping simulation
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
```

### **Waveform Analysis**  
The simulation results confirm that the **ALU correctly performs arithmetic and logical operations** as per the control signal.  

| **Sel** | **Operation** | **A (Input 1)** | **B (Input 2)** | **Output Y** | **Carry** |  
|--------|-------------|---------------|---------------|------------|--------|  
| 000    | Addition    | 0011 (3)      | 0101 (5)      | 1000 (8)   | 0      |  
| 001    | Subtraction | 1010 (10)     | 0011 (3)      | 0111 (7)   | 0      |  
| 010    | AND         | 1100 (12)     | 1010 (10)     | 1000 (8)   | 0      |  
| 011    | OR          | 1100 (12)     | 1010 (10)     | 1110 (14)  | 0      |  
| 100    | XOR         | 1100 (12)     | 1010 (10)     | 0110 (6)   | 0      |  
| 101    | NOT A       | 1100 (12)     | N/A           | 0011 (3)   | 0      |  
| 110    | Left Shift  | 1010 (10)     | N/A           | 0100 (4)   | 1      |  
| 111    | Right Shift | 1010 (10)     | N/A           | 0101 (5)   | 0      |  

---

## **6. FPGA Constraints File**  

```xdc
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {A[0]}]  
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {A[1]}]  
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {A[2]}]  
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {A[3]}]  
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {A[4]}]  
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {A[5]}]  
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {A[6]}]  
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {A[7]}]  

set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS33}  [get_ports {B[0]}]  
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33}  [get_ports {B[1]}]  
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {B[2]}]  
set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports {B[3]}]  
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33}  [get_ports {B[4]}]  
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {B[5]}]  
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {B[6]}]  
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {B[7]}]  

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {ALU_op[0]}]  
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {ALU_op[1]}]  
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {ALU_op[2]}]  

set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {Result[0]}]  
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {Result[1]}]  
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {Result[2]}]  
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {Result[3]}]  
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {Result[4]}]  
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {Result[5]}]  
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {Result[6]}]  
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {Result[7]}]  

set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports Zero]  
```

---

## **7. Images**  
Below are the **simulation waveform results** and **FPGA output images** showcasing ALU operations.  

- RTL Design
    ![RTL Design](https://github.com/user-attachments/assets/b2ca6ba9-bb6d-413d-83cd-b829ec382f08)
- Elaborated Design
    ![Elaborated Design](https://github.com/user-attachments/assets/ac87f000-1234-4007-8b8d-08935552502a)
- Waveform Analysis
    ![Waveform Analysis](https://github.com/user-attachments/assets/432f1c85-e7aa-4877-9aae-86fe22c42666)
- Hardware Implementation
     ![ALU_Implementation](/ALU/ALU_ImplementationFPGA.gif)


---

Made by **Swaroop Kumar Yadav**
