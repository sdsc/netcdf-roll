NAME               = netcdf_$(ROLLCOMPILER)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION            = 4.3.1.1
RELEASE            = 0
PKGROOT            = /opt/netcdf/$(VERSION)/$(ROLLCOMPILER)/$(ROLLMPI)/$(ROLLNETWORK)

SRC_SUBDIR         = netcdf

SOURCE_NAME        = netcdf
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
