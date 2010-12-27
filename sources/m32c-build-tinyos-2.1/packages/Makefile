ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= usr

M32C_BINUTILS_NAME=m32c-binutils
M32C_BINUTILS_VERSION=2.19.1

M32C_GCC_NAME=m32c-gcc
M32C_GCC_VERSION=4.3.3

M32C_BINUTILS=$(M32C_BINUTILS_NAME)-$(M32C_BINUTILS_VERSION)
M32C_GCC=$(M32C_GCC_NAME)-$(M32C_GCC_VERSION)
M32C_GCC_NEWLIB=$(M32C_GCC_NAME)+newlib-$(M32C_GCC_VERSION)
NAMES = $(M32C_BINUTILS) $(AVR_GCC)

PACKAGES_DIR=../../../packages/$(ARCH_TYPE)

LOOP_LIST= "$(M32C_BINUTILS_NAME) $(M32C_BINUTILS_VERSION)"	\
           "$(M32C_GCC_NAME)+newlib $(M32C_GCC_VERSION)"

all: rename-gcc remove-deps strip-bin
	for i in $(LOOP_LIST);								\
	do										\
		set -- $$i;								\
		mkdir -p $$1-$$2/DEBIAN/;						\
                cat control-files/$$1.control | sed 's/@version@/'$$2-`date +%Y%m%d`'/'	\
					      | sed 's/@architecture@/$(ARCH_TYPE)/'	\
					      > $$1-$$2/DEBIAN/control;			\
		dpkg-deb --build $$1-$$2 $(PACKAGES_DIR)/$$1-tinyos-$$2.deb;		\
	done

packages: all

remove-deps:
	rm -rf $(M32C_BINUTILS)/$(INSTALL_DIR)/info
	rm -rf $(M32C_BINUTILS)/$(INSTALL_DIR)/lib/libiberty.a
	rm -rf $(M32C_GCC_NEWLIB)/$(INSTALL_DIR)/info
	rm -rf $(M32C_GCC_NEWLIB)/$(INSTALL_DIR)/man/man7
	rm -rf $(M32C_GCC_NEWLIB)/$(INSTALL_DIR)/lib/libiberty.a

strip-bin:
	strip $(M32C_BINUTILS)/$(INSTALL_DIR)/bin/*
	strip $(M32C_GCC_NEWLIB)/$(INSTALL_DIR)/bin/* ; true

rename-gcc:
	mv $(M32C_GCC) $(M32C_GCC_NEWLIB)

clean:
	find . -name DEBIAN -type d | xargs rm -rf 

veryclean:
	rm -rf $(NAMES)
