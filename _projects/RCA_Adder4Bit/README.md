# 4-bit Ripple Carry Adder in VHDL - Structural Modelling

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Ripple Carry Adder Explanation](#ripple-carry-adder-explanation)  
   - [Truth Table](#truth-table)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [FPGA Hardware Implementation](#fpga-hardware-implementation)  
6. [Images](#images)  

---

## Project Overview  
A **4-bit Ripple Carry Adder (RCA)** is a combinational circuit used for adding two 4-bit binary numbers. It consists of four **Full Adders**, where the carry from each stage propagates to the next stage.  

This project implements a **4-bit Ripple Carry Adder using Structural Modeling** in **VHDL**, simulates it in **Xilinx Vivado**, and successfully implements it on the **Artix-7 Nexys A7-100T FPGA Board**.  

---

## Theory  

### Ripple Carry Adder Explanation  
A **4-bit Ripple Carry Adder**:  
- Takes **two 4-bit inputs (A & B)** and a **carry-in (Cin)**  
- Produces a **4-bit sum output (S)** and a **carry-out (Cout)**  
- The carry propagates sequentially through each Full Adder  

### Truth Table  

| A3 A2 A1 A0 | B3 B2 B1 B0 | Cin | Sum (S3 S2 S1 S0) | Cout |  
|-------------|-------------|-----|-------------------|------|  
| 0000        | 0000        |  0  | 0000              |  0   |  
| 0001        | 0001        |  0  | 0010              |  0   |  
| 0010        | 0011        |  0  | 0101              |  0   |  
| 0111        | 0001        |  1  | 1001              |  0   |  
| 1111        | 1111        |  0  | 1110              |  1   |  

---

## VHDL Code Implementation  
The **Structural Modeling** approach is used to build the **4-bit Ripple Carry Adder** using four Full Adders in `Adder4Bit.vhd` file.

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder4Bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input A
        B    : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input B
        Cin  : in  STD_LOGIC;  -- Carry-in
        Sum  : out STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit sum output
        Cout : out STD_LOGIC  -- Carry-out
    );
end Adder4Bit;

architecture Structural of Adder4Bit is
    -- Component declaration for Full Adder
    component FullAdder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -- Signals for carry propagation
    signal C : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Connecting four full adders in a ripple carry adder structure
    FA0: FullAdder port map(A(0), B(0), Cin,  Sum(0), C(0));
    FA1: FullAdder port map(A(1), B(1), C(0), Sum(1), C(1));
    FA2: FullAdder port map(A(2), B(2), C(1), Sum(2), C(2));
    FA3: FullAdder port map(A(3), B(3), C(2), Sum(3), Cout);

end Structural;
```
and `FullAdder.vhd` module
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end FullAdder;

architecture Structural of FullAdder is
begin
    Sum  <= A XOR B XOR Cin;
    Cout <= (A AND B) OR (B AND Cin) OR (A AND Cin);
end Structural;

```
---

## Constraints in Xilinx Vivado  
The **4-bit Ripple Carry Adder** was verified through given constraints file specifying ports details to execute via **Xilinx Vivado** to the FPGA board.
```xdc
# ========= INPUT PINS (Switches) =========
set_property PACKAGE_PIN W5 [get_ports {A[0]}]  
set_property PACKAGE_PIN V5 [get_ports {A[1]}]
set_property PACKAGE_PIN U5 [get_ports {A[2]}]
set_property PACKAGE_PIN T5 [get_ports {A[3]}]

set_property PACKAGE_PIN W6 [get_ports {B[0]}]
set_property PACKAGE_PIN V6 [get_ports {B[1]}]
set_property PACKAGE_PIN U6 [get_ports {B[2]}]
set_property PACKAGE_PIN T6 [get_ports {B[3]}]

set_property PACKAGE_PIN R6 [get_ports Cin]

# ========= OUTPUT PINS (LEDs) =========
set_property PACKAGE_PIN P6 [get_ports {Sum[0]}]
set_property PACKAGE_PIN N6 [get_ports {Sum[1]}]
set_property PACKAGE_PIN M6 [get_ports {Sum[2]}]
set_property PACKAGE_PIN L6 [get_ports {Sum[3]}]

set_property PACKAGE_PIN K6 [get_ports Cout]

# ========= IO Standard Settings =========
set_property IOSTANDARD LVCMOS33 [get_ports {A[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Sum[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports Cin]
set_property IOSTANDARD LVCMOS33 [get_ports Cout]
```
*Note: Pin number may vary with the board used.*

### Testbench Creation  
A testbench was written to apply multiple input combinations and verify the sum and carry outputs.  

```vhdl
-- To be updated
```

### Waveform Analysis  
The simulation confirmed correct addition operation across various input conditions.  

| **A**  | **B**  | **Cin** | **Sum**  | **Cout** |  
|--------|--------|--------|--------|--------|  
| 0000   | 0000   | 0      | 0000   | 0      |  
| 0001   | 0010   | 0      | 0011   | 0      |  
| 0100   | 0011   | 0      | 0111   | 0      |  
| 1100   | 0110   | 1      | 0011   | 1      |  
| 1111   | 1111   | 0      | 1110   | 1      |  

---

## FPGA Hardware Implementation  
The **4-bit Ripple Carry Adder** was successfully implemented on the **Artix-7 Nexys A7-100T FPGA Board** using **Xilinx Vivado**. The input values were assigned to switches, and the sum and carry outputs were displayed using onboard LEDs.  

<video width="640" height="360" controls>
  <source src="https://github.com/user-attachments/assets/3e5c9667-187f-4d08-aa1f-0ac3f3d70b80" type="video/mp4">
</video>

https://github.com/user-attachments/assets/3e5c9667-187f-4d08-aa1f-0ac3f3d70b80


---

## Images  
Here are the screenshots of the **4-bit Ripple Carry Adder simulation and FPGA implementation**:  
![RTL Design](https://github.com/user-attachments/assets/dd3b5a3c-3844-41d0-a922-db8f4fc4c1cf)



---

Made by **Swaroop Kumar Yadav**  
