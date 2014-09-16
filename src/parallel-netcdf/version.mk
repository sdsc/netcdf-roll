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

NAME           = parallel-netcdf-$(COMPILERNAME)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION        = 1.4.1
RELEASE        = 3
PKGROOT        = /opt/netcdf/4.3.1.1/$(COMPILERNAME)/$(ROLLMPI)/$(ROLLNETWORK)

SRC_SUBDIR     = parallel-netcdf

SOURCE_NAME    = parallel-netcdf
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
