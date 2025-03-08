# Full Adder in VHDL - Dataflow Modeling

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Boolean Expressions](#boolean-expressions)  
   - [Truth Table](#truth-table)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [Images](#images)  

---

## Project Overview  
A **Full Adder** is a combinational circuit that performs binary addition of three bits:  
- **A and B (input bits)**  
- **Cin (carry-in bit)**  
- Produces two outputs: **Sum (S) and Carry-out (Cout)**  

This project implements a **Full Adder using Dataflow Modeling** in **VHDL**, simulates it in **Xilinx Vivado**, and verifies its correctness.  

---

## Theory  

### Boolean Expressions  
In Dataflow Modeling, the logic expressions for a Full Adder are directly implemented using operators:  

- **Sum (S) = A ⊕ B ⊕ Cin**  
- **Carry-out (Cout) = (A · B) + (Cin · (A ⊕ B))**  

### Truth Table  

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

## VHDL Code Implementation  
The **Dataflow Modeling** approach uses **Boolean expressions** and **assignments** instead of process blocks.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_dataflow is
 Port ( 
    a : in std_logic;
    b : in std_logic;
    c_in : in std_logic;
    sum : out std_logic;
    c_out : out std_logic
 );
end full_adder_dataflow;

architecture Dataflow of full_adder_dataflow is

begin
    sum <= a xor b xor c_in;
    c_out <= (a and b) or (b and c_in) or (a and c_in);

end Dataflow;
```

---

## Simulation in Xilinx Vivado  
The Full Adder functionality was verified by simulating its VHDL implementation in **Xilinx Vivado**.  
![image](https://github.com/user-attachments/assets/8860d700-9324-4f96-8b92-da28c942d05a)


### Testbench Creation  
A testbench was created to apply all possible input combinations and verify the **Sum** and **Carry-out** outputs.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_df_tb is
--  Port ( );
end full_adder_df_tb;

architecture Behavioral of full_adder_df_tb is
    signal a , b ,c_in : std_logic := '0';
    signal sum , c_out : std_logic ; 
begin
    uut: entity work.full_adder_dataflow
        port map (a=>a, b=>b, c_in=> c_in, sum=> sum, c_out=> c_out);
       
    process
    begin
        a <= '0'; b <= '0'; c_in <= '0'; wait for 20ns;
        a <= '0'; b <= '0'; c_in <= '1'; wait for 20ns;
        a <= '0'; b <= '1'; c_in <= '0'; wait for 20ns;
        a <= '0'; b <= '1'; c_in <= '1'; wait for 20ns;
        a <= '1'; b <= '0'; c_in <= '0'; wait for 20ns;
        a <= '1'; b <= '0'; c_in <= '1'; wait for 20ns;
        a <= '1'; b <= '1'; c_in <= '0'; wait for 20ns;
        a <= '1'; b <= '1'; c_in <= '1'; wait for 20ns;
        wait;
        end process; 

end Behavioral;
```

### Waveform Analysis  
The simulation results were visualized using Vivado’s waveform viewer, confirming the correctness of the Full Adder’s outputs.  

| **Inputs** | **Outputs** |  
|-----------|------------|  
| A = 0, B = 0, Cin = 0 → Sum = 0, Cout = 0 |  
| A = 0, B = 0, Cin = 1 → Sum = 1, Cout = 0 |  
| A = 0, B = 1, Cin = 0 → Sum = 1, Cout = 0 |  
| A = 0, B = 1, Cin = 1 → Sum = 0, Cout = 1 |  
| A = 1, B = 0, Cin = 0 → Sum = 1, Cout = 0 |  
| A = 1, B = 0, Cin = 1 → Sum = 0, Cout = 1 |  
| A = 1, B = 1, Cin = 0 → Sum = 0, Cout = 1 |  
| A = 1, B = 1, Cin = 1 → Sum = 1, Cout = 1 |  

---

## Images  
Here are the screenshots of the Full Adder simulation results:  
![image](https://github.com/user-attachments/assets/7ccc6e87-4608-42c2-a87d-4e873b54535c)

---

Made by **Swaroop Kumar Yadav**  
