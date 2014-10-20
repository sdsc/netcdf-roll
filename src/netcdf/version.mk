ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = netcdf_$(COMPILERNAME)_$(MPINAME)
VERSION        = 4.3.2
RELEASE        = 1
PKGROOT        = /opt/netcdf/$(VERSION)/$(COMPILERNAME)/$(MPINAME)

SRC_SUBDIR     = netcdf

SOURCE_NAME    = netcdf
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
