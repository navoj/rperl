# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Reference;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
# DEV NOTE: must pre-declare string_hashref_method and object types here, because this file appears on a lower line number in rperltypes.pm
#require RPerl::CodeBlock::Subroutine::Method;
package string_hashref_method;

#require RPerl::Object;
package object;

package RPerl::DataStructure::Hash::Reference;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Hash::Reference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap HashReference_200 & HashReference_201 from SubExpression_135
    if ( $self_class eq 'SubExpression_135' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'HashReference_200' ) { # HashReference -> LBRACE HashEntry STAR-50 '}'
        my string $left_brace        = $self->{children}->[0];
        my object $hash_entry        = $self->{children}->[1];
        my object $hash_entries_star = $self->{children}->[2];
        my string $right_brace       = $self->{children}->[3];

        $rperl_source_group->{PMC} .= $left_brace;
        my string_hashref $rperl_source_subgroup
            = $hash_entry->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );

        foreach my $hash_entry_star ( @{ $hash_entries_star->{children} } ) {
            if ( ref $hash_entry_star eq 'TERMINAL' ) {
                if ( $hash_entry_star->{attr} ne q{,} ) {
                    die RPerl::Parser::rperl_rule__replace(
                        q{ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '}
                            . $hash_entry_star->{attr}
                            . q{' found where OP21_LIST_COMMA ',' expected, dying}
                    ) . "\n";
                }
                $rperl_source_group->{PMC}
                    .= $hash_entry_star->{attr} . q{ };    # OP21_LIST_COMMA
            }
            else {
                $rperl_source_subgroup
                    = $hash_entry_star->ast_to_rperl__generate($modes);
                RPerl::Generator::source_group_append( $rperl_source_group,
                    $rperl_source_subgroup );
            }
        }

        $rperl_source_group->{PMC} .= $right_brace;
    }
    elsif ( $self_class eq 'HashReference_201' ) { # HashReference -> LBRACE '}'
        my string $left_brace  = $self->{children}->[0];
        my string $right_brace = $self->{children}->[1];
        $rperl_source_group->{PMC} .= $left_brace . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($self_class)
                . ' found where HashReference_200, HashReference_201, or SubExpression_135 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::H::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::H::R __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

1;    # end of class
