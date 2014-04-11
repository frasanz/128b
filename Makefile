CC=nvcc
ARCH="-arch=sm_20"
LIBS=-lgmp

all: easysum easymul fullmul

fullmul: fullmul.cu show.o
	$(CC) $(ARCH) $(LIBS) show.o fullmul.cu -o $(BIN_DIR)fullmul

easymul: easymul.cu show.o
	$(CC) $(ARCH) $(LIBS) show.o easymul.cu -o $(BIN_DIR)easymul
show.o: show.cu
	$(CC) -c show.cu

easysum: easysum.cu show.o
	$(CC) $(ARCH) $(LIBS) show.o easysum.cu -o $(BIN_DIR)easysum

clean:
	rm -f *.o easysum easymul
