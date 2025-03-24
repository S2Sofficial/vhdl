# Full Adder: An Overview

A **Full Adder** is a fundamental combinational logic circuit used in digital electronics to perform binary addition. It is an extension of the **Half Adder**, capable of adding three binary inputs and producing two outputs: the **Sum** and the **Carry**. The Full Adder plays a critical role in arithmetic logic units (ALUs) of microprocessors, multipliers, and other computational circuits.

---
## **VHDL Implementation**

Use the following links for VHDL implementation in different modelling styles.
  - [Behavioral Modelling](fulladder/behavioral)
  - [Dataflow Modelling](fulladder/dataflow)
     
## **1. Functional Description**

The truth table for a Full Adder is as follows:

| A | B | Cin | Sum (S) | Carry Out (Cout) |
|---|---|-----|---------|------------------|
| 0 | 0 |  0  |    0    |        0         |
| 0 | 0 |  1  |    1    |        0         |
| 0 | 1 |  0  |    1    |        0         |
| 0 | 1 |  1  |    0    |        1         |
| 1 | 0 |  0  |    1    |        0         |
| 1 | 0 |  1  |    0    |        1         |
| 1 | 1 |  0  |    0    |        1         |
| 1 | 1 |  1  |    1    |        1         |

---

## **2. Boolean Expressions**

From the truth table, the Boolean expressions for the outputs can be derived using Karnaugh maps or Boolean algebra:

1. **Sum (S):**
   $$
   S = A \oplus B \oplus Cin
   $$
   - The Sum output is the XOR (exclusive OR) of all three inputs, indicating that it represents the parity of the inputs.

2. **Carry Out (Cout):**
   $$
   Cout = (A \cdot B) + (Cin \cdot (A \oplus B))
   $$
   - The Carry Out is generated if any two inputs are high (logical AND operation), or if all three inputs are high.

---

## **3. Logic Circuit Implementation**

The Full Adder can be implemented using basic logic gates such as AND, OR, and XOR gates. The logic diagram consists of two stages:

1. **XOR Stage**:
   - Computes the intermediate sum of A and B using an XOR gate.
   - This intermediate result is then XORed with Cin to produce the final Sum output.

2. **Carry Generation Stage**:
   - Generates the Carry Out by combining the results of AND operations between the inputs.

The schematic of a Full Adder is shown below:

```
Inputs: A, B, Cin
-----------------------------------
          A ----\
                 XOR ----\
          B ----/         \
                           XOR ----> Sum (S)
          Cin ------------/
          
          A ----\
                 AND ----\
          B ----/         OR ----> Carry Out (Cout)
          Cin ------------/
                         AND ----/
```

---

## **4. Cascading Full Adders**

To add multi-bit binary numbers, multiple Full Adders are cascaded together. Each Full Adder handles one bit position, and the Carry Out of one stage is fed as the Carry In (Cin) to the next stage. This configuration forms a **Ripple Carry Adder**.

For example, a 4-bit Ripple Carry Adder would consist of four Full Adders, where:

- The first Full Adder has Cin = 0 (initial condition).
- Subsequent Full Adders receive the Carry Out from the previous stage as their Cin.

While simple, this design suffers from propagation delays due to the sequential nature of carry propagation. To address this limitation, more advanced designs like **Carry Look-Ahead Adders (CLA)** are employed.

---

## **5. Applications**

Full Adders are widely used in various digital systems, including:

1. **Arithmetic Logic Units (ALUs):**
   - Perform addition, subtraction, and other arithmetic operations.

2. **Binary Multipliers:**
   - Used to compute partial products and accumulate results.

3. **Counters and Timers:**
   - Increment or decrement values in sequential circuits.

4. **Error Detection and Correction:**
   - Employed in parity generation and checking circuits.

---

## **6. Advantages and Limitations**

**Advantages:**
- Simple and efficient for single-bit addition.
- Forms the building block for more complex arithmetic circuits.

**Limitations:**
- In multi-bit addition, the Ripple Carry Adder introduces delays due to carry propagation.
- Requires additional logic (e.g., Carry Look-Ahead) for high-speed applications.

---
