TARGET=led_control
TOP=led_control # top level entity/module
OBJS+=led_control.vhdl # all source files

all: ${TARGET}.bit

$(TARGET).json: $(OBJS)
	ghdl -a $(OBJS)
	yosys -m ghdl -p "ghdl ${TOP}; synth_ecp5 -top ${TOP} -json $@"

$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --25k --package CABGA256 --speed 6 --json $< --textcfg $@ --lpf $(TARGET).lpf --freq 25

$(TARGET).bit: $(TARGET)_out.config
	ecppack --svf ${TARGET}.svf $< $@

${TARGET}.svf: ${TARGET}.bit

prog: ${TARGET}.bit
	openFPGALoader --cable ft232RL --pins=RXD:RTS:TXD:CTS ${TARGET}.bit

clean:
	rm -f *.svf *.bit *.config *.json *.ys *.cf

.PHONY: all prog clean
