ARCH_TYPE = all
INSTALL_DIR ?= usr
PACKAGES_TOP_DIR ?= ../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

NAME = arm-tinyos-base
VERSION = 2.1

all: package

package: 
	mkdir -p debian/DEBIAN
	cat $(NAME).control | sed 's/@version@/'$(VERSION)-`date +%Y%m%d`'/'		\
                            | sed 's/@architecture@/$(ARCH_TYPE)/'                  	\
                            > debian/DEBIAN/control;                                	\
	cat $(NAME).changelog | sed 's/@date@/'"`date -R`"'/g'                          \
                            >> debian/DEBIAN/changelog;                                 \
	dpkg-deb --build debian $(PACKAGES_DIR)/$(NAME)-$(VERSION).deb; 

remove-history:
	mv $(NAME).changelog.history $(NAME).changelog.history.saved
	
restore-history:
	mv $(NAME).changelog.history.saved $(NAME).changelog.history

clean:
	rm -rf debian
