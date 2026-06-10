CC = gcc
CFLAGS = -m32 -fno-stack-protector -fno-PIC
LDFLAGS = -m32 -no-pie -g
BINARIES = entry

all: $(BINARIES)

# TODO a: Add a rule to change the entry point of entry.o
# to the `entry` function instead of `main`.

clean:
	rm -f $(BINARIES)
	rm -f *~ 
