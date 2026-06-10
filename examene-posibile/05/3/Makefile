CC = gcc

all : main

%.o : %.c
	$(CC) -c -o $@ $<

main : wired.o main.o
	$(CC) wired.o main.o -o main

clean:
	rm -f main.o main
