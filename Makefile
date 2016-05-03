SIDES := left right
CONTROLLER := $(PWD)/controller
KLLS := $(wildcard *.kll)
# LAYOUT := MDErgo1
# LCD := lcdFuncMap
LAYOUT := MDErgoIME
LCD := lcdFuncMapIME

all: submodules $(SIDES)

submodules:
	git submodule init $@
	git submodule update $@

$(CONTROLLER)/kll:
	ln -s $(PWD)/kll $@

right: $(CONTROLLER)/kll
	mkdir $@
	cp $(KLLS) $@
	cd $@ && cmake $(CONTROLLER) -DScanModule=MDErgo1 -DCHIP=mk20dx256vlh7 '-DBaseMap=defaultMap rightHand slave1 leftHand' -DMacroModule=PartialMap -DOutputModule=pjrcUSB -DDebugModule=full '-DDefaultMap=$(LAYOUT)-Default-0 $(LCD)' '-DPartialMaps=$(LAYOUT)-Default-1 $(LCD);$(LAYOUT)-Default-2 $(LCD)'
	$(MAKE) -C $@
	cp $@/kiibohd.dfu.bin $@_kiibohd.dfu.bin

left: $(CONTROLLER)/kll
	mkdir $@
	cp $(KLLS) $@
	cd $@ && cmake $(CONTROLLER) -DScanModule=MDErgo1 -DCHIP=mk20dx256vlh7 '-DBaseMap=defaultMap leftHand slave1 rightHand' -DMacroModule=PartialMap -DOutputModule=pjrcUSB -DDebugModule=full '-DDefaultMap=$(LAYOUT)-Default-0 $(LCD)' '-DPartialMaps=$(LAYOUT)-Default-1 $(LCD);$(LAYOUT)-Default-2 $(LCD)'
	$(MAKE) -C $@
	cp $@/kiibohd.dfu.bin $@_kiibohd.dfu.bin

clean:
	rm -rf controller/kll $(SIDES) $(SIDES:%=%_kiibohd.dfu.bin)
