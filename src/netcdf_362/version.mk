ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME           = netcdf_362_$(COMPILERNAME)
VERSION        = 3.6.2
RELEASE        = 3
PKGROOT        = /opt/netcdf/$(VERSION)/$(COMPILERNAME)

SRC_SUBDIR     = netcdf_362

SOURCE_NAME    = netcdf_362
SOURCE_SUFFIX  = tgz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = netcdf-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TGZ_PKGS       = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
