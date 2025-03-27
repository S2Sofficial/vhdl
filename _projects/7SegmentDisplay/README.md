# Interfacing Seven Segment Display with Nexys A7 FPGA Board  

## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [Seven Segment Display Basics](#seven-segment-display-basics)  
   - [Binary to 7-Segment Mapping](#binary-to-7-segment-mapping)  
3. [Working](#3-working)  
4. [VHDL Code Implementation](#4-vhdl-code-implementation)  
5. [Simulation in Xilinx Vivado](#5-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
6. [FPGA Constraints File](#6-fpga-constraints-file)  
7. [Images](#7-images)  

---

## **1. Project Overview**  
This project demonstrates the interfacing of a **seven-segment display** with the **Nexys A7 FPGA board** using **VHDL**. The design takes a **4-bit binary input from switches** and converts it into a **7-segment display format**, allowing numbers from **0 to F (hexadecimal)** to be displayed. Additionally, a **mode selection switch** determines whether the display operates in **hexadecimal mode (0-F) or decimal mode (0-9 with blanking for invalid inputs).**  

---

## **2. Theory**  

### **Seven Segment Display Basics**  
A **seven-segment display** consists of seven LEDs labeled **a to g**. By turning specific segments ON or OFF, numbers and some characters can be displayed. In **Common Anode displays**, logic `0` (LOW) turns a segment ON, while logic `1` (HIGH) turns it OFF.  

### **Binary to 7-Segment Mapping**  
Each digit from **0 to F (hexadecimal)** has a predefined segment pattern. These patterns are stored in a lookup table and selected based on the input value.  

Example segment encoding (Active LOW for Common Anode Display):  

| **Binary Input** | **Hexadecimal** | **7-Segment Output (a-g)** |  
|-----------------|---------------|----------------------------|  
| 0000 | 0 | 1000000 |  
| 0001 | 1 | 1111001 |  
| 0010 | 2 | 0100100 |  
| 0011 | 3 | 0110000 |  
| 0100 | 4 | 0011001 |  
| 0101 | 5 | 0010010 |  
| 0110 | 6 | 0000010 |  
| 0111 | 7 | 1111000 |  
| 1000 | 8 | 0000000 |  
| 1001 | 9 | 0010000 |  
| 1010 | A | 0001000 |  
| 1011 | B | 0000011 |  
| 1100 | C | 1000110 |  
| 1101 | D | 0100001 |  
| 1110 | E | 0000110 |  
| 1111 | F | 0001110 |  

---

## **3. Working**  

1. The **4-bit binary input** is received from the FPGA **switches**.  
2. The **mode selection switch** decides whether to display:  
   - **Hexadecimal (0-F)**  
   - **Decimal (0-9) with blanking for invalid inputs (A-F)**  
3. The **VHDL process** uses a **lookup table (array)** to map the input value to a **7-segment encoding**.  
4. The **7-segment display** is driven with an **active LOW output**, ensuring correct digit representation.  
5. If the mode is **hexadecimal**, all values from `0000` to `1111` (0 to F) are displayed.  
6. If the mode is **decimal**, values from `0000` to `1001` (0 to 9) are displayed, and `A-F` values result in a blank display (`1111111`).  
---

## **4. VHDL Code Implementation**  
The design uses a lookup table (`seg_map`) for segment encoding and a **process block** for conditional display selection.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSegment is
    Port ( binary_in : in STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input (0-15)
           hex_out   : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment output
           mode      : in STD_LOGIC);  -- '0' = Hex, '1' = Decimal
end SevenSegment;

architecture Behavioral of SevenSegment is
    -- Active LOW 7-segment encoding (Common Anode)
    type seg_array is array (0 to 15) of STD_LOGIC_VECTOR(6 downto 0);
    signal seg_map : seg_array := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- B
        "1000110", -- C
        "0100001", -- D
        "0000110", -- E
        "0001110"  -- F
    );
begin
    process(binary_in, mode)
    begin
        if mode = '0' then
            -- Hex Mode (0-F)
            hex_out <= seg_map(to_integer(unsigned(binary_in)));
        else
            -- Decimal Mode (0-9), blank for invalid inputs
            case to_integer(unsigned(binary_in)) is
                when 0 to 9 => hex_out <= seg_map(to_integer(unsigned(binary_in)));
                when others => hex_out <= "1111111"; -- Blank (Active-Low Display)
            end case;
        end if;
    end process;
end Behavioral;
```

---

## **5. Simulation in Xilinx Vivado**  

### **Testbench Creation**  
A testbench was written to validate all possible input values and mode selections.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSegment_tb is
end SevenSegment_tb;

architecture Behavioral of SevenSegment_tb is
    -- Component Declaration
    component SevenSegment
        Port (
            binary_in : in STD_LOGIC_VECTOR(3 downto 0);
            hex_out   : out STD_LOGIC_VECTOR(6 downto 0);
            mode      : in STD_LOGIC
        );
    end component;
    
    -- Test Signals
    signal binary_in_tb : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal hex_out_tb   : STD_LOGIC_VECTOR(6 downto 0);
    signal mode_tb      : STD_LOGIC := '0';  -- Start with Hexadecimal Mode
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: SevenSegment port map (
        binary_in => binary_in_tb,
        hex_out   => hex_out_tb,
        mode      => mode_tb
    );

    -- Test Process
    process
    begin
        -- Test Hexadecimal Mode (0-F)
        mode_tb <= '0';  
        for i in 0 to 15 loop
            binary_in_tb <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        
        -- Test Decimal Mode (0-9, blank for 10-15)
        mode_tb <= '1';  
        for i in 0 to 15 loop
            binary_in_tb <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        
        -- End Simulation
        wait;
    end process;
   
end Behavioral;
```

### **Waveform Analysis**  
The simulation results confirm that the **7-segment display correctly represents the given inputs.**  

| **Binary Input** | **Mode** | **7-Segment Output** |  
|-----------------|---------|----------------------|  
| 0000 | Hex | 1000000 |  
| 0001 | Hex | 1111001 |  
| 0010 | Hex | 0100100 |  
| 1010 | Hex | 0001000 (A) |  
| 1100 | Hex | 1000110 (C) |  
| 1010 | Decimal | 1111111 (Blank) |  
| 0110 | Decimal | 0000010 (6) |  

---

## **6. FPGA Constraints File**  
To map the FPGA switches and display segments, the following **constraints file** is used.  

```xdc
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports binary_in[0]]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports binary_in[1]]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports binary_in[2]]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports binary_in[3]]

set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports mode]

set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports hex_out[0]]  
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports hex_out[1]]  
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports hex_out[2]]  
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports hex_out[3]]  
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports hex_out[4]]  
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports hex_out[5]]  
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports hex_out[6]]  

```

---

## **7. Images**  
Below are the **simulation waveform results** and **FPGA output images** showcasing the seven-segment display functionality.  
- **Implementation Schematic:**
![image](https://github.com/user-attachments/assets/a303e0d6-5dca-45cc-b125-e09105e54854)
- **RTL Schematic:**
![RTL_Design](https://github.com/user-attachments/assets/0f4947e6-b339-414d-be64-2d1752b0cfb5)
- **Waveform Analysis:**
![mode0&mode1](https://github.com/user-attachments/assets/551bfc33-968c-4477-8b8b-f4127b4e4506)



---

Made by **Swaroop Kumar Yadav**
