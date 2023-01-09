
## Info

When running `make`, this is what happens:

1. All Scala files from `src/mylib/` are compiled into Verilog files (inside `gen/` folder).
2. `yosys` synthetizes those Verilog files, generating a `json` file with the RTL information.
3. `nextpnr-ecp5` transforms synthetized RTL code and pin mapping (`lpf` file) into a FPGA config file.
4. `ecppack` generates bitstream from the configuration file.
5. `openFPGALoader` uploads the bitstream into the FPGA via JTAG.

## References
- [SpinalHDL](https://github.com/SpinalHDL/SpinalHDL) - Scala based HDL.