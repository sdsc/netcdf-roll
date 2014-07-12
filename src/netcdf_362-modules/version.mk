ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME    = netcdf_362-modules_$(COMPILERNAME)
VERSION = 3.6.2
RELEASE = 1
RPM.EXTRAS         = AutoReq:No
