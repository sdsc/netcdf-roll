PACKAGE     = netcdf
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 7
PKGROOT     = /opt/modulefiles/$(CATEGORY)/.$(COMPILERNAME)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

EXTRA_MODULE_VERSIONS = 3.6.2

RPM.EXTRAS  = AutoReq:No\nObsoletes:sdsc-netcdf-modules_gnu,sdsc-netcdf-modules_intel,sdsc-netcdf-modules_pgi
RPM.PREFIX  = $(PKGROOT)
