CC=gcc
OPT=-O3

montgomery2: montgomery2.c aux.o
	$(CC) aux.o montgomery2.c -o montgomery2
aux.o: aux.c
	$(CC) -c aux.c 
montgomery: montgomery.c
	$(CC) montgomery.c -o montgomery
clean:
	rm -f *.o montgomery montgomery2
