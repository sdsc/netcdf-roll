ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME           = sdsc-netcdf-fortran_$(COMPILERNAME)_serial
VERSION        = 4.4.4
RELEASE        = 1
PKGROOT        = /opt/netcdf/$(NETCDF_VERSION)/$(COMPILERNAME)/serial

SRC_SUBDIR     = netcdf-fortran

SOURCE_NAME    = netcdf-fortran
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

NETCDF_SRC     = $(REDHAT.ROOT)/src/netcdf/version.mk
NETCDF_INC     = netcdf.inc
include $(NETCDF_INC)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
