REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

build:

$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	# Adapted for multiple versions
	# COMPILERNAME replacement also required for the netcdf modulefile
	for V in $(VERSION) $(VERSION_ADD); do \
	  cp *.module $(ROOT)/$(PKGROOT)/$$V; \
	  cp *.version $(ROOT)/$(PKGROOT)/.version.$$V; \
	  perl -pi -e 's#ROLLCOMPILER#$(ROLLCOMPILER)#g;' \
	           -e 's#ROLLMPI#$(ROLLMPI)#g;' \
	           -e 's#ROLLNETWORK#$(ROLLNETWORK)#g;' \
	           -e "s#VERSION#$$V#g;" \
	    $(ROOT)/$(PKGROOT)/.version.$$V $(ROOT)/$(PKGROOT)/$$V; \
	  perl -pi -e 's#COMPILERNAME#$(COMPILERNAME)#g' \
	    $(ROOT)/$(PKGROOT)/$$V; \
	done
	ln -s $(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/.version

clean::
	rm -f $(VERSION_INC)
