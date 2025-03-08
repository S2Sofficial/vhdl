# Full Adder in VHDL - Behavioral modelling
## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [Boolean Expressions](#boolean-expressions)  
   - [Truth Table](#truth-table)  
3. [VHDL Code Implementation](#3-vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#4-simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [Images](#5-images)  

---

## **1. Project Overview**  
A **Full Adder** is a fundamental combinational circuit used to perform binary addition of three bits: **two input bits (A, B)** and a **carry-in (Cin)**. The circuit produces two outputs: **Sum (S) and Carry-out (Cout)**.  

This project involves designing a **Full Adder** in **VHDL**, simulating it in **Xilinx Vivado**, and verifying its correctness.  

---

## **2. Theory**  

### **Boolean Expressions**  
The Full Adder is an extension of the Half Adder. Its outputs are defined as:  

- **Sum (S) = A ⊕ B ⊕ Cin**  
- **Carry-out (Cout) = (A · B) + (Cin · (A ⊕ B))**  

### **Truth Table**  

| A | B | Cin | Sum (S) | Carry-out (Cout) |  
|---|---|----|--------|----------------|  
| 0 | 0 |  0  |   0    |        0        |  
| 0 | 0 |  1  |   1    |        0        |  
| 0 | 1 |  0  |   1    |        0        |  
| 0 | 1 |  1  |   0    |        1        |  
| 1 | 0 |  0  |   1    |        0        |  
| 1 | 0 |  1  |   0    |        1        |  
| 1 | 1 |  0  |   0    |        1        |  
| 1 | 1 |  1  |   1    |        1        |  

---

## **3. VHDL Code Implementation**  
The Full Adder circuit is implemented using the **XOR** and **AND** logic gates.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fullaadder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           sum : out STD_LOGIC;
           c_out : out STD_LOGIC);
end fullaadder;

architecture Behavioral of fullaadder is

begin
    sum <= a xor b xor c_in;
    c_out <= (a and b) or (c_in and  (a xor b));

end Behavioral;
```

---

## **4. Simulation in Xilinx Vivado**  
The Full Adder functionality was verified by simulating its VHDL implementation in **Xilinx Vivado**.  
![image](https://github.com/user-attachments/assets/2178fc3b-d58a-4d98-8988-0ae369c8f3fe)


### **Testbench Creation**  
A testbench was written to apply all possible input combinations and verify the **Sum** and **Carry-out** outputs.  

```vhdl

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_tb is
end full_adder_tb;

architecture Behavioral of full_adder_tb is
    signal a, b, c_in : STD_LOGIC := '0';
    signal sum, c_out : STD_LOGIC;
begin
    uut: entity work.fullaadder
        port map (
            a => a, 
            b => b, 
            c_in => c_in, 
            sum => sum, 
            c_out => c_out
        );

    -- Process to generate test cases
    process
    begin
        -- Test Cases (A, B, Cin)
        a <= '0'; b <= '0'; c_in <= '0'; wait for 10 ns; -- Sum = 0, Cout = 0
        a <= '0'; b <= '0'; c_in <= '1'; wait for 10 ns; -- Sum = 1, Cout = 0
        a <= '0'; b <= '1'; c_in <= '0'; wait for 10 ns; -- Sum = 1, Cout = 0
        a <= '0'; b <= '1'; c_in <= '1'; wait for 10 ns; -- Sum = 0, Cout = 1
        a <= '1'; b <= '0'; c_in <= '0'; wait for 10 ns; -- Sum = 1, Cout = 0
        a <= '1'; b <= '0'; c_in <= '1'; wait for 10 ns; -- Sum = 0, Cout = 1
        a <= '1'; b <= '1'; c_in <= '0'; wait for 10 ns; -- Sum = 0, Cout = 1
        a <= '1'; b <= '1'; c_in <= '1'; wait for 10 ns; -- Sum = 1, Cout = 1

        -- End simulation
        wait;
    end process;

end Behavioral;

```

### **Waveform Analysis**  
The simulation results were visualized using Vivado’s waveform viewer, confirming the correctness of the Full Adder’s outputs.  

| **Inputs** | **Outputs** |  
|-----------|------------|  
| A = 0, B = 0, Cin = 0 | Sum = 0, Cout = 0 |  
| A = 0, B = 0, Cin = 1 | Sum = 1, Cout = 0 |  
| A = 0, B = 1, Cin = 0 | Sum = 1, Cout = 0 |  
| A = 0, B = 1, Cin = 1 | Sum = 0, Cout = 1 |  
| A = 1, B = 0, Cin = 0 | Sum = 1, Cout = 0 |  
| A = 1, B = 0, Cin = 1 | Sum = 0, Cout = 1 |  
| A = 1, B = 1, Cin = 0 | Sum = 0, Cout = 1 |  
| A = 1, B = 1, Cin = 1 | Sum = 1, Cout = 1 |  

---

## **5. Images**  
Here are the screenshots of the Full Adder simulation results:  
![image](https://github.com/user-attachments/assets/8d19fd90-dbd6-45a6-ab18-7a7b44d3fcb5)


---

Made by **Swaroop Kumar Yadav**
