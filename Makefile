CC=nvcc
ARCH="-arch=sm_20"
LIBS=-lgmp

all: easysum easymul

easymul: easymul.cu
	$(CC) $(ARCH) easymul.cu -o $(BIN_DIR)easymul

easysum: easysum.cu
	$(CC) $(ARCH) $(LIBS) easysum.cu -o $(BIN_DIR)easysum

clean:
	rm -f *.o easysum easymul
