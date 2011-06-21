INSTALL_DIR ?= /usr/

all:
	INSTALL_DIR=$(INSTALL_DIR) sh -x build-armgcc

clean:
	rm -rf sources build

FORCE:

packages: FORCE
	cd packages;		\
	make clean; make;
