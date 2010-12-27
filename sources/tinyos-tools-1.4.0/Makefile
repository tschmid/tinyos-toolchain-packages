ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= usr
PACKAGES_TOP_DIR ?= ../../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

TOOLS_NAME = tinyos-tools
TOOLS_VERSION = 1.4.0
CVS_TAG = release_tools_1_4_0_3

all: download compile fix-paths package

download: $(TOOLS_NAME)-$(TOOLS_VERSION)

$(TOOLS_NAME)-$(TOOLS_VERSION):
	cvs -d:pserver:anonymous@tinyos.cvs.sourceforge.net:/cvsroot/tinyos login
	cvs -z3 -d:pserver:anonymous@tinyos.cvs.sourceforge.net:/cvsroot/tinyos co -P 			\
		-d $(TOOLS_NAME)-$(TOOLS_VERSION) -r $(CVS_TAG) tinyos-2.x/tools

compile:
	cd $(shell pwd)/$(TOOLS_NAME)-$(TOOLS_VERSION);							\
	./Bootstrap;											\
	./configure --prefix=$(shell pwd)/$(TOOLS_NAME)-$(TOOLS_VERSION)/debian/$(INSTALL_DIR);		\
	make; make install;										\
	mkdir -p debian/DEBIAN;

fix-paths:
	cd $(shell pwd)/$(TOOLS_NAME)-$(TOOLS_VERSION);							\
	find debian/$(INSTALL_DIR)/bin/ -type f -exec perl -i                                           \
                -pe's#$(shell pwd)/$(TOOLS_NAME)-$(TOOLS_VERSION)/debian##' '{}' \;;

package:
	cd $(shell pwd)/$(TOOLS_NAME)-$(TOOLS_VERSION);							\
	cat ../$(TOOLS_NAME).control | sed 's/@version@/'$(TOOLS_VERSION)-`date +%Y%m%d`'/'		\
                           | sed 's/@architecture@/$(ARCH_TYPE)/'                                       \
                           > debian/DEBIAN/control;                                                     \
	dpkg-deb --build debian $(PACKAGES_DIR)/$(TOOLS_NAME)-$(TOOLS_VERSION).deb;

clean:
	cd $(shell pwd)/$(TOOLS_NAME)-$(TOOLS_VERSION);							\
	rm -rf debian;											\
	make clean;

