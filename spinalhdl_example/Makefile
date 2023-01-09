TARGET=MyTopLevel
OBJS+=./src/mylib/$(TARGET).scala
OBJS+=./src/mylib/Config.scala
HW_FILES=./gen/*.v # TODO: add support to vhdl somehow
TOP_FILE=./gen/$(TARGET).v
PIN_BINDING_FILE=$(TARGET).lpf

all: prog

# generate hardware code from spinal code
$(TOP_FILE): $(OBJS)
	sbt "runMain mylib.$(TARGET)Verilog"

# synthetize rtl (generates a json file)
$(TARGET).json: $(TOP_FILE)
	yosys -p "synth_ecp5 -json $@" $(HW_FILES)

# transform synthetized rtl + pin mapping into fpga config file
$(TARGET)_out.config: $(TARGET).json $(PIN_BINDING_FILE)
	nextpnr-ecp5 --25k --package CABGA256 --speed 6 --freq 25 --json $< --textcfg $@ --lpf $(PIN_BINDING_FILE) --lpf-allow-unconstrained

# generate bitstream from config file
$(TARGET).bit: $(TARGET)_out.config
	ecppack --svf $(TARGET).svf $< $@

# upload bitstream to fpga
prog: $(TARGET).bit
	openFPGALoader --cable ft232RL --pins=RXD:RTS:TXD:CTS $(TARGET).bit

clean:
	rm -f *.svf *.bit *.config *.json *.ys -r target gen project .bsp
