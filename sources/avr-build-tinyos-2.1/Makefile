INSTALL_DIR ?= usr

AVRDUDE=avrdude-5.4
AVR_LIBC=avr-libc-1.4.7
AVR_BINUTILS=binutils-2.17
AVR_GCC=gcc-4.1.2

NAMES= $(AVRDUDE) $(AVR_LIBC) $(AVR_BINUTILS) $(AVR_GCC)

MAKE_DIR=$(shell pwd)
LOCAL_DIR=$(MAKE_DIR)/$@
PACKAGE_DIR=$(MAKE_DIR)/packages/$@
AVR_PACKAGE_DIR=$(MAKE_DIR)/packages/avr-$@

all: $(NAMES) packages

FORCE:

packages: FORCE
	cd packages; make clean; make;
clean:
	rm -rf $(NAMES) *.patch

$(AVR_BINUTILS): 
	rm -rf $(LOCAL_DIR);							\
	rm -rf $(AVR_PACKAGE_DIR);						\
	cd $(MAKE_DIR);								\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/$@.tar.bz2;	\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/avr-binutils.patch;	\
	tar -jxvf $@.tar.bz2;							\
	cd $(LOCAL_DIR);							\
	patch -p0 < ../avr-binutils.patch;					\
	mkdir obj-avr;								\
	cd obj-avr;								\
	../configure --target=avr --prefix=$(AVR_PACKAGE_DIR)/$(INSTALL_DIR) 	\
		--program-prefix=avr- --disable-nls;				\
	make;									\
	make install;								\
	cd $(LOCAL_DIR);							\

$(AVR_GCC): $(AVR_BINUTILS)
	export PATH="$(MAKE_DIR)/packages/$(AVR_BINUTILS)/$(INSTALL_DIR)/bin:$(shell echo $$PATH)";	\
	rm -rf $(LOCAL_DIR);										\
	rm -rf $(AVR_PACKAGE_DIR);									\
	cd $(MAKE_DIR);											\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/$@.tar.bz2;				\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/avr-gcc.patch;				\
	tar -jxvf $@.tar.bz2;										\
	cd $(LOCAL_DIR);										\
	patch -p0 < $(MAKE_DIR)/avr-gcc.patch;								\
	mkdir obj-avr;											\
	cd obj-avr;											\
	../configure --target=avr --prefix=$(AVR_PACKAGE_DIR)/$(INSTALL_DIR)				\
		--program-prefix=avr- --disable-nls 						\
		--enable-languages=c --disable-libssp;						\
	make;											\
	make install;										\
	cd $(LOCAL_DIR);									\

$(AVR_LIBC): $(AVR_GCC)
	export PATH="$(MAKE_DIR)/packages/$(AVR_BINUTILS)/$(INSTALL_DIR)/bin:				\
		     $(MAKE_DIR)/packages/$(AVR_GCC)/$(INSTALL_DIR)/bin:				\
		     $(shell echo $$PATH)";							\
	rm -rf $(LOCAL_DIR);									\
	rm -rf $(PACKAGE_DIR);									\
	cd $(MAKE_DIR);										\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/$@.tar.bz2;			\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/sfr_defs.patch;			\
	tar -jxvf $@.tar.bz2;									\
	cd $(LOCAL_DIR)/include/avr;								\
	patch -p0 < $(MAKE_DIR)/sfr_defs.patch;						\
	cd $(LOCAL_DIR);									\
	./configure --prefix=$(PACKAGE_DIR)/$(INSTALL_DIR) 					\
		--program-prefix=avr- --build=`./config.guess` --host=avr;			\
	make;											\
	make install;										\
	cd $(LOCAL_DIR);									\

$(AVRDUDE): $(AVR_LIBC) FORCE
	export PATH="$(MAKE_DIR)/packages/$(AVR_BINUTILS)/$(INSTALL_DIR)/bin:			\
		     $(MAKE_DIR)/packages/$(AVR_GCC)/$(INSTALL_DIR)/bin:			\
		     $(MAKE_DIR)/packages/$(AVR_LIBC)/$(INSTALL_DIR)/bin:			\
		     $(shell echo $$PATH)";							\
	rm -rf $(LOCAL_DIR);									\
	rm -rf $(PACKAGE_DIR);									\
	cd $(MAKE_DIR);										\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/$@.tar.bz2;			\
	wget http://tinyos.stanford.edu/tinyos/toolchain/repo/avrdude-5.4-mib510.patch;		\
	tar -jxvf $@.tar.bz2;									\
	patch -p0 < $(MAKE_DIR)/avrdude-5.4-mib510.patch;					\
	cd $(LOCAL_DIR);									\
	./configure --prefix=$(PACKAGE_DIR)/$(INSTALL_DIR);					\
	make;											\
	make install;										\
	cd $(PACKAGE_DIR);									\
	mv $(INSTALL_DIR)/etc .;								\
	mkdir etc/avrdude ;									\
	mv etc/* etc/avrdude;									\
	cd $(LOCAL_DIR);									\

