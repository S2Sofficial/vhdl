# Digital Clock in VHDL (24-Hour Format – Semester Project)

## 🧾 Project Description

This project is a **24-hour Digital Clock** implemented using **VHDL** and tested on the **Nexys A7-100T FPGA board**. It displays real-time hours, minutes, and seconds using a 6-digit **7-segment display**. This is **not a typical learning exercise**—it's a **complete semester project** submitted for academic evaluation at HNB Garhwal University, under the subject *Digital System Design using VHDL*.

The development was done in collaboration with three batchmates, involving both structural and behavioral modeling techniques, thorough testbench validation, and full hardware deployment.

## 👥 Team Members

- Swaroop Kumar Yadav (Lead Developer, VHDL logic & testing)
- Sandeep Kumar
- Shashank
- Mayank Verma

> *Department of Electronics and Communication Engineering, School of Engineering and Technology, Hemvati Nandan Bahuguna Garhwal University (A Central University), Srinagar, Uttrakhand*

---

## ⚙️ Key Features

- 24-hour format (HH:MM:SS)
- Button-based manual time setting:
  - 2 buttons for **hour** increment (1 hr, 10 hr)
  - 2 buttons for **minute** increment (1 min, 10 min)
- **Reset button** to set time to 00:00:00
- 6-digit multiplexed **7-segment display**
- Clock divider modules to generate **1Hz and 1kHz** internal clocks from 100MHz board clock
- Fully modular and structural VHDL code
- Button inputs handled inside 1Hz clock domain
- Display multiplexing using anode cycling at 1kHz

---

## 🧠 VHDL Modules

| Filename          | Entity Name      | Description                                                  |
|-------------------|------------------|--------------------------------------------------------------|
| `clk_1hz.vhd`     | `clk_1hz`        | Clock divider to generate 1Hz signal from 100MHz input       |
| `clk_1khz.vhd`    | `clk_1khz`       | Clock divider to generate 1kHz signal                        |
| `clock_counter.vhd`| `clock_counter` | Controls time counting and handles button inputs             |
| `mod6counter.vhd` | `mod6counter`    | 3-bit counter cycling through 6 display digits               |
| `anode_picker.vhd`| `anode_picker`   | Selects active digit on 7-segment display                    |
| `decoder.vhd`     | `decoder`        | Converts BCD digits to 7-segment segment encoding            |
| `counter.vhd`     | `counter`        | Top-level module that connects all submodules                |

All entities are declared and instantiated in the structural style, ensuring clean modularity.

---

## 📸 Outputs & Documentation

> This repository will include the following for final report submission:

- 📷 **RTL Schematics** of each module (from Vivado > RTL Analysis)
- 📐 **Top-level RTL Block Diagram** showing all interconnections
- 🧪 **Simulation waveform outputs** (from Vivado or ModelSim)
- 🎥 **Hardware demonstration video**
- 📷 **Photographs of actual FPGA output** with time values changing live

---

## 🔍 Functional Testing

A custom testbench `tb_counter.vhd` is included to verify:

- Reset logic
- Button-triggered hour/minute jumps
- Clock-based second counting
- 6-digit anode multiplexing

Tested using 100MHz simulation-compatible clock generation.

---

## 🧰 Target Hardware

- **FPGA Board**: Digilent Nexys A7-100T
- **Clock Input**: 100 MHz onboard clock
- **Display**: Onboard 6-digit 7-segment display
- **Inputs**:
  - BTN0, BTN1 – Hour increment
  - BTN2, BTN3 – Minute increment
  - BTN4 – Reset
- **Output**: Real-time HH:MM:SS display on segments

> Pin mappings are handled via the included constraint file: `digital_clock_constraints.xdc`

---

## 📦 Directory Structure

```

Digital\_Clock\_Project/
│
├── clk\_1hz.vhd
├── clk\_1khz.vhd
├── clock\_counter.vhd
├── mod6counter.vhd
├── anode\_picker.vhd
├── decoder.vhd
├── counter.vhd          # Top module
├── tb\_counter.vhd       # Testbench
├── digital\_clock\_constraints.xdc
├── /images              # Hardware proof images
└── /rtl\_diagrams        # RTL schematics for report

```

---

## 📷 Images
![image](https://github.com/user-attachments/assets/8f629b7b-eeaf-405c-8fd4-be9d8b5d32e7)
RTL Design of overall Digital Clock

![image](https://github.com/user-attachments/assets/4e97458e-8543-47ef-bdd1-7f76d0c80f4f)
RTL Design of 1KHz and 1Hz Clock

![image](https://github.com/user-attachments/assets/69b1ac95-0cfa-4575-9f52-4c4e33477363)
RTL Design of MOD-6-Counter

![image](https://github.com/user-attachments/assets/0b526320-626c-47a6-85c6-e87b5a25b760)
RTL Design of Decoder
(Other RTL Designs are not that visible upon screenshot)

---

## 🧾 License & Usage

This project is built for **academic learning, documentation, and contribution purposes**. All contributors are undergraduate students aiming to build practical design skills and share their work with the open-source academic community.

Feel free to fork and modify with proper attribution.

---

