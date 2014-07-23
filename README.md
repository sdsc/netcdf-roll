# SDSC "netcdf" roll

This roll bundles the  NetCDF data format utilities.

For more information about the various packages included in the netcdf roll please visit their official web pages:

- <a href="http://www.unidata.ucar.edu/software/netcdf"
target="_blank">NetCDF</a> is a set of software libraries and self-describing,
machine-independent data formats that support the creation, access, and sharing
of array-oriented scientific data.
- <a href="http://nco.sourceforge.net" target="_blank">NCO</a> manipulates data
stored in netCDF-accessible formats, including HDF4 and HDF5.
- <a href="https://trac.mcs.anl.gov/projects/parallel-netcdf"
target="_blank">Parallel netCDF</a> is a library providing high-performance I/O
while still maintaining file-format compatibility with  Unidata's NetCDF.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate netcdf source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

texinfo, CentOS version
hdf5


## Building

To build the netcdf-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `netcdf-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.

This roll source supports building with different compilers and for different
network fabrics and mpi flavors.  By default, it builds using the gnu compilers
for openmpi ethernet.  To build for a different configuration, use the
`ROLLCOMPILER`, `ROLLMPI` and `ROLLNETWORK` make variables, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mpich2 ROLLNETWORK=mx 
```

The build process currently supports one or more of the values "intel", "pgi",
and "gnu" for the `ROLLCOMPILER` variable, defaulting to "gnu".  It supports
`ROLLMPI` values "openmpi", "mpich2", and "mvapich2", defaulting to "openmpi".
It uses any `ROLLNETWORK` variable value(s) to load appropriate mpi modules,
assuming that there are modules named `$(ROLLMPI)_$(ROLLNETWORK)` available
(e.g., `openmpi_ib`, `mpich2_mx`, etc.).  The build
process uses the ROLLCOMPILER value to load an environment module, so you can
also use it to specify a particular compiler version, e.g.,

```shell
% make ROLLCOMPILER=gnu/4.8.1
```

If the `ROLLCOMPILER`, `ROLLNETWORK` and/or `ROLLMPI` variables are specified,
their values are incorporated into the names of the produced roll and rpms, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2 ROLLNETWORK=ib
```
produces a roll with a name that begins "`netcdf_intel_mvapich2_ib`"; it
contains and installs similarly-named rpms.

For gnu compilers, the roll also supports a `ROLLOPTS` make variable value of
'avx', indicating that the target architecture supports AVX instructions.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll netcdf
% cd /export/rocks/install
% rocks create distro
% rocks run roll netcdf | bash
```

In addition to the software itself, the roll installs netcdf environment
module files in:

```shell
/opt/modulefiles/applications/.(compiler)/netcdf
```


## Testing

The netcdf-roll includes a test script which can be run to verify proper
installation of the netcdf-roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/netcdf.t 
```
