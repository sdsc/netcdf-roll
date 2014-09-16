#!/usr/bin/perl -w
# netcdf roll installation test.  Usage:
# netcdf.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $TESTFILE = "tmpnetcdf";

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $output;

my @COMPILERS = split(/\s+/, 'ROLLCOMPILER');
my @MPIS = split(/\s+/, 'ROLLMPI');
my @NETWORKS = split(/\s+/, 'ROLLNETWORK');
my $VERSION = '4.3.1.1';
my %CC = ('gnu' => 'gcc', 'intel' => 'icc', 'pgi' => 'pgcc');
my %F77 = ('gnu' => 'gfortran', 'intel' => 'ifort', 'pgi' => 'pgf77');

open(OUT, ">${TESTFILE}netcdf.c");
# Adapted from simple_xy_wr.c downloaded from
# http://www.unidata.ucar.edu/software/netcdf/examples/programs/
print OUT <<END;
#include <stdlib.h>
#include <stdio.h>
#include <netcdf.h>

void check(int result) {
  if(result != 0) {
    printf("FAIL\\n");
    exit(1);
  }
}

#define NDIMS 2
#define NX 6
#define NY 12

int main() {

   int ncid, x_dimid, y_dimid, varid;
   int dimids[NDIMS];
   int data_out[NX][NY];
   int x, y;

   for (x = 0; x < NX; x++)
     for (y = 0; y < NY; y++)
       data_out[x][y] = x * NY + y;

   check(nc_create("$TESTFILE.netcdf", NC_CLOBBER, &ncid));
   check(nc_def_dim(ncid, "x", NX, &dimids[0]));
   check(nc_def_dim(ncid, "y", NY, &dimids[1]));
   check(nc_def_var(ncid, "data", NC_INT, NDIMS, dimids, &varid));

   check(nc_enddef(ncid));

   check(nc_put_var_int(ncid, varid, &data_out[0][0]));
   check(nc_close(ncid));

   printf("SUCCEED\\n");
   return 0;
}
END


open(OUT, ">${TESTFILE}netcdf.f");
# Adapted from simple_xy_wr.c downloaded from
# http://www.unidata.ucar.edu/software/netcdf/examples/programs/
print OUT <<END;
      include "netcdf.inc"

      parameter(NDIMS=2,NX=6,NY=12)
      integer ncid, x_dimid, y_dimid, varid
      integer dimids(NDIMS)
      integer data_out(NX,NY)
      integer x, y

      do x = 1,NX
        do y=1,NY
          data_out(x,y) = x * NY + y
        enddo
      enddo

      call check(nf_create('$TESTFILE.netcdf', NF_CLOBBER, ncid))
      call check(nf_def_dim(ncid, 'x', NX, dimids(1)))
      call check(nf_def_dim(ncid, 'y', NY, dimids(2)))
      call check(nf_def_var(ncid, 'data', NF_INT, NDIMS, dimids, varid))

      call check(nf_enddef(ncid),'NF_ENDDEF')
   
      call check(nf_put_var_int(ncid, varid, data_out))
      call check(nf_close(ncid))

      write(6,*) 'SUCCEED'
      end
      subroutine check(result,label)
      integer result
      character*32 label
      if(result.ne.0) then
          write(6,*) 'FAIL'
          stop
      endif
      return
      end
END

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load \$1
export LD_LIBRARY_PATH=\$2/lib:\$LD_LIBRARY_PATH
\$3 -I \$2/include -o $TESTFILE.exe \$4 -L \$2/lib \$5
./$TESTFILE.exe
END

open(OUT, ">${TESTFILE}nco.sh");
print OUT <<END;
#!/bin/bash
module load \$1 \$2 netcdf
ncks $TESTFILE.netcdf
END

