NASM = nasm
AFILES = file1.asm file2.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf64 -g
LD=gcc
LDFLAGS = -g -no-pie
BINARIES = file

all : file1.o file2.o
	$(LD) $(LDFLAGS) -o $(BINARIES) $(OBJS)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 
