# DEMUX (1x4) Design and Simulation Using VHDL
![RTL_Design](https://github.com/user-attachments/assets/fed5b12d-28cb-44d4-ab6f-fedc039d2951)
Fig.: RTL Design


## Introduction
We designed a **1x4 Demultiplexer (DEMUX)** using VHDL in this project. A DEMUX routes a single input signal to one of several outputs based on select lines. We implemented the design, wrote a testbench for simulation, and prepared it for FPGA implementation by creating a constraints file.

## Objective
- Design a 1x4 Demultiplexer (DEMUX) using behavioral modeling in VHDL.
- Simulate and verify the design using a testbench.
- Prepare constraints file for FPGA implementation (Nexys A7 board or similar).

## VHDL Code

### Design File (`demux.vhd`)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux is
    Port ( I : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR(1 downto 0);
           Y : out STD_LOGIC_VECTOR(3 downto 0));
end demux;

architecture Behavioral of demux is
begin
    process(I, S)
    begin
        Y <= (others => '0'); -- Default all outputs to 0
        case S is
            when "00"   => Y(0) <= I;
            when "01"   => Y(1) <= I;
            when "10"   => Y(2) <= I;
            when others => Y(3) <= I; -- "11" case
        end case;
    end process;
end Behavioral;
```

---

### Testbench File (`tb_demux.vhd`)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_demux is
end tb_demux;

architecture Behavioral of tb_demux is
    signal I : STD_LOGIC := '0';
    signal S : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal Y : STD_LOGIC_VECTOR(3 downto 0);

    -- Instantiate the Unit Under Test (UUT)
    component demux
        Port ( I : in  STD_LOGIC;
               S : in  STD_LOGIC_VECTOR(1 downto 0);
               Y : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

begin
    uut: demux Port Map (
        I => I,
        S => S,
        Y => Y
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1
        I <= '1'; S <= "00"; wait for 10 ns;
        -- Test case 2
        S <= "01"; wait for 10 ns;
        -- Test case 3
        S <= "10"; wait for 10 ns;
        -- Test case 4
        S <= "11"; wait for 10 ns;
        
        -- End simulation
        wait;
    end process;
end Behavioral;
```

---

### Constraints File (Not made yet)

```xdc
## Clock signal (if needed)
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports clk]

## Input signals
# set_property PACKAGE_PIN V17 [get_ports I]
# set_property IOSTANDARD LVCMOS33 [get_ports I]

# set_property PACKAGE_PIN U17 [get_ports S[0]]
# set_property IOSTANDARD LVCMOS33 [get_ports S[0]]

# set_property PACKAGE_PIN U16 [get_ports S[1]]
# set_property IOSTANDARD LVCMOS33 [get_ports S[1]]

## Output signals
# set_property PACKAGE_PIN V16 [get_ports Y[0]]
# set_property IOSTANDARD LVCMOS33 [get_ports Y[0]]

# set_property PACKAGE_PIN V15 [get_ports Y[1]]
# set_property IOSTANDARD LVCMOS33 [get_ports Y[1]]

# set_property PACKAGE_PIN V14 [get_ports Y[2]]
# set_property IOSTANDARD LVCMOS33 [get_ports Y[2]]

# set_property PACKAGE_PIN V13 [get_ports Y[3]]
# set_property IOSTANDARD LVCMOS33 [get_ports Y[3]]
```

---

## Working

- **Input (I):** A single input line.
- **Select Lines (S1, S0):** Two select lines that choose which output line receives the input.
- **Outputs (Y0 to Y3):**
  - If S = "00", `Y0` gets the input `I`.
  - If S = "01", `Y1` gets the input `I`.
  - If S = "10", `Y2` gets the input `I`.
  - If S = "11", `Y3` gets the input `I`.
- All other outputs stay '0' during each case.

---

## Simulation
![Demux_simulation](https://github.com/user-attachments/assets/ca3cee49-0a16-42c3-b4e2-7db24767fddc)

---

## Conclusion

The 1x4 DEMUX was successfully implemented using VHDL behavioral modeling. The simulation validated the correct input routing to outputs based on the select lines. This project enhances understanding of basic combinational circuits using VHDL for FPGA applications.
```
