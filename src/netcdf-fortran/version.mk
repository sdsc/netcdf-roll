ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-netcdf-fortran_$(COMPILERNAME)_$(MPINAME)
VERSION        = 4.4.1
RELEASE        = 5
PKGROOT        = /opt/netcdf/$(NETCDF_VERSION)/$(COMPILERNAME)/$(MPINAME)

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
