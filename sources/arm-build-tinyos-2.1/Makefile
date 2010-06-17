INSTALL_DIR ?= usr

all:
	INSTALL_DIR=$(INSTALL_DIR) ./build-armgcc

clean:
	rm -rf sources build

packages:
	cd packages;		\
	make clean; make;
