#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string__hash_ref $my_hash
    = { a_key => 'howdy', b_key => 'doody', c_key => 'clarabell' };
foreach my string $my_key ( keys %{$my_hash} ) {
    print 'Production rule Loop matched by LoopForEach, iteration item ',
        $my_key,
        "\n";
}