# 3-to-8 Decoder using VHDL  

## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [Decoder Concept](#decoder-concept)  
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
This project implements a **3-to-8 decoder** using **VHDL**. The decoder takes a **3-bit input (A)** and produces an **8-bit output (Y)**, where only **one output bit is HIGH** corresponding to the given binary input, and all others are LOW.  

---

## **2. Theory**  

### **Decoder Concept**  
A **3-to-8 decoder** translates a **3-bit binary input (A)** into a **one-hot 8-bit output (Y)**, where only the selected output bit is HIGH (`1`) and the rest are LOW (`0`).  

### **Truth Table**  

| **A(2:0) Input** | **Y(7:0) Output** |  
|------------------|------------------|  
| 000 | 00000001 |  
| 001 | 00000010 |  
| 010 | 00000100 |  
| 011 | 00001000 |  
| 100 | 00010000 |  
| 101 | 00100000 |  
| 110 | 01000000 |  
| 111 | 10000000 |  

---

## **3. Working**  

1. The **3-bit input (A)** selects one of **eight possible outputs (Y[7:0])**.  
2. The decoder uses a **case statement** to determine which output should be HIGH (`1`).  
3. All other output bits remain LOW (`0`).  
4. If the input does not match any valid case, the output defaults to `"00000000"`.  

---

## **4. VHDL Code Implementation**  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3to8 is
    Port ( A : in  STD_LOGIC_VECTOR(2 downto 0);  
           Y : out  STD_LOGIC_VECTOR(7 downto 0)  
           );
end decoder3to8;

architecture Behavioral of decoder3to8 is
begin
    process(A)
    begin
        case A is
            when "000" => Y <= "00000001";
            when "001" => Y <= "00000010";
            when "010" => Y <= "00000100";
            when "011" => Y <= "00001000";
            when "100" => Y <= "00010000";
            when "101" => Y <= "00100000";
            when "110" => Y <= "01000000";
            when "111" => Y <= "10000000";
            when others => Y <= "00000000"; 
        end case;
    end process;
end Behavioral;
```

---

## **5. Simulation in Xilinx Vivado**  

### **Testbench Creation**  
A testbench was written to verify the decoder's output for all possible input combinations.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_decoder_3to8 is
end tb_decoder_3to8;

architecture behavior of tb_decoder_3to8 is
    signal A : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Y : STD_LOGIC_VECTOR(7 downto 0);

begin
    uut: entity work.decoder3to8
        port map (
            A => A,
            Y => Y
        );

    stim_proc: process
    begin
        A <= "000"; wait for 10 ns;
        A <= "001"; wait for 10 ns;
        A <= "010"; wait for 10 ns;
        A <= "011"; wait for 10 ns;
        A <= "100"; wait for 10 ns;
        A <= "101"; wait for 10 ns;
        A <= "110"; wait for 10 ns;
        A <= "111"; wait for 10 ns;
        wait;
    end process;
end behavior;
```

### **Waveform Analysis**  
The simulation results confirm that the **decoder correctly sets only one output bit HIGH** based on the input.  

| **A Input** | **Y Output** |  
|------------|------------|  
| 000 | 00000001 |  
| 001 | 00000010 |  
| 010 | 00000100 |  
| 011 | 00001000 |  
| 100 | 00010000 |  
| 101 | 00100000 |  
| 110 | 01000000 |  
| 111 | 10000000 |  

---

## **6. FPGA Constraints File**  

```xdc
set_property IOSTANDARD LVCMOS33 [get_ports {A[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {A[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[0]}]
set_property DRIVE 12 [get_ports {Y[7]}]
set_property PACKAGE_PIN J15 [get_ports {A[0]}]
set_property PACKAGE_PIN L16 [get_ports {A[1]}]
set_property PACKAGE_PIN M13 [get_ports {A[2]}]
set_property PACKAGE_PIN H17 [get_ports {Y[0]}]
set_property PACKAGE_PIN K15 [get_ports {Y[1]}]
set_property PACKAGE_PIN J13 [get_ports {Y[2]}]
set_property PACKAGE_PIN N14 [get_ports {Y[3]}]
set_property PACKAGE_PIN R18 [get_ports {Y[4]}]
set_property PACKAGE_PIN V17 [get_ports {Y[5]}]
set_property PACKAGE_PIN U17 [get_ports {Y[6]}]
set_property PACKAGE_PIN U16 [get_ports {Y[7]}]
```

---

## **7. Images**  
Below are the **simulation waveform results** and **FPGA output images** showcasing the decoder's functionality.  

- **Implementation Design**
  ![image](https://github.com/user-attachments/assets/0b724970-af88-4d3f-956a-d3dbf9bf5c6c)
- **Wavwform Analysis**
![image](https://github.com/user-attachments/assets/ce9630c8-a842-4c35-bcd1-de88ade76e4f)
---

Made by **Swaroop Kumar Yadav**
