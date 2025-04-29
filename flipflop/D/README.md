# D Flip-Flop (D-FF) Design and Simulation Using VHDL
![image](https://github.com/user-attachments/assets/5e81b3be-b13f-4790-b2bc-78f8635b163d)

## Introduction
This project implements a **D Flip-Flop (D-FF)** using VHDL, featuring an **asynchronous reset** and positive-edge triggered clock. The flip-flop captures the input `D` on the rising edge of the clock and outputs it to `Q`. The design is simulated using a testbench and is compatible with FPGA implementation using a constraints file.

## Objective
- Implement a D Flip-Flop with asynchronous reset.
- Simulate the behavior using VHDL testbench.
- Prepare constraint definitions for real FPGA implementation.

## VHDL Code

### Design File (`d_ff.vhd`)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
    Port ( clk, rst, D : in  STD_LOGIC;
           Q : out STD_LOGIC);
end D_FF;

architecture Behavioral of D_FF is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            Q <= '0';  -- Async reset
        elsif rising_edge(clk) then
            Q <= D;    -- Store input on clock edge
        end if;
    end process;
end Behavioral;
```

---

### Testbench File (`tb_d_ff.vhd`)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_ff is
end tb_d_ff;

architecture Behavioral of tb_d_ff is
    signal clk, rst, D : STD_LOGIC := '0';
    signal Q : STD_LOGIC;

    component D_FF
        Port ( clk, rst, D : in  STD_LOGIC;
               Q : out STD_LOGIC);
    end component;

begin
    uut: D_FF Port Map (
        clk => clk,
        rst => rst,
        D => D,
        Q => Q
    );

    clk_process: process
    begin
        while true loop
            clk <= '0'; wait for 10 ns;
            clk <= '1'; wait for 10 ns;
        end loop;
    end process;

    stim_proc: process
    begin
        -- Apply reset
        rst <= '1'; wait for 15 ns;
        rst <= '0'; wait for 10 ns;

        -- Test input D = '1'
        D <= '1'; wait for 20 ns;

        -- Test input D = '0'
        D <= '0'; wait for 20 ns;

        -- Test input D = '1'
        D <= '1'; wait for 20 ns;

        -- End simulation
        wait;
    end process;
end Behavioral;
```

---

### Constraints File (XDC Template)

```xdc
## Clock
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports clk]

## Reset
# set_property PACKAGE_PIN V17 [get_ports rst]
# set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Data input
# set_property PACKAGE_PIN U17 [get_ports D]
# set_property IOSTANDARD LVCMOS33 [get_ports D]

## Output Q
# set_property PACKAGE_PIN U16 [get_ports Q]
# set_property IOSTANDARD LVCMOS33 [get_ports Q]
```

---

## Working

- **clk:** Clock signal. On every rising edge, the value of `D` is latched to `Q`.
- **rst:** Asynchronous reset. When `rst = '1'`, `Q` is immediately reset to '0', regardless of clock.
- **D:** Data input that gets stored in the flip-flop on clock edge.
- **Q:** Output that reflects stored value of `D`.

### Summary of Behavior
| clk ↑ | rst | D | Q (next) |
|-------|-----|---|----------|
|   ↑   |  0  | 0 |    0     |
|   ↑   |  0  | 1 |    1     |
|   ↑   |  1  | x |    0     |
|   ↑   |  0  | 1 |    1     |


![image](https://github.com/user-attachments/assets/39c27b5e-d17f-41f3-8fa7-94db12b9adef)

---

## Conclusion

The D Flip-Flop design using behavioral modeling in VHDL was successfully implemented and simulated. The asynchronous reset feature ensures immediate clearing, and clock sensitivity allows reliable data capture. The project is suitable for deployment on FPGA boards after proper pin mapping.


