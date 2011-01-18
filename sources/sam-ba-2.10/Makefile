ARCH_TYPE = all
INSTALL_DIR = /usr/arm-tinyos/
PACKAGES_TOP_DIR ?= ../../packages
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

NAME = sam-ba
VERSION = 2.10
#CVS_TAG = release_tinyos_2_1_1_3
FULL_NAME = $(NAME)-$(VERSION)

all: download extract do-copy package

download:
	wget -c http://www.atmel.com/dyn/resources/prod_documents/$(NAME)_$(VERSION).zip

extract:
	unzip $(NAME)_$(VERSION).zip
	tar cvfz $(FULL_NAME).tar.gz sam-ba_cdc_linux
	#gzip -r sam-ba_cdc_linux > $(FULL_NAME).tar.gz

do-copy:
	mkdir -p $(FULL_NAME)/$(INSTALL_DIR)
	cd $(FULL_NAME)/$(INSTALL_DIR);							\
	tar -zxf ../../../$(FULL_NAME).tar.gz

package: do-copy
	mkdir -p $(FULL_NAME)/DEBIAN
	cat $(NAME).control | sed 's/@version@/'$(VERSION)-`date +%Y%m%d`'/'		\
                            | sed 's/@architecture@/$(ARCH_TYPE)/'                  	\
                            > $(FULL_NAME)/DEBIAN/control;
	cat $(NAME).changelog | sed 's/@date@/'"`date -R`"'/g'                          \
                              | sed 's/@version@/'$(VERSION)'/g'			\
                            >> $(FULL_NAME)/DEBIAN/changelog;
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
	rm -rf *.zip
	rm -rf *.gz
	rm -rf sam-ba_cdc_linux
