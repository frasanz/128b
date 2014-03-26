CC=nvcc
ARCH="-arch=sm_20"
BIN_DIR:=./

all: easysum easymul

easymul: easymul.cu
	$(CC) $(ARCH) easymul.cu -o $(BIN_DIR)easymul

easysum: easysum.cu
	$(CC) $(ARCH) easysum.cu -o $(BIN_DIR)easysum

clean:
	rm -f $(BIN_DIR)* ; rm -f *.o
