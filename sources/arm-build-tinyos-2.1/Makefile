INSTALL_DIR ?= usr/arm-tinyos/

all:
	INSTALL_DIR=$(INSTALL_DIR) sh -x build-armgcc

clean:
	rm -rf sources build

packages: all
	cd packages;		\
	make clean; make;
