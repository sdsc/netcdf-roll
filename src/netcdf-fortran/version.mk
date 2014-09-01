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
VERSION        = 4.4b5
RELEASE        = 2
PKGROOT        = /opt/netcdf/4.3.1.1/$(COMPILERNAME)/$(ROLLMPI)/$(ROLLNETWORK)

SRC_SUBDIR     = netcdf-fortran

SOURCE_NAME    = netcdf-fortran
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
