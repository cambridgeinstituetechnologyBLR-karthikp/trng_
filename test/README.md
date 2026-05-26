# TRNG using Ring Oscillator

## Project Description
This project implements a True Random Number Generator (TRNG) using a ring oscillator in Verilog.

The ring oscillator generates high-frequency oscillations. These oscillations are sampled using a clock signal to generate random bits.

The generated random bits are processed and sent to the Tiny Tapeout output pins.

## Features
- Ring oscillator based TRNG
- Random bit generation
- Tiny Tapeout compatible
- Verilog implementation
- Simulation tested using GTKWave

## Files
- `project.v` → Top module
- `tb.v` → Testbench
- `test.py` → Cocotb test
- `info.md` → Project documentation

## Author
Karthik
