CC=nvcc
ARCH="-arch=sm_20"
BIN_DIR:=./bin/

all: easysum

easysum: easysum.cu
	$(CC) $(ARCH) easysum.cu -o $(BIN_DIR)easysum

clean:
	rm -f $(BIN_DIR)* ; rm -f *.o
