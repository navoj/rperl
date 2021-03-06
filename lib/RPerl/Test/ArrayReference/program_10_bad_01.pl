#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  ]' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# homogeneous 2-dimensional array of arrays, using inner types
my arrayref_arrayref $array_array = [
    my integer_arrayref $TYPED_array_array_0 = [ 17,   -23, 1_701 ],
    my integer_arrayref $TYPED_array_array_1 = [ -1,   444, 2_987, ],
    my integer_arrayref $TYPED_array_array_2 = [ -321, 7,   24_851 ]
];
