# LCD Interfacing using Cyclone IV (DE2-115) FPGA Board

This project demonstrates how to interface a **16x2 LCD display** with the **Cyclone IV (DE2-115)** FPGA board using **VHDL** and implement it via **Intel Quartus Prime**. The LCD is driven using a custom controller logic coded in VHDL to display static or dynamic messages.

---

## Description

This project focuses on displaying characters or strings on a 16x2 alphanumeric LCD (HD44780-compatible) using GPIOs from the Cyclone IV FPGA. The controller handles command and data signals, implements delays, and follows the initialization sequence required by the LCD.

Key goals:
- Understanding **LCD initialization sequence**
- Sending **command and data** instructions
- Interfacing with actual **hardware pins** of DE2-115
- Timing and control logic in VHDL

---

## LCD Control Overview

| Signal | Description           |
|--------|------------------------|
| RS     | Register Select (0 = Command, 1 = Data) |
| RW     | Read/Write (0 = Write) |
| E      | Enable (Latch signal) |
| D[7:0] | 8-bit Data Lines       |

---

## VHDL Code

```vhdl
-- Paste your working VHDL code here
```

---

Hardware Connections

Note: Replace GPIO_X/Y/Z with your actual pin mappings used in Quartus.


---

Constraints File

> Provide your .qsf constraints or pin assignments here.




---

Output Demo

![Output Demo](https://github.com/user-attachments/assets/f0d1c88b-92f7-4723-93ec-6995483cc748)




---

Explanation

1. Initialization Sequence:

Set function mode, display control, clear display, entry mode set.



2. Command & Data Write Logic:

RS/RW/E logic toggling handled in process.



3. Delays:

Wait states implemented to satisfy LCD timing requirements.



4. Parallel Interface:

8-bit data interface used for simplicity.





---

Status

[x] Implemented on DE2-115 board

[x] Functional string display tested

[ ] No testbench (hardware-only verification)



---

Keywords

VHDL LCD Display Cyclone IV DE2-115 FPGA Quartus Prime GPIO Interface


