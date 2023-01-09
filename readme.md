##

This repository contains a simple program written in different HDLs (*Hardware Description Languages*) for the **Colorlight 5a-75e v8.0** board, using **FT232RL as JTAG programmer**. The goal is to provide an easy first setup for the Colorlight board.

*The program is a simple LED controller, which turns ON the LED everytime the input signal is ON.*

<p float="left">
  <img src="https://www.colorlight-led.com/Uploads/5a17d3b99f9c0.jpg" width="300" />
  <img src="https://abra-electronics.com/images/detailed/140/ARD-FTDI-IO.jpg" width="300" /> 
</p>

## Dependencies
- FPGA toolchain
    - [yosys](https://github.com/YosysHQ/yosys) – Yosys Open SYnthesis Suite.
    - [nextpnr-ecp5](https://github.com/YosysHQ/nextpnr) - A portable FPGA place and route tool (for ECP5 FPGA).
    - [prjtrellis](https://github.com/YosysHQ/prjtrellis) - Provides the device database and tools for bitstream creation.
    - [openFPGALoader](https://github.com/trabucayre/openFPGALoader) - Universal utility for programming FPGA 
- git
- make
  
In case you want to run the [VHDL example](./vhdl_example/), you will also need:
- [GHDL](https://github.com/ghdl/ghdl) - VHDL 2008/93/87 simulator.

In case you want to run the [SpinalHDL example](./spinalhdl_example/), you will also need:
- Scala
- sbt
- Java JDK 8+ (tested on `openjdk 19.0.1 2022-10-18`)

## Uploading to FPGA
```
git clone https://github.com/roby2014/ecp5-ft232rl-example
cd ecp5-ft232rl-example/[verilog/vhdl/spinalhdl]_example
make
```

After running `make`, the bitstream should be uploaded to the FPGA and you should be able to control the LED via input button.

## Info

When running `make`, this is what happens:

1. `yosys` synthetizes the Verilog/Vhdl files, generating a `json` file with the RTL information.
2. `nextpnr-ecp5` transforms synthetized RTL code and pin mapping (`lpf` file) into a FPGA config file.
3. `ecppack` generates bitstream from the configuration file.
4. `openFPGALoader` uploads the bitstream into the FPGA via JTAG.

In case you are running the [SpinalHDL example](./spinalhdl_example/), there is an extra step before all of the above:

0. All Scala files from `src/mylib/` are compiled into Verilog files (inside `gen/` folder).

In case you are running the [VHDL example](./vhdl_example/), there is an extra step before all of the above:

0. `GHDL` analyzes all `.vhd` files and elaborates the top entity module. 
