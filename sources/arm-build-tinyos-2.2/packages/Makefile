ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= /usr/arm-tinyos
PACKAGES_TOP_DIR ?= ../../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

ARM_TOOLCHAIN_NAME=arm-tinyos-toolchain
ARM_TOOLCHAIN_VERSION=2.2

ARM_TOOLCHAIN=$(ARM_TOOLCHAIN_NAME)-$(ARM_TOOLCHAIN_VERSION)
NAMES = $(ARM_LIBC) $(ARM_BINUTILS) $(ARM_GCC) $(ARM_GDB)

LOOP_LIST= "$(ARM_TOOLCHAIN_NAME) $(ARM_TOOLCHAIN_VERSION)"		\

all: remove-deps  
	for i in $(LOOP_LIST);								\
	do										\
		set -- $$i;								\
		mkdir -p $$1-$$2/DEBIAN/;						\
		cat control-files/$$1.control | sed 's/@version@/'$$2-`date +%Y%m%d`'/'	\
					      | sed 's/@architecture@/$(ARCH_TYPE)/'	\
					      > $$1-$$2/DEBIAN/control;			\
		fakeroot dpkg-deb --build $$1-$$2 $(PACKAGES_DIR)/$$1-$$2.deb;		\
	done

packages: all

remove-deps:
	rm -f $(OPENOCD)/$(INSTALL_DIR)/share/info/dir

clean:
	find . -name DEBIAN -type d | xargs rm -rf 

veryclean: clean
	rm -rf $(NAMES)
	rm -rf *.files
	rm -rf $(INSTALL_DIR)
