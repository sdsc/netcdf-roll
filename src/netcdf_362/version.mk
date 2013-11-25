NAME               = netcdf_362_$(ROLLCOMPILER)
VERSION            = 3.6.2
RELEASE            = 3
PKGROOT            = /opt/netcdf/$(VERSION)/$(ROLLCOMPILER)

SRC_SUBDIR         = netcdf_362

SOURCE_NAME        = netcdf_362
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tgz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TGZ_PKGS           = $(SOURCE_PKG)
