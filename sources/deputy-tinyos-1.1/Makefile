ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= usr
PACKAGES_TOP_DIR ?= ../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)
BUILD_DIR=$(shell pwd)

NAME = deputy-tinyos
VERSION = 1.1

FULL_NAME = $(NAME)-$(VERSION)

all: download package

download:
	wget -c http://tinyos.stanford.edu/tinyos/toolchain/repo/$(FULL_NAME).tar.gz
	wget -c http://tinyos.stanford.edu/tinyos/toolchain/repo/deputy.patch

compile-it: 
	tar -zxvf $(FULL_NAME).tar.gz
	cd $(NAME)-$(VERSION);					\
	patch -p0 < ../deputy.patch;				\
	./configure --prefix=/$(INSTALL_DIR);			\
	make;							\
	make install DESTDIR=$(BUILD_DIR)/debian
	rm -rf debian/$(INSTALL_DIR)/lib/deputy/bin/deputy.byte.exe

package: compile-it
	mkdir -p debian/DEBIAN;									\
	cat $(NAME).control | sed 's/@version@/'$(VERSION)-`date +%Y%m%d`'/'				\
                           | sed 's/@architecture@/$(ARCH_TYPE)/'    					\
                           > debian/DEBIAN/control;                				\
	cat $(NAME).changelog | sed 's/@date@/'"`date -R`"'/g'                          \
                            >> debian/DEBIAN/changelog;                                 \
	dpkg-deb --build debian $(PACKAGES_DIR)/$(NAME)-$(VERSION).deb;				\

clean:
	rm -rf debian/DEBIAN;

veryclean: clean
	rm -rf $(NAME)-$(VERSION).tar.gz;
	rm -rf $(NAME)-$(VERSION)
	rm -rf deputy.patch
