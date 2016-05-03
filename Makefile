SIDES := left right
CONTROLLER := $(PWD)/controller
KLLS := $(wildcard *.kll)

all: $(SIDES)

$(CONTROLLER)/kll:
	ln -s $(PWD)/kll $@

$(SIDES): $(CONTROLLER)/kll
	mkdir $@
	cp $(KLLS) $@
	cd $@ && cmake $(CONTROLLER) -DScanModule=MDErgo1 -DCHIP=mk20dx256vlh7 '-DBaseMap=defaultMap rightHand slave1 leftHand' -DMacroModule=PartialMap -DOutputModule=pjrcUSB -DDebugModule=full '-DDefaultMap=MDErgoIME-Default-0 lcdFuncMapIME' '-DPartialMaps=MDErgoIME-Default-1 lcdFuncMapIME;MDErgoIME-Default-2 lcdFuncMapIME'
	$(MAKE) -C $@
	cp $@/kiibohd.dfu.bin $@_kiibohd.dfu.bin

clean:
	rm -rf controller/kll $(SIDES) $(SIDES:%=%_kiibohd.dfu.bin)
