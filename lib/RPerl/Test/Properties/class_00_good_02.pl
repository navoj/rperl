#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: '92' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Properties::Class_00_Good;

# [[[ OPERATIONS ]]]
my $test_object = RPerl::Test::Properties::Class_00_Good->new();
$test_object->{test_property} = 4;
$test_object->test_method(23);
print $test_object->{test_property} . "\n";