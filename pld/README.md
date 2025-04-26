# Programmable Logic Devices: Theory and VHDL Examples

---

## 1. **PROM (Programmable Read-Only Memory)**
### Theory
- Non-volatile memory programmed once
- Fixed AND array + programmable OR array
- Stores permanent data (e.g., firmware)

### VHDL Code (4x4 ROM)
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PROM is
    Port ( addr : in  STD_LOGIC_VECTOR(1 downto 0);
           data : out STD_LOGIC_VECTOR(3 downto 0));
end PROM;

architecture Behavioral of PROM is
begin
    with addr select data <=
        "0001" when "00",  -- Address 0
        "0010" when "01",  -- Address 1
        "0100" when "10",  -- Address 2
        "1000" when others; -- Address 3
end Behavioral;
```

---

## 2. **PLA (Programmable Logic Array)**
### Theory
- Both AND & OR arrays programmable
- Implements custom combinational logic
- Flexible but expensive

### VHDL Code (F = AB + CD)
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLA is
    Port ( A,B,C,D : in  STD_LOGIC;
           F : out STD_LOGIC);
end PLA;

architecture Behavioral of PLA is
begin
    F <= (A AND B) OR (C AND D); -- Programmable AND-OR
end Behavioral;
```

---

## 3. **PAL (Programmable Array Logic)**
### Theory
- Programmable AND array + fixed OR array
- Cost-effective for simple logic
- Limited product terms per output

### VHDL Code (F = AB + CD)
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PAL is
    Port ( A,B,C,D : in  STD_LOGIC;
           F : out STD_LOGIC);
end PAL;

architecture Behavioral of PAL is
begin
    F <= (A AND B) OR (C AND D); -- Fixed OR structure
end Behavioral;
```

---

## 4. **CPLD (Complex PLD)**
### Theory
- Multiple PAL blocks + programmable interconnect
- Non-volatile configuration
- Good for medium complexity designs

### VHDL Code (D Flip-Flop)
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPLD is
    Port ( clk, rst, D : in  STD_LOGIC;
           Q : out STD_LOGIC);
end CPLD;

architecture Behavioral of CPLD is
begin
    process(clk, rst)
    begin
        if rst='1' then Q <= '0';
        elsif rising_edge(clk) then
            Q <= D;  -- Registered logic
        end if;
    end process;
end Behavioral;
```

---

## 5. **FPGA (Field-Programmable Gate Array)**
### Theory
- Configurable Logic Blocks (CLBs) + programmable routing
- Volatile (SRAM-based) configuration
- Handles complex digital systems

### VHDL Code (4-bit Counter)
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FPGA_Counter is
    Port ( clk : in  STD_LOGIC;
           count : out STD_LOGIC_VECTOR(3 downto 0));
end FPGA_Counter;

architecture Behavioral of FPGA_Counter is
    signal temp : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            temp <= temp + 1;  -- Using CLBs
        end if;
    end process;
    count <= temp;
end Behavioral;
```

---

## Comparison Table

| Device  | Programmability         | Volatility | Logic Capacity | Speed     | Reconfigurable |
|---------|-------------------------|------------|----------------|-----------|----------------|
| **PROM**| AND fixed, OR programmable | Non-volatile | Low          | Slow     | No            |
| **PLA** | AND & OR programmable    | Non-volatile | Medium       | Moderate | No            |
| **PAL** | AND programmable, OR fixed | Non-volatile | Medium       | Fast     | No            |
| **CPLD**| PAL blocks + interconnect | Non-volatile | Medium-High | Fast     | No            |
| **FPGA**| CLBs + routing           | Volatile    | Very High     | Moderate | Yes           |

--- 

Made by Swaroop Kumar Yadav
