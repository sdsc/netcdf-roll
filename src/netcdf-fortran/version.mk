NAME               = netcdf-fortran_$(ROLLCOMPILER)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION            = 4.4b5
RELEASE            = 0
PKGROOT            = /opt/netcdf/4.3.1.1/$(ROLLCOMPILER)/$(ROLLMPI)/$(ROLLNETWORK)
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = netcdf-fortran

SOURCE_NAME        = netcdf-fortran
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
