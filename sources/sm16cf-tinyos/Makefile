ARCH_TYPE:=all
PACKAGES_TOP_DIR ?= ../../packages/
PACKAGES_DIR = $(PACKAGES_TOP_DIR)/$(ARCH_TYPE)

NAME = sm16cf
VERSION = 1.0.0-rc5

all: compile package

$(NAME)-$(VERSION).tar.bz2:
	wget http://downloads.sourceforge.net/project/$(NAME)/$(NAME)/$(VERSION)/$(NAME)-$(VERSION).tar.bz2

compile: $(NAME)-$(VERSION).tar.bz2
	rm -rf $(NAME)-$(VERSION);		\
	tar -xjvf $(NAME)-$(VERSION).tar.bz2;

package: 
	cd $(NAME)-$(VERSION);			\
	mkdir debian;				\
	cp -rp ../control-files/* debian;	\
	dpkg-buildpackage -rfakeroot -b;	\
	cd ..;					\
	rm *.changes;				\
	mv $(NAME)-tinyos_$(VERSION)_$(ARCH_TYPE).deb $(PACKAGES_DIR)

clean:
	rm -rf $(shell pwd)/$(NAME)-$(VERSION)/debian

veryclean: clean
	rm -rf $(shell pwd)/$(NAME)-$(VERSION)
