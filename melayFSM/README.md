# 🔁 Mealy FSM Sequence Detector – VHDL

## 📌 Description
A Mealy-type FSM to detect the bit sequence **"1011"**. The output (`dout`) is asserted high when the pattern is detected, and the FSM transitions accordingly based on current state and input. Unlike Moore, the Mealy machine provides output based on the **present state and current input**, enabling quicker responses.

---

## 📂 File List

- `fsm_mealy.vhd` – Main VHDL code
- `tb_fsm_mealy.vhd` – Testbench file
- `fsm_mealy.xdc` – Constraints file for Nexys A7-100T board

---

## 📐 Logic Description

- **States**:
  - `S0`: Initial state
  - `S1`: Input `1` detected
  - `S2`: Input `10` detected
  - `S3`: Input `101` detected

- **Output**: `dout = '1'` when in `S3` and `din = '1'`

- **Reset**: Active high asynchronous reset returns FSM to `S0`

---

## 🧠 VHDL Code

### `fsm_mealy.vhd`
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsm_mealy is
    Port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        din  : in  std_logic;
        dout : out std_logic
    );
end fsm_mealy;

architecture Behavioral of fsm_mealy is
    type state_type is (S0, S1, S2, S3);
    signal current_state, next_state : state_type;
begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, din)
    begin
        case current_state is
            when S0 =>
                if din = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
                dout <= '0';

            when S1 =>
                if din = '0' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
                dout <= '0';

            when S2 =>
                if din = '1' then
                    next_state <= S3;
                else
                    next_state <= S0;
                end if;
                dout <= '0';

            when S3 =>
                if din = '1' then
                    next_state <= S1;
                    dout <= '1';
                else
                    next_state <= S2;
                    dout <= '0';
                end if;

        end case;
    end process;

end Behavioral;
```

---

### `tb_fsm_mealy.vhd`
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_fsm_mealy is
end tb_fsm_mealy;

architecture Behavioral of tb_fsm_mealy is
    signal clk  : std_logic := '0';
    signal rst  : std_logic := '1';
    signal din  : std_logic := '0';
    signal dout : std_logic;

    component fsm_mealy
        Port (
            clk  : in  std_logic;
            rst  : in  std_logic;
            din  : in  std_logic;
            dout : out std_logic
        );
    end component;

begin
    uut: fsm_mealy port map (clk => clk, rst => rst, din => din, dout => dout);

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    stim_proc : process
    begin
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        din <= '1'; wait for 20 ns;
        din <= '0'; wait for 20 ns;
        din <= '1'; wait for 20 ns;
        din <= '1'; wait for 20 ns;

        din <= '0'; wait for 20 ns;
        din <= '1'; wait for 20 ns;
        din <= '0'; wait for 20 ns;
        din <= '1'; wait for 20 ns;
        din <= '1'; wait for 20 ns;

        wait;
    end process;
end Behavioral;
```

---

### `fsm_mealy.xdc` (Constraints for Nexys A7-100T)
```xdc
# Clock Input
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Input - din (SW0 - J15)
set_property PACKAGE_PIN J15 [get_ports din]
set_property IOSTANDARD LVCMOS33 [get_ports din]

# Output - dout (LED - H17)
set_property PACKAGE_PIN H17 [get_ports dout]
set_property IOSTANDARD LVCMOS33 [get_ports dout]
```

---

## ⚙️ Board Behavior

- Toggle **Switch J15** to feed sequence `1011` into `din`
- When the sequence is detected, **LED H17** lights up
- Use a clock divider if LED blinks too fast for visual observation

---

## ✅ Status

- [x] Simulation ✅
- [x] Synthesized on Nexys A7 ✅
- [x] Hardware Tested ✅
