ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

PACKAGE     = netcdf
CATEGORY    = applications

NAME        = $(PACKAGE)-modules_$(COMPILERNAME)
RELEASE     = 3
PKGROOT     = /opt/modulefiles/$(CATEGORY)/.$(COMPILERNAME)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

VERSION_ADD = 3.6.2

RPM.EXTRAS  = AutoReq:No
