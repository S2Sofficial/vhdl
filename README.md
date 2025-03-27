# VHDL Programming Repository 🚀

This repository contains various **VHDL projects** designed for learning and practicing digital design concepts such as Finite State Machines (FSMs), arithmetic units, and CPU implementation. Dive into the world of hardware description languages with hands-on examples!

---

## Table of Contents 📑

1. [Basic Gates](#basic-gates)
2. [Half Adder](#half-adder)
   - [Structural Modelling](#structural-modelling)
3. [Full Adder](#full-adder)
   - [Behavioral Modelling](#behavioral-modelling)
   - [Dataflow Modelling](#dataflow-modelling)
4. [Multiplexer](#multiplexer)
   - [4 x 1 Mux](#4-x-1-mux)
   - [16 x 1 Mux](#16-x-1-mux)
5. [Encoder](#encoder)
   - [4 x 2 Encoder](#4-x-2-encoder)
   - [8 x 3 Priority Encoder](#8-x-3-priority-encoder)
6. [Decoder](#decoder)
   - [3x8 Decoder](#3x8-decoder)
7. [4 Bit Ripple Carry Adder (Board Implementation)](#4-bit-ripple-carry-adder-board-implementation)
8. [Interfacing Seven Segment Display using VHDL (Board Implementation)](#interfacing-seven-segment-display-using-vhdl-board-implementation)
9. [Arithmetic Logic Unit (ALU) into FPGA](#arithmetic-logic-unit-alu-into-fpga)

---

## Basic Gates <a id="basic-gates"></a>
Implementations of fundamental logic gates like AND, OR, NOT, NAND, NOR, XOR, and XNOR using VHDL.

## Half Adder <a id="half-adder"></a>
A basic combinational circuit that adds two single binary digits and produces a sum and carry.

### Structural Modelling <a id="structural-modelling"></a>
Learn how to describe circuits using structural modeling techniques in VHDL.

## Full Adder <a id="full-adder"></a>
An extension of the half adder, capable of adding three binary inputs.

### Behavioral Modelling <a id="behavioral-modelling"></a>
Explore behavioral modeling in VHDL to describe the functionality of circuits without focusing on their structure.

### Dataflow Modelling <a id="dataflow-modelling"></a>
Understand dataflow modeling, where signal flow is emphasized over structural or behavioral details.

## Multiplexer <a id="multiplexer"></a>

### 4 x 1 Mux <a id="4-x-1-mux"></a>
A 4-to-1 multiplexer selects one of four input lines and forwards it to the output.

### 16 x 1 Mux <a id="16-x-1-mux"></a>
A larger multiplexer that selects one of sixteen input lines.

## Encoder <a id="encoder"></a>

### 4 x 2 Encoder <a id="4-x-2-encoder"></a>
Encodes 4 input lines into 2 output lines.

### 8 x 3 Priority Encoder <a id="8-x-3-priority-encoder"></a>
Assigns priority to inputs and encodes them into 3 output lines.

## Decoder <a id="decoder"></a>

### 3x8 Decoder <a id="3x8-decoder"></a>
Decodes 3 input lines into 8 output lines.

## 4 Bit Ripple Carry Adder (Board Implementation) <a id="4-bit-ripple-carry-adder-board-implementation"></a>
A ripple carry adder implemented on an FPGA board for practical testing.

## Interfacing Seven Segment Display using VHDL (Board Implementation) <a id="interfacing-seven-segment-display-using-vhdl-board-implementation"></a>
Control seven-segment displays using VHDL code, with real-world board implementation.

## Arithmetic Logic Unit (ALU) into FPGA <a id="arithmetic-logic-unit-alu-into-fpga"></a>
Design and implement a basic ALU for performing arithmetic and logic operations on an FPGA.

---

## 🛠️ Tools Used

- **Xilinx Vivado**: For simulation and FPGA implementation.
- **ModelSim**: For functional and timing simulations.
- **GHDL & GTKWave**: Open-source tools for VHDL simulation.
- **Artix-7 Nexys A7-100T**: FPGA board used for hardware testing.

---

## 🤝 Contributions

Contributions are welcome! Feel free to:
- Fork this repository.
- Add improvements or new VHDL projects.
- Submit pull requests (PRs).

Let's collaborate to make this repository a valuable resource for learning VHDL!

---

## 📬 Contact

For any queries or feedback, feel free to reach out:

- **LinkedIn**: [Swaroop Kumar Yadav](https://www.linkedin.com/in/swaroop2sky/)

---

<style>
h1 {
  color: #4CAF50;
  text-align: center;
}
h2 {
  color: #007BFF;
}
a {
  color: #FF5722;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
}
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}
</style>
