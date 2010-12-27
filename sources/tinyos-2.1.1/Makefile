ARCH_TYPE = all
INSTALL_DIR = opt
PACKAGES_TOP_DIR ?= ../../packages
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

NAME = tinyos
VERSION = 2.1.1
CVS_TAG = release_tinyos_2_1_1_3
FULL_NAME = $(NAME)-$(VERSION)

all: download extract do-copy package

download:
	#cvs -d:pserver:anonymous@tinyos.cvs.sourceforge.net:/cvsroot/tinyos login
	cvs -z3 -d:pserver:anonymous@tinyos.cvs.sourceforge.net:/cvsroot/tinyos co -P -r $(CVS_TAG) tinyos-2.x	

extract:
	cd $(NAME)-2.x;									\
	../extractor $(FULL_NAME) < ../tinyos.files | gzip >../$(FULL_NAME).tar.gz

do-copy:
	mkdir -p $(FULL_NAME)/$(INSTALL_DIR)
	cd $(FULL_NAME)/$(INSTALL_DIR);							\
	tar -zxf ../../$(FULL_NAME).tar.gz

package: do-copy
	mkdir -p $(FULL_NAME)/DEBIAN
	cat $(NAME).control | sed 's/@version@/'$(VERSION)-`date +%Y%m%d`'/'		\
                            | sed 's/@architecture@/$(ARCH_TYPE)/'                  	\
                            > $(FULL_NAME)/DEBIAN/control;
	cat $(NAME).changelog | sed 's/@date@/'"`date -R`"'/g'                          \
                              | sed 's/@version@/'$(VERSION)'/g'			\
                            >> $(FULL_NAME)/DEBIAN/changelog;
	cat $(NAME).sh | sed 's/@prefix@/'$(INSTALL_DIR)'/g'				\
                       | sed 's/@version@/'$(VERSION)'/g'				\
                            > $(FULL_NAME)/$(INSTALL_DIR)/$(FULL_NAME)/$(NAME).sh
	dpkg-deb --build $(FULL_NAME) $(PACKAGES_DIR)/$(FULL_NAME).deb; 

remove-history:
	mv $(NAME).changelog.history $(NAME).changelog.history.saved

restore-history:
	mv $(NAME).changelog.history.saved $(NAME).changelog.history

clean:
	rm -rf $(FULL_NAME)

veryclean: clean
	rm -rf $(FULL_NAME).tar.gz
	rm -rf $(NAME)-2.x
