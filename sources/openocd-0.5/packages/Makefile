ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= /usr/arm-tinyos
PACKAGES_TOP_DIR ?= ../../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

OPENOCD_NAME=openocd
OPENOCD_VERSION=0.5-rc2

OPENOCD=$(OPENOCD_NAME)-$(OPENOCD_VERSION)

	
LOOP_LIST="$(OPENOCD_NAME) $(OPENOCD_VERSION)"


all: remove-deps  
	for i in $(LOOP_LIST);								\
	do										\
		set -- $$i;								\
		mkdir -p $$1-$$2/DEBIAN/;						\
		cat control-files/$$1.control | sed 's/@version@/'$$2-`date +%Y%m%d`'/'	\
					      | sed 's/@architecture@/$(ARCH_TYPE)/'	\
					      > $$1-$$2/DEBIAN/control;			\
		cat ../postinst >> $$1-$$2/DEBIAN/postinst; \
		chmod 0755 $$1-$$2/DEBIAN/postinst;    \
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
