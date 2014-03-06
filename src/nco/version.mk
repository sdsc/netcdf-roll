NAME               = nco_$(ROLLCOMPILER)_$(ROLLMPI)_$(ROLLNETWORK)
VERSION            = 4.4.1
RELEASE            = 0
PKGROOT            = /opt/nco/$(ROLLCOMPILER)/$(ROLLMPI)/$(ROLLNETWORK)
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR         = nco

SOURCE_NAME        = nco
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
