# Copyright (c) 2022-2023 Martin Becker, Blaubeuren.
# This package is free software; you can distribute it and/or modify it
# under the terms of the Artistic License 2.0 (see LICENSE file).

# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl 11_mdp_data_m.t'

#########################

use strict;
use warnings;
use FindBin;
use File::Spec;
use Test::More tests => 5;

use Math::DifferenceSet::Planar 1.000;

require_ok('Math::DifferenceSet::Planar::Data::M');

my ($vol, $dirs) = File::Spec->splitpath($FindBin::RealBin, 1);
my @comp         = File::Spec->splitdir($dirs);
$comp[-1]        = 'share';
$dirs            = File::Spec->catdir(@comp);
my $file         = File::Spec->catpath($vol, $dirs, 'pds_1961.db');

my $count = eval { Math::DifferenceSet::Planar->set_database($file) };
diag($@) if !defined $count;
is($count, 1961, 'size M database available');

my $ds = Math::DifferenceSet::Planar->std_reference(4913);
my $sl = $ds && $ds->lambda;
is($sl, 1, 'std reference 4913');

$ds = Math::DifferenceSet::Planar->lex_reference(4913);
my $ll = $ds && $ds->lambda;
is($ll, 4635871, 'lex reference 4913');

$ds = Math::DifferenceSet::Planar->gap_reference(4913);
my $gl = $ds && $ds->lambda;
is($gl, 304840, 'gap reference 4913');

