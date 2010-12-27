ARCH_TYPE:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
INSTALL_DIR ?= usr
PACKAGES_TOP_DIR ?= ../../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

NESC_NAME = nesc
NESC_VERSION = 1.3.1

all: compile package

$(NESC_NAME)-$(NESC_VERSION).tar.gz:
	wget http://downloads.sourceforge.net/project/nescc/nescc/v$(NESC_VERSION)/$@;      \

compile: $(NESC_NAME)-$(NESC_VERSION).tar.gz
	rm -rf $(NESC_NAME)-$(NESC_VERSION);								\
	tar -zxvf $(NESC_NAME)-$(NESC_VERSION).tar.gz;							\
	cd $(shell pwd)/$(NESC_NAME)-$(NESC_VERSION);							\
	./configure --prefix=$(shell pwd)/$(NESC_NAME)-$(NESC_VERSION)/debian/$(INSTALL_DIR);		\
	make; make install-strip;									\
	echo $(shell pwd)/$(NESC_NAME)-$(NESC_VERSION)/debian;						\
	find debian/$(INSTALL_DIR)/bin/ -type f -exec perl -i 						\
		-pe's#$(shell pwd)/$(NESC_NAME)-$(NESC_VERSION)/debian##' '{}' \;;			\

package: 
	cd $(shell pwd)/$(NESC_NAME)-$(NESC_VERSION);                                                   \
	mkdir -p debian/DEBIAN;										\
	cat ../$(NESC_NAME).control | sed 's/@version@/'$(NESC_VERSION)-`date +%Y%m%d`'/'		\
                           | sed 's/@architecture@/$(ARCH_TYPE)/'    					\
                           > debian/DEBIAN/control;                 					\
	dpkg-deb --build debian $(PACKAGES_DIR)/$(NESC_NAME)-$(NESC_VERSION).deb;			\

clean:
	rm -rf $(shell pwd)/$(NESC_NAME)-$(NESC_VERSION)/debian/DEBIAN;					\

veryclean: clean
	rm -rf $(shell pwd)/$(NESC_NAME)-$(NESC_VERSION);						\
