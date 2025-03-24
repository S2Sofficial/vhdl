# 3-to-8 Decoder using VHDL  

## Table of Contents  
1. [Project Overview](#1-project-overview)  
2. [Theory](#2-theory)  
   - [Decoder Concept](#decoder-concept)  
   - [Truth Table](#truth-table)  
3. [Working](#3-working)
4. [VHDL Implementation: 3 to 8 Decoder](decoder/3x8)

---

## **1. Project Overview**  
This project implements a **3-to-8 decoder** using **VHDL**. The decoder takes a **3-bit input (A)** and produces an **8-bit output (Y)**, where only **one output bit is HIGH** corresponding to the given binary input, and all others are LOW.  

---

## **2. Theory**  

### **Decoder Concept**  
A **3-to-8 decoder** translates a **3-bit binary input (A)** into a **one-hot 8-bit output (Y)**, where only the selected output bit is HIGH (`1`) and the rest are LOW (`0`).  

### **Truth Table**  

| **A(2:0) Input** | **Y(7:0) Output** |  
|------------------|------------------|  
| 000 | 00000001 |  
| 001 | 00000010 |  
| 010 | 00000100 |  
| 011 | 00001000 |  
| 100 | 00010000 |  
| 101 | 00100000 |  
| 110 | 01000000 |  
| 111 | 10000000 |  

---

## **3. Working**  

1. The **3-bit input (A)** selects one of **eight possible outputs (Y[7:0])**.  
2. The decoder uses a **case statement** to determine which output should be HIGH (`1`).  
3. All other output bits remain LOW (`0`).  
4. If the input does not match any valid case, the output defaults to `"00000000"`.  

---

### **Waveform Analysis**  
The simulation results confirm that the **decoder correctly sets only one output bit HIGH** based on the input.  

| **A Input** | **Y Output** |  
|------------|------------|  
| 000 | 00000001 |  
| 001 | 00000010 |  
| 010 | 00000100 |  
| 011 | 00001000 |  
| 100 | 00010000 |  
| 101 | 00100000 |  
| 110 | 01000000 |  
| 111 | 10000000 |  

---
Made by **Swaroop Kumar Yadav**
