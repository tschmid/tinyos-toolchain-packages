INSTALL_DIR ?= usr

M32C_BINUTILS=binutils-2.19.1
M32C_GCC=gcc-4.3.3
M32C_GCC_CORE=gcc-core-4.3.3
M32C_NEWLIB=newlib-1.17.0

NAMES = $(M32C_BINUTILS) $(M32C_GCC)

MAKE_DIR=$(shell pwd)
LOCAL_DIR=$(MAKE_DIR)/$@
PACKAGE_DIR=$(MAKE_DIR)/packages/$@
M32C_PACKAGE_DIR=$(MAKE_DIR)/packages/m32c-$@

all: $(NAMES) packages

FORCE:

packages: FORCE
	cd packages; make clean; make;
clean:
	rm -rf $(NAMES)

$(M32C_BINUTILS).tar.bz2:
	wget http://ftp.gnu.org/gnu/binutils/$@

$(M32C_BINUTILS): $(M32C_BINUTILS).tar.bz2
	rm -rf $(LOCAL_DIR);		\
	rm -rf $(M32C_PACKAGE_DIR);	\
	cd $(MAKE_DIR);			\
	tar -xjvf $@.tar.bz2;		\
	cd $(LOCAL_DIR);		\
	mkdir obj-m32c;			\
	cd obj-m32c;			\
	../configure --target=m32c-elf --disable-nls \
		--prefix=$(M32C_PACKAGE_DIR)/$(INSTALL_DIR);	\
	make;				\
	make install;		\
	cd $(LOCAL_DIR);


$(M32C_GCC_CORE).tar.bz2:
	wget http://ftp.gnu.org/gnu/gcc/gcc-4.3.3/$@

$(M32C_NEWLIB).tar.gz:
	wget ftp://sources.redhat.com/pub/newlib/$@

$(M32C_GCC): $(M32C_GCC_CORE).tar.bz2 $(M32C_NEWLIB).tar.gz
	export PATH="$(MAKE_DIR)/packages/m32c-$(M32C_BINUTILS)/$(INSTALL_DIR)/bin:$(shell echo $$PATH)"; \
	rm -rf $(LOCAL_DIR);			\
	rm -rf $(M32C_PACKAGE_DIR);		\
	cd $(MAKE_DIR);				\
	tar -xjvf $(M32C_GCC_CORE).tar.bz2;	\
	tar -xzvf $(M32C_NEWLIB).tar.gz;	\
	cd $(LOCAL_DIR);			\
	ln -s ../$(M32C_NEWLIB)/newlib;		\
	ln -s ../$(M32C_NEWLIB)/libgloss;	\
	mkdir obj-m32c;				\
	cd obj-m32c;				\
	../configure --target=m32c-elf --disable-nls --with-newlib \
		--enable-languages=c --disable-libssp \
		--prefix=$(M32C_PACKAGE_DIR)/$(INSTALL_DIR); \
	make;					\
	make install;				\
	cd $(LOCAL_DIR);