# netcdf-common.xml
foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  SKIP: {
    skip "netcdf/3.6.2/$compilername not installed", 2
      if ! -d "/opt/netcdf/3.6.2/$compilername";
    $output = `bash $TESTFILE.sh $compilername /opt/netcdf/3.6.2/$compilername $CC{$compilername} ${TESTFILE}netcdf.c "-lnetcdf" 2>&1`;
    ok(-f "$TESTFILE.exe", "compile/link with netcdf/3.6.2/$compilername");
    like($output, qr/SUCCEED/, "run with netcdf/3.6.2/$compilername");
    `/bin/rm $TESTFILE.exe`;
  }
}

foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  foreach my $mpi(@MPIS) {
    foreach my $network(@NETWORKS) {
      SKIP: {
        skip "netcdf/$VERSION/$compilername/$mpi/$network not installed", 2
          if ! -d "/opt/netcdf/$VERSION/$compilername/$mpi/$network";
        $output = `bash $TESTFILE.sh "$compilername ${mpi}_$network" /opt/netcdf/$VERSION/$compilername/$mpi/$network $F77{$compilername} ${TESTFILE}netcdf.f "-lnetcdff -lnetcdf" 2>&1`;
        ok(-f "$TESTFILE.exe",
           "compile fortran /link with netcdff/$VERSION/$compilername/$mpi/$network");
        like($output, qr/SUCCEED/,
             "run with netcdf/$VERSION/$compilername/$mpi/$network");
        `/bin/rm $TESTFILE.exe`;
      }
    }
  }
}

foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  foreach my $mpi(@MPIS) {
    foreach my $network(@NETWORKS) {
      SKIP: {
        skip "netcdf/$VERSION/$compilername/$mpi/$network not installed", 2
          if ! -d "/opt/netcdf/$VERSION/$compilername/$mpi/$network";
        $output = `bash $TESTFILE.sh "$compilername ${mpi}_$network" /opt/netcdf/$VERSION/$compilername/$mpi/$network $CC{$compilername} ${TESTFILE}netcdf.c "-lnetcdf" 2>&1`;
        ok(-f "$TESTFILE.exe",
           "compile/link with netcdf/$VERSION/$compilername/$mpi/$network");
        like($output, qr/SUCCEED/,
             "run with netcdf/$VERSION/$compilername/$mpi/$network");
        `/bin/rm $TESTFILE.exe`;
      }
    }
  }
}


foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  foreach my $mpi(@MPIS) {
    foreach my $network(@NETWORKS) {
      SKIP: {
        skip "nco/$compilername/$mpi/$network not installed", 1
          if ! -d "/opt/nco/$compilername/$mpi/$network";
        $output = `bash ${TESTFILE}nco.sh $compiler ${mpi}_$network 2>&1`;
        ok($output =~ /x.4. y.10. data.58.=58/, "nco/$compilername/$mpi/$network");
      }
    }
  }
}

SKIP: {
  foreach my $compiler(@COMPILERS) {
    my $compilername = (split('/', $compiler))[0];
    SKIP: { 
      skip "netcdf/$VERSION/$compilername not installed", 3
        if ! -d "/opt/netcdf/$VERSION/$compilername";
      `/bin/ls /opt/modulefiles/applications/.$compilername/netcdf/$VERSION 2>&1`;
      ok($? == 0, "netcdf/$VERSION/$compilername module installed");
      `/bin/ls /opt/modulefiles/applications/.$compilername/netcdf/.version.$VERSION 2>&1`;
      ok($? == 0, "netcdf/$VERSION/$compilername version module installed");
      ok(-l "/opt/modulefiles/applications/.$compilername/netcdf/.version",
         "netcdf/$VERSION/$compilername version module link created");
    } 
  }
}

SKIP: {
  foreach my $compiler(@COMPILERS) {
    my $compilername = (split('/', $compiler))[0];
    SKIP: { 
      skip "netcdf/3.6.2/$compilername not installed", 1
        if ! -d "/opt/netcdf/3.6.2/$compilername";
      `/bin/ls /opt/modulefiles/applications/.$compilername/netcdf/3.6.2 2>&1`;
      ok($? == 0, "netcdf/3.6.2/$compilername module installed");
    } 
  }
}

`/bin/rm -fr $TESTFILE*`;
