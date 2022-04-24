EE_BIN = loadfromcd.elf
EE_OBJS = loadFromCD.o cdvd_rpc.o cdvd.s
EE_LIBS = -lc -lpatches -lcdvd
EE_INCS = -I$(PS2DEV)/common/include -I$(PS2LIB)/ee/include

all: $(EE_BIN)

cdvd.s : cdvd.irx
	bin2s cdvd.irx cdvd.s cdvd

clean:
	rm -f *.elf *.o *.s

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
