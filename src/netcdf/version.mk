ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

ifndef ROLLMPI
  ROLLMPI = openmpi
endif

NAME               = netcdf_$(COMPILERNAME)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION            = 4.3.1.1
RELEASE            = 1
PKGROOT            = /opt/netcdf/$(VERSION)/$(COMPILERNAME)/$(ROLLMPI)/$(ROLLNETWORK)
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = netcdf

SOURCE_NAME        = netcdf
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
