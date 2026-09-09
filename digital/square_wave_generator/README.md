# Square Wave Generator

This project implements a configurable **square wave generator in Verilog**.

The output frequency is controlled using push buttons. The selected frequency is stored as **7 BCD digits**, converted to a frequency value, and then used by a clock divider to generate the output signal.

## Features

* 7-digit frequency input
* Push-button control:

  * Increment digit (btn_up)
  * Decrement digit (btn_down)
  * Select next digit (next_digit)
  * Active-low reset (nrst)
* Button debouncing
* Rising-edge detection
* BCD to decimal conversion
* Configurable square wave output frequency
* 7 segment display control for showing the currently configured frequency
* Designed for a **100 MHz input clock**

## Architecture

```text
Buttons
   ↓
Debouncer
   ↓
Edge Detector
   ↓
Button Encoder ────────────────────────┐
   ↓                                   ↓
BCD to Decimal Converter         Display Decoder
   ↓
Clock Divider
   ↓
Square Wave Output
```

## Input Clock

The design assumes a 100 MHz input clock.

## Reset

An active-low reset (nrst) initializes the system and sets all frequency digits to zero.

## Project Structure

```text
src/    - Verilog source files
tb/     - Testbenches
sim/    - Simulation files
debug/  - Some source files used in debuging phase
```

## Simulation

The project can be simulated using **Icarus Verilog** and viewed with **GTKWave**. For longer simulations, the FST (Fast Signal Trace) format is recommended because it provides significantly smaller waveform files and is more efficient for GTKWave.
