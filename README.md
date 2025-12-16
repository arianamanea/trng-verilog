# trng-verilog #
True Random Number Generator (TRNG) implemented in Verilog HDL

## Overview ##

* This project implements a True Random Number Generator (TRNG) in Verilog HDL, designed according to the principles outlined in NIST SP 800-90B for entropy sources.
The TRNG is based on circuit metastability using multiple ring oscillators, followed by whitening, synchronization, and bias removal.
* The implementation targets FPGA platforms but is fully verifiable through functional simulation.

## Architecture ##

* The TRNG consists of the following stages:
  1. Entropy Source:
     - Multiple free-running ring oscillators
     - Exploits jitter and metastability effects inherent to digital circuits
     - Provides raw, asynchronous entropy
  2. Entropy Combination (Whitening)
     - XOR reduction of multiple oscillator outputs
     - Reduces correlation between entropy sources
     - Improves entropy quality before sampling
  3. Synchronization and Sampling
     - Double-flop synchronizer
     - Samples asynchronous entropy safely into the system clock domain
     - Prevents metastability propagation
  4. Bias Removal
     - Von Neumann corrector
     - Eliminates statistical bias from the raw entropy stream
     - Outputs unbiased random bits with valid signaling
  5. Health Testing (Optional)
     - Repetition Count Test (simplified, based on NIST SP 800-90B)
     - Detects catastrophic failures of the entropy source
     - Provides runtime health monitoring
## Module Description ##
* ring_oscillator.v:
  - Implements a simple free-running ring oscillator
  - Acts as the hardware entropy source
* entropy_combiner.v:
  - Performs XOR-based whitening
  - Combines multiple entropy inputs into a single stream
* entropy_sampler.v:
  - Synchronizes the asynchronous entropy signal
  - Samples entropy safely using the system clock
* von_neumann.v
  - Implements a Von Neumann corrector
  - Eliminates bias from the sampled entropy bits
* health_test.v
   - Implements a simplified repetition count test
   - Flags abnormal behavior indicating entropy failure
* trng_top.v
   - Top-level module integrating all TRNG components
   - Provides final random bit output and valid signal


### Repository Structure: ###
```
trng-verilog/
├── rtl/
│   ├── ring_oscillator.v
│   ├── entropy_combiner.v
│   ├── entropy_sampler.v
│   ├── von_neumann.v
│   ├── health_test.v
│   └── trng_top.v
├── tb/
│   └── trng_top_tb.v
├── scripts/
│   └── nist_dump.py
├── README.md
```
## Build and Simulation Instructions ##
### Prerequisites ###
* Icarus Verilog
* GTKWave
* Git

### Compile ###
```iverilog -g2012 -o trng_sim rtl/*.v tb/trng_top_tb.v```
### Run Simulation ###
```vvp trng_sim```
### View Waveforms ###
```gtkwave trng_wave.vcd```

### Expected behavior:  ###
* random_valid asserts intermittently
* random_bit exhibits non-periodic behavior

## NIST Compliance Considerations ##
* This implementation follows NIST SP 800-90B guidelines for entropy sources:
  - Physical entropy derived from metastability
  - Whitening through XOR combination
  - Bias removal using von Neumann corrector
  - Health monitoring via repetition count test
* Note: Formal NIST SP 800-90B certification requires silicon-level characterization and statistical validation beyond the scope of this academic project.

## Statistical Testing ##
* The script scripts/nist_dump.py demonstrates how generated random bits can be exported
* Output data can be evaluated using NIST SP 800-22 statistical test suite
* In real hardware, random bits would typically be captured via:
  - UART interface
  - Memory-mapped registers
## Tools and Technologies ##
- Verilog HDL
- Icarus Verilog (simulation)
- GTKWave (waveform visualization)
- Git / GitHub (version control)
## References ##

* Majzoobi, M., Koushanfar, F., Devadas, S.
FPGA-based true random number generation using circuit metastability with adaptive feedback control.
CHES 2011.
* Li, C. et al.
A metastability-based true random number generator on FPGA.
IEEE ASICON 2017.
* NIST SP 800-90B
Recommendation for the Entropy Sources Used for Random Bit Generation.
* neoTRNG – Open Source Project
https://github.com/stnolting/neoTRNG
* Xiphera – NIST SP 800-90B Compliant Entropy Source Documentation

## License ##
This project is intended for educational and research purposes.
