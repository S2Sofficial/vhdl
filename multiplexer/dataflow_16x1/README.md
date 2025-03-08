# 16x1 Multiplexer in VHDL - Dataflow Modeling  

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Theory](#theory)  
   - [Multiplexer Explanation](#multiplexer-explanation)  
   - [Truth Table](#truth-table)  
3. [VHDL Code Implementation](#vhdl-code-implementation)  
4. [Simulation in Xilinx Vivado](#simulation-in-xilinx-vivado)  
   - [Testbench Creation](#testbench-creation)  
   - [Waveform Analysis](#waveform-analysis)  
5. [Images](#images)  

---

## Project Overview  
A **16x1 Multiplexer (MUX)** is a combinational circuit that selects one of sixteen input signals based on four **select lines** and forwards it to the output.  

This project implements a **16x1 MUX using Dataflow Modeling** in **VHDL**, simulates it in **Xilinx Vivado**, and verifies its correctness.  

---

## Theory  

### Multiplexer Explanation  
A **16x1 Multiplexer** has:  
- **16 Input lines:** `D(0) - D(15)`  
- **4 Select lines:** `Sel(3) - Sel(0)`  
- **1 Output line:** `Y`  

The **select lines (Sel[3:0])** determine which input is passed to the output.  

### Truth Table  

| Sel (Binary) | Output (Y) |  
|-------------|-----------|  
| 0000        | D(0)     |  
| 0001        | D(1)     |  
| 0010        | D(2)     |  
| 0011        | D(3)     |  
| 0100        | D(4)     |  
| 0101        | D(5)     |  
| 0110        | D(6)     |  
| 0111        | D(7)     |  
| 1000        | D(8)     |  
| 1001        | D(9)     |  
| 1010        | D(10)    |  
| 1011        | D(11)    |  
| 1100        | D(12)    |  
| 1101        | D(13)    |  
| 1110        | D(14)    |  
| 1111        | D(15)    |  

---

## VHDL Code Implementation  
The **Dataflow Modeling** approach is used with the `with select` statement to implement the multiplexer.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16x1_dataflow is
    Port ( D : in std_logic_vector (15 downto 0);
           Sel : in std_logic_vector (3 downto 0);
           Y : out STD_LOGIC);
end mux_16x1_dataflow;

architecture Dataflow of mux_16x1_dataflow is

begin
    with Sel select 
        Y <= D(0) when "0000",
            D(1) when "0001",
             D(2) when "0010",
             D(3) when "0011",
             D(4) when "0100",
             D(5) when "0101",
             D(6) when "0110",
             D(7) when "0111",
             D(8) when "1000",
             D(9) when "1001",
             D(10) when "1010",
             D(11)when "1011",
             D(12) when "1100",
             D(13) when "1101",
             D(14) when "1110",
             D(15) when "1111",
            '0' when others;
            
            

end Dataflow;
```

---

## Simulation in Xilinx Vivado  
The **16x1 MUX** functionality was verified by simulating its VHDL implementation in **Xilinx Vivado**.  
![image](https://github.com/user-attachments/assets/14bea5da-13c1-4668-9ca4-4453dcff61fc)


### Testbench Creation  
A testbench was written to apply all possible input and select line combinations.  

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16x1_df_tb is
end mux_16x1_df_tb;

architecture Behavioral of mux_16x1_df_tb is
    signal D  : STD_LOGIC_VECTOR(15 downto 0);
    signal Sel : STD_LOGIC_VECTOR(3 downto 0);
    signal Y   : STD_LOGIC;
begin
    -- Instantiate the UUT (Unit Under Test)
    uut: entity work.mux_16x1_dataflow port map (D => D, Sel => Sel, Y => Y);

    process
    begin
        -- Test Case 1: Select D(0)
        D <= "0000000000000001"; Sel <= "0000"; wait for 20 ns;
        -- Test Case 2: Select D(5)
        D <= "0000010000000000"; Sel <= "0101"; wait for 20 ns;
        -- Test Case 3: Select D(10)
        D <= "0000000001000000"; Sel <= "1010"; wait for 20 ns;
        -- Test Case 4: Select D(15)
        D <= "1000000000000000"; Sel <= "1111"; wait for 20 ns;
        wait;
    end process;
end Behavioral;
```

### Waveform Analysis  
The simulation results confirm that the **MUX correctly selects the input based on the select lines**.  

| **Sel (Binary)** | **Output (Y)** |  
|------------------|---------------|  
| 0000            | D(0)          |  
| 0001            | D(1)          |  
| 0010            | D(2)          |  
| 0011            | D(3)          |  
| 0100            | D(4)          |  
| 0101            | D(5)          |  
| 0110            | D(6)          |  
| 0111            | D(7)          |  
| 1000            | D(8)          |  
| 1001            | D(9)          |  
| 1010            | D(10)         |  
| 1011            | D(11)         |  
| 1100            | D(12)         |  
| 1101            | D(13)         |  
| 1110            | D(14)         |  
| 1111            | D(15)         |  

---

## Images  
Here are the screenshots of the **16x1 MUX simulation results**:  

![image](https://github.com/user-attachments/assets/3c50403e-5239-49e5-9766-a98531eb9c72)

---

Made by **Swaroop Kumar Yadav**  
