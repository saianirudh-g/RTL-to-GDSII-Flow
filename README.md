# RTL to GDS-II Flow – Up/Down Counter  
This repository documents the complete digital design flow for an **8‑bit Up/Down Counter**, starting from **RTL simulation** and progressing through **Synthesis, DFT insertion, Netlist generation, and Logic Equivalence Check (LEC)**.

---

# 📘 Part 1 — RTL Simulation

## ✔️ RTL Design (counter.v)
The design implements an 8‑bit synchronous up/down counter with asynchronous reset.

### Key Features
- `clk` – clock input  
- `rst` – active‑low reset  
- `up_down` – direction control  
- `count[7:0]` – output count register  

### RTL Behavior
- On reset → counter clears to 0  
- When `up_down = 1` → counter increments  
- When `up_down = 0` → counter decrements  

Simulation was executed using:

## ✔️ Testbench (counter_test.v)
The testbench:
- Generates clock (`always #5 clk = ~clk`)
- Applies reset sequence
- Toggles `up_down` to test both increment and decrement operations

## ✔️ Waveform Output
Simulation waveforms confirm:
- Proper reset behavior  
- Correct increment sequence  
- Correct decrement sequence  

---

# 📗 Part 2 — Synthesis (Cadence Genus)

## ✔️ Synthesized RTL
The design was synthesized using **Genus Synthesis Solution**.

### Schematic View
The synthesized schematic shows:
- 21 standard cells  
- 10 ports  
- 24 nets  

### Netlist Statistics
| Type       | Instances | Area     | % Area |
|------------|-----------|----------|--------|
| Sequential | 8         | 49.932   | 68.86% |
| Logic      | 13        | 22.572   | 31.13% |

### Power Report
| Category | Leakage | Internal | Switching | Total |
|----------|---------|----------|-----------|--------|
| Total    | 1.55 nW | 2.58 µW  | 0.19 µW   | 2.77 µW |

### Area Report
- **Total cell area:** 72.504  
- **Wireload:** Default (from technology library)

### Timing Report
- Setup/hold timing extracted  
- Clock fanout = 8  
- Worst negative slack (WNS) = 0 (clean)

---

# 📙 Part 3 — DFT (Scan Insertion)

## ✔️ Scan Configuration
- Scan enable: `SE`  
- Scan input: `scan_in`  
- Scan output: `scan_out`  
- All 8 registers converted to **scan flip‑flops**

### DFT Rule Check
- **0 violations**  
- **100% registers scannable**

### Scan Chain Summary
- **1 scan chain**
- **Length: 8 bits**
- Order: `count_reg[0] → count_reg[7]`

## ✔️ DFT Netlist
A new netlist (`counter_netlist_dft.v`) was generated containing:
- SDFFRHQX1 scan flip‑flops  
- Scan chain logic  
- Additional combinational logic for scan stitching  

---

# 📒 Part 4 — Logic Equivalence Check (LEC)

## ✔️ Golden vs Revised Comparison
Golden: RTL (`counter.v`)  
Revised: DFT netlist (`counter_netlist_dft.v`)

### LEC Summary
- Key points mapped successfully  
- One ignored output (`scan_out`) and ignored input (`scan_in`)  
- **Final Result: PASS**

---

# 📁 Repository Structure (Recommended)
├── rtl/
│   ├── counter.v
│   └── counter_test.v
├── simulation/
│   ├── waves/
│   └── run_logs/
├── synthesis/
│   ├── counter_netlist.v
│   ├── reports/
│   │   ├── timing.rpt
│   │   ├── area.rpt
│   │   ├── power.rpt
│   │   └── qos.rpt
├── dft/
│   ├── counter_netlist_dft.v
│   ├── counter_scanDEF.scandef
│   └── dft_reports/
├── lec/
│   ├── lec_report.txt
│   └── compare_logs/
└── README.md

---
# ✅ Conclusion
This README summarizes the complete **RTL → Synthesis → DFT → LEC** flow for an Up/Down Counter design.  
It includes simulation results, synthesis statistics, DFT scan insertion, and equivalence checking.
