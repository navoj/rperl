#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "my string_hashref $foo = {'a' => '42','b' => 'is','c' => 'the','d' => 'answer'};" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my unknown $foo = undef;
$foo = 23;
$foo = 9_123.456_789;
$foo = 'howdy';
$foo = { a => '42', b => 'is', c => 'the', d => 'answer' };

$Data::Dumper::Indent = 0;
print scope_type_name_value($foo) . "\n";