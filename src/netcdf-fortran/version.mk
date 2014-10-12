ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = openmpi
endif

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

NAME           = netcdf-fortran_$(COMPILERNAME)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION        = 4.4.1
RELEASE        = 0
PKGROOT        = /opt/netcdf/$(NETCDF_VERSION)/$(COMPILERNAME)/$(ROLLMPI)/$(ROLLNETWORK)

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
