# Half Adder: Theory and Implementation

## **VHDL Implementation**
[**Structural Modelling**](halfadder/hastructural)

## Introduction
A half adder is a basic digital circuit that performs addition of two single-bit binary numbers. It's a fundamental building block in digital electronics and computer arithmetic units.

## Truth Table
The half adder has the following truth table:

| A (Input) | B (Input) | Sum (Output) | Carry (Output) |
|-----------|-----------|--------------|----------------|
| 0         | 0         | 0            | 0              |
| 0         | 1         | 1            | 0              |
| 1         | 0         | 1            | 0              |
| 1         | 1         | 0            | 1              |

## Boolean Equations
The half adder can be expressed using these Boolean equations:

```
Sum = A ⊕ B (XOR operation)
Carry = A ∧ B (AND operation)
```

## Logic Diagram
```
       _______
A ----|       |
      |  XOR  |---- Sum
B ----|_______|

       _______
A ----|       |
      |  AND  |---- Carry
B ----|_______|
```

## Characteristics
1. **Inputs**: Two single-bit binary numbers (A and B)
2. **Outputs**: 
   - Sum (result of addition)
   - Carry (indicates overflow)
3. **Limitations**: Cannot handle carry-in from previous additions

## Applications
- Building block for full adders
- Arithmetic Logic Units (ALUs)
- Basic addition circuits
- Digital signal processing

## Implementation Options
1. **Using Basic Gates**:
   - Sum: XOR gate
   - Carry: AND gate

2. **Using NAND Gates Only** (Universal gate implementation):
   ```
   Sum = NAND(NAND(A, NAND(A,B)), NAND(B, NAND(A,B)))
   Carry = NAND(NAND(A,B), NAND(A,B))
   ```

## Timing Considerations
- Propagation delay depends on the gate implementation
- XOR gate typically has higher delay than AND gate
- Critical path determines maximum operating frequency

## Power Consumption
- Static power: Depends on technology node
- Dynamic power: Function of switching activity
- Minimum when inputs are 00 (both outputs 0)

## Variations
1. **Transistor-Level Implementations**:
   - Static CMOS
   - Pass-transistor logic
   - Transmission gate implementations

2. **Low-Power Versions**:
   - Dual-rail implementations
   - Adiabatic logic styles

## Limitations
- Cannot handle carry input (requires full adder for multi-bit addition)
- Limited to single-bit operations
- XOR gate implementation may be area-intensive in some technologies

## Extensions
The half adder forms the basis for more complex circuits:
- Full adder (by adding carry input handling)
- Ripple carry adder
- Carry look-ahead adder
- Multipliers and other arithmetic units
