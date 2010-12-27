ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= usr/arm-tinyos
PACKAGES_TOP_DIR ?= ../../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

ARM_LIBC_NAME=arm-libc
ARM_LIBC_VERSION=1.19.0

ARM_BINUTILS_NAME=arm-binutils
ARM_BINUTILS_VERSION=2.21

ARM_GCC_NAME=arm-gcc
ARM_GCC_VERSION=4.5.2

ARM_GDB_NAME=arm-gdb
ARM_GDB_VERSION=7.1

ARM_LIBC=$(ARM_LIBC_NAME)-$(ARM_LIBC_VERSION)
ARM_BINUTILS=$(ARM_BINUTILS_NAME)-$(ARM_BINUTILS_VERSION)
ARM_GCC=$(ARM_GCC_NAME)-$(ARM_GCC_VERSION)
ARM_GDB=$(ARM_GDB_NAME)-$(ARM_GDB_VERSION)
NAMES = $(ARM_LIBC) $(ARM_BINUTILS) $(ARM_GCC) $(ARM_GDB)

	
LOOP_LIST= "$(ARM_BINUTILS_NAME) $(ARM_BINUTILS_VERSION)"		\
	   "$(ARM_GCC_NAME) $(ARM_GCC_VERSION)"				\
	   "$(ARM_LIBC_NAME) $(ARM_LIBC_VERSION)"			\
	   "$(ARM_GDB_NAME) $(ARM_GDB_VERSION)"	


all: remove-deps  
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
	rm -f $(ARM_BINUTILS)/$(INSTALL_DIR)/share/info/dir
	rm -f $(ARM_GCC)/$(INSTALL_DIR)/share/info/dir
	rm -f $(ARM_GCC)/$(INSTALL_DIR)/lib/libiberty.a
	rm -f $(ARM_LIBC)/$(INSTALL_DIR)/share/info/dir
	rm -f $(ARM_LIBC)/$(INSTALL_DIR)/share/info/standards.info
	rm -f $(ARM_LIBC)/$(INSTALL_DIR)/share/info/configure.info
	rm -f $(ARM_GDB)/$(INSTALL_DIR)/share/info/standards.info
	rm -f $(ARM_GDB)/$(INSTALL_DIR)/share/info/bfd.info
	rm -f $(ARM_GDB)/$(INSTALL_DIR)/share/info/configure.info
	rm -f $(ARM_GDB)/$(INSTALL_DIR)/lib/libiberty.a

remove-$(ARM_BINUTILS)-deps:
	find $(INSTALL_DIR) -type f > $(ARM_BINUTILS).files
	rm -rf $(ARM_BINUTILS)
	mkdir -p $(ARM_BINUTILS)
	cp -R $(INSTALL_DIR) $(ARM_BINUTILS)/
	rm -rf  $(ARM_BINUTILS)/$(INSTALL_DIR)/info/dir
	rm -rf  $(ARM_BINUTILS)/$(INSTALL_DIR)/share/info/dir
	rm -rf $(ARM_BINUTILS)/$(INSTALL_DIR)/lib/libiberty.a
	rm -rf $(ARM_BINUTILS)/$(INSTALL_DIR)/share/locale
	rm -rf $(ARM_BINUTILS)/$(INSTALL_DIR)/man/man7

remove-$(ARM_GCC)-deps:
	cat $(ARM_BINUTILS).files | xargs rm -rf
	find $(INSTALL_DIR) -empty | xargs rm -rf
	find $(INSTALL_DIR) -type f > $(ARM_GCC).files
	rm -rf $(ARM_GCC)
	mkdir -p $(ARM_GCC)
	cp -R $(INSTALL_DIR) $(ARM_GCC)/
	cp -R $(ARM_BINUTILS)/* .
	rm -rf $(ARM_GCC)/$(INSTALL_DIR)/man/man7
	rm -rf $(ARM_GCC)/$(INSTALL_DIR)/info/dir
	rm -rf $(ARM_GCC)/$(INSTALL_DIR)/share/info/dir

remove-$(ARM_LIBC)-deps:
	cat $(ARM_BINUTILS).files | xargs rm -rf
	cat $(ARM_GCC).files | xargs rm -rf
	find $(INSTALL_DIR) -empty | xargs rm -rf
	find $(INSTALL_DIR) -type f > $(ARM_LIBC).files
	rm -rf $(ARM_LIBC)
	mkdir -p $(ARM_LIBC)
	cp -R $(INSTALL_DIR) $(ARM_LIBC)/
	cp -R $(ARM_BINUTILS)/* .
	cp -R $(ARM_GCC)/* .
	rm -rf $(ARM_LIBC)/$(INSTALL_DIR)/share/info/standards.info

clean:
	find . -name DEBIAN -type d | xargs rm -rf 

veryclean: clean
	rm -rf $(NAMES)
	rm -rf *.files
	rm -rf $(INSTALL_DIR)
