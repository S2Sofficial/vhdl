## 📂 Shift Register (4-bit)

### 📌 Description

This project implements a **4-bit shift register** in VHDL with the following operations based on a 2-bit select input:

### 📖 Theory

A **Shift Register** is a sequential logic circuit used to store and manipulate binary data. It consists of flip-flops connected in a chain, where data is shifted in or out based on the clock signal.

This project implements a **4-bit universal shift register** that can:

1. **Hold Current Data ("00")**  
   - The register retains its current state.
   - No change in bit values.

2. **Shift Right ("01")**  
   - Each bit is moved one position to the right.
   - MSB (bit 3) receives the input `srsi` (Shift Right Serial Input).
   - LSB (bit 0) is discarded.
   - Useful for division by 2 in binary or serial data output.

3. **Shift Left ("10")**  
   - Each bit is moved one position to the left.
   - LSB (bit 0) receives the input `slsi` (Shift Left Serial Input).
   - MSB (bit 3) is discarded.
   - Useful for multiplication by 2 or serial data input.

4. **Parallel Load ("11")**  
   - Loads a 4-bit value from the input `ba` (Bus Input) directly into the register.
   - All bits are updated simultaneously in one clock cycle.
   - Useful for initializing or quickly changing the register content.

#### ⏱ Clock and Reset
- The register is **edge-triggered**, meaning it operates on the **rising edge of the clock**.
- A **synchronous reset** sets the register to `0000` regardless of the select input.

---

### ⚙️ Applications
- Serial-to-parallel and parallel-to-serial conversion
- Temporary data storage
- Data movement and manipulation
- Counters and data path control in digital systems

---

### 🧠 Core Logic (Behavioral Architecture)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftReg is port (
    rst, clk:in std_logic;
    s:in std_logic_vector(1 downto 0);
    ba:in std_logic_vector(3 downto 0);
    srsi,slsi:in std_logic;
    rc:inout std_logic_vector ( 3 downto 0 )
    );     
end ShiftReg;

architecture Behavioral of ShiftReg is

begin
  process (clk)
  begin
     if rising_edge(clk) then
       if rst ='1' then rc <= "0000";
       else
          case s is 
              when "00" => rc <= rc;
              when "01" => rc(3) <= srsi; rc(2) <= rc(3); rc(1) <= rc(2); rc(0) <= rc(1);
              when "10" => rc(3) <= rc(2); rc(2) <= rc(1); rc(1) <= rc(0); rc(0) <= slsi;
              when "11" => rc <= ba;
              when others => null;
          end case;
       end if;
    end if;
  end process;

end Behavioral;
```

---

### 🧪 Testbench

```vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_ShiftReg IS
END tb_ShiftReg;

ARCHITECTURE behavior OF tb_ShiftReg IS 

    -- Component Declaration
    COMPONENT ShiftReg
    PORT(
         rst : IN std_logic;
         clk : IN std_logic;
         s : IN std_logic_vector(1 downto 0);
         ba : IN std_logic_vector(3 downto 0);
         srsi : IN std_logic;
         slsi : IN std_logic;
         rc : INOUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

    -- Testbench signals
    signal rst : std_logic := '0';
    signal clk : std_logic := '0';
    signal s : std_logic_vector(1 downto 0) := "00";
    signal ba : std_logic_vector(3 downto 0) := "0000";
    signal srsi : std_logic := '0';
    signal slsi : std_logic := '0';
    signal rc : std_logic_vector(3 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ShiftReg PORT MAP (
          rst => rst,
          clk => clk,
          s => s,
          ba => ba,
          srsi => srsi,
          slsi => slsi,
          rc => rc
        );

    -- Clock process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- Reset the shift register
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

        -- Test Parallel Load
        ba <= "1010";
        s <= "11";          -- Load value into rc
        wait for clk_period;

        -- Hold value (No operation)
        s <= "00";
        wait for clk_period;

        -- Shift Right
        srsi <= '1';        -- New bit from right side
        s <= "01";
        wait for clk_period;

        srsi <= '0';
        wait for clk_period;

        -- Shift Left
        slsi <= '1';        -- New bit from left side
        s <= "10";
        wait for clk_period;

        slsi <= '0';
        wait for clk_period;

        -- Another Parallel Load
        ba <= "1100";
        s <= "11";
        wait for clk_period;

        -- Hold
        s <= "00";
        wait for clk_period;

        wait;
    end process;

END;
```

---

### 🧮 Example Output (Simulation Summary)

| Time | `s`   | Operation      | Notes                    |
|------|-------|----------------|--------------------------|
| 0ns  | Reset | Clear to 0000  |                         |
| 20ns | "11"  | Parallel Load  | rc = 1010                |
| 30ns | "00"  | Hold           | rc = 1010                |
| 40ns | "01"  | Right Shift    | rc = 1101 (srsi='1')     |
| 60ns | "10"  | Left Shift     | rc = 1010 (slsi='1')     |
| 80ns | "11"  | Parallel Load  | rc = 1100                |
| 90ns | "00"  | Hold           | rc = 1100                |

---

### Status  
- [x] Simulation ✅
  ![Simulation](https://github.com/user-attachments/assets/487438e8-f6af-4dba-82f2-c921cbafee6a)

- [x] Synthesized ✅
  ![Synthesized Design](https://github.com/user-attachments/assets/253f23ee-985f-4caa-8545-6667992d0175)

- [x] Hardware Tested ✅
