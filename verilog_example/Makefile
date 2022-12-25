TARGET=led_control
TOP=led_control # top level entity/module
OBJS+=led_control.v # all source files

all: ${TARGET}.bit

$(TARGET).json: $(OBJS)
	yosys -p "synth_ecp5 -top ${TOP} -json $@" $(OBJS)

$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --25k --package CABGA256 --speed 6 --json $< --textcfg $@ --lpf $(TARGET).lpf --freq 25

$(TARGET).bit: $(TARGET)_out.config
	ecppack --svf ${TARGET}.svf $< $@

${TARGET}.svf: ${TARGET}.bit

prog: ${TARGET}.bit
	openFPGALoader --cable ft232RL --pins=RXD:RTS:TXD:CTS ${TARGET}.bit

clean:
	rm -f *.svf *.bit *.config *.json *.ys

.PHONY: all prog clean
