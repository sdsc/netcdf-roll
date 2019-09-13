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
my %CC = ('gnu' => 'gcc', 'intel' => 'icc', 'pgi' => 'pgcc');
my %F77 = ('gnu' => 'gfortran', 'intel' => 'ifort', 'pgi' => 'pgf77');

open(OUT, ">${TESTFILE}-netcdf.c");
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


open(OUT, ">${TESTFILE}-netcdf.f");
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
module load \$1 \$2 \$3
\$4 -I \$NETCDFHOME/include -o $TESTFILE.exe \$5 -L \$NETCDFHOME/lib \$6
./$TESTFILE.exe
END

open(OUT, ">${TESTFILE}-nco.sh");
print OUT <<END;
#!/bin/bash
module load \$1 \$2 netcdf
ncks $TESTFILE.netcdf
END

# netcdf-common.xml
foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  $output = `bash $TESTFILE.sh $compiler "" netcdf/3.6.2 $CC{$compilername} ${TESTFILE}-netcdf.c "-lnetcdf" 2>&1`;
  ok(-f "$TESTFILE.exe", "compile/link with netcdf/3.6.2/$compilername");
  like($output, qr/SUCCEED/, "run with netcdf/3.6.2/$compilername");
  `/bin/rm $TESTFILE.exe`;
}

foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  foreach my $mpi(@MPIS) {
    $output = `bash $TESTFILE.sh $compiler $mpi netcdf $F77{$compilername} ${TESTFILE}-netcdf.f "-lnetcdff -lnetcdf" 2>&1`;
    ok(-f "$TESTFILE.exe",
       "compile/link fortran with netcdf $compilername/$mpi");
    like($output, qr/SUCCEED/, "run with netcdf $compilername/$mpi");
    `/bin/rm $TESTFILE.exe`;
  }
  $output = `bash $TESTFILE.sh $compiler " " netcdf-serial $F77{$compilername} ${TESTFILE}-netcdf.f "-lnetcdff -lnetcdf" 2>&1`;
  ok(-f "$TESTFILE.exe",
     "compile/link fortran with netcdf $compilername/serial");
  like($output, qr/SUCCEED/, "run with netcdf $compilername/serial");
  `/bin/rm $TESTFILE.exe`;
}

foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  foreach my $mpi(@MPIS) {
    $output = `bash $TESTFILE.sh $compilername $mpi netcdf $CC{$compilername} ${TESTFILE}-netcdf.c "-lnetcdf" 2>&1`;
    ok(-f "$TESTFILE.exe",
       "compile/link C with netcdf/VERSION/$compilername/$mpi");
    like($output, qr/SUCCEED/, "run with netcdf $compilername/$mpi");
    `/bin/rm $TESTFILE.exe`;
  }
  $output = `bash $TESTFILE.sh $compilername " " netcdf-serial $CC{$compilername} ${TESTFILE}-netcdf.c "-lnetcdf" 2>&1`;
  ok(-f "$TESTFILE.exe",
    "compile/link C with netcdf/VERSION/$compilername/serial");
  like($output, qr/SUCCEED/, "run with netcdf $compilername/serial");
  `/bin/rm $TESTFILE.exe`;
}


foreach my $compiler(@COMPILERS) {
  my $compilername = (split('/', $compiler))[0];
  foreach my $mpi(@MPIS) {
    $output = `bash ${TESTFILE}-nco.sh $compiler $mpi 2>&1`;
    ok($output =~ /60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71/, "nco $compilername/$mpi");
  }
  $output = `module load $compiler netcdf; echo \$NETCDFHOME 2>&1`;
  my $firstmpi = $MPIS[0];
  $firstmpi =~ s#/.*##;
  like($output, qr#/opt/netcdf/.*/$compiler/$firstmpi#, 'netcdf modulefile defaults to first mpi');
}

`/bin/ls /opt/modulefiles/applications/netcdf/3.6.2 2>&1`;
ok($? == 0, "netcdf/3.6.2 module installed");
`/bin/ls /opt/modulefiles/applications/netcdf/[4-9]* 2>&1`;
ok($? == 0, "netcdf module installed");
`/bin/ls /opt/modulefiles/applications/netcdf-serial/[4-9]* 2>&1`;
ok($? == 0, "netcdf serial module installed");
`/bin/ls /opt/modulefiles/applications/netcdf/.version.[4-9]* 2>&1`;
ok($? == 0, "netcdf version module installed");
`/bin/ls /opt/modulefiles/applications/netcdf-serial/.version.[4-9]* 2>&1`;
ok($? == 0, "netcdf serial version module installed");
ok(-l "/opt/modulefiles/applications/netcdf/.version",
   "netcdf version module link created");
ok(-l "/opt/modulefiles/applications/netcdf-serial/.version",
   "netcdf serial version module link created");

`/bin/rm -fr $TESTFILE*`;
