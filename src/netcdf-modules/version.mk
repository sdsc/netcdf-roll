ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME    = netcdf-modules_$(COMPILERNAME)
VERSION = 4.3.1.1
RELEASE = 1
RPM.EXTRAS         = AutoReq:No
