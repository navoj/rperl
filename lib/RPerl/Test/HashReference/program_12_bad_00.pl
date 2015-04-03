#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  <<< NO TOKEN FOUND >>>' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my hash_ref__hash_ref $hash_hash = {
    key0 => my integer__hash_ref $TYPED_key0
        = { a => 17, b => -23, c => 1_701 },
    key1 => my number__hash_ref $TYPED_key1
        = { d => 42 / 1_701, e => 21.12, f => 2_112.23 },
    key2 => my string__hash_ref $TYPED_key2 = {
        g => 'strings are scalars, too',
        h => 'hello world',
        i => 'last one'
    }
}
