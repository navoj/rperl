# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQuotes_04_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub {
    return '"q{foo123}"';
};

1;    # end of package
