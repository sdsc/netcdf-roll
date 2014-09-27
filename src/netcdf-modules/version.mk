ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME        = netcdf-modules_$(COMPILERNAME)
RELEASE     = 2
PKGROOT     = /opt/modulefiles/applications/.$(COMPILERNAME)/netcdf

VERSION_SRC = $(REDHAT.ROOT)/src/netcdf/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

VERSION_ADD = 3.6.2

RPM.EXTRAS  = AutoReq:No
