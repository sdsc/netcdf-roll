NAME               = parallel_netcdf_$(ROLLCOMPILER)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION            = 1.3.1
RELEASE            = 3
PKGROOT            = /opt/netcdf/4.3.0/$(ROLLCOMPILER)/$(ROLLMPI)/$(ROLLNETWORK)

SRC_SUBDIR         = parallel_netcdf

SOURCE_NAME        = parallel_netcdf
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
