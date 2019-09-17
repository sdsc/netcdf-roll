PACKAGE     = netcdf-serial
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 0
PKGROOT     = /opt/modulefiles/$(CATEGORY)/.$(COMPILERNAME)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No\nObsoletes:sdsc-netcdf-modules_gnu,sdsc-netcdf-modules_intel,sdsc-netcdf-modules_pgi
RPM.PREFIX  = $(PKGROOT)
