# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::ArrayDereference;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my object $rperl_source_subgroup;

#    RPerl::diag( 'in ArrayDereference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    # unwrap ArrayDereference_189 and ArrayDereference_189 from SubExpression_134
    if ( $self_class eq 'SubExpression_134' ) {  # SubExpression -> ArrayDereference
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'ArrayDereference_189' ) {  # ArrayDereference -> '@{' Variable '}'
        my string $at_left_brace = $self->{children}->[0];
        my object $variable = $self->{children}->[1];
        my string $right_brace = $self->{children}->[2];
 
        $rperl_source_group->{PMC} .= $at_left_brace . q{ };
        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    elsif ( $self_class eq 'ArrayDereference_190' ) {  # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
        my string $at_left_brace = $self->{children}->[0];
        my object $type_inner_optional = $self->{children}->[1];
        my object $array_reference = $self->{children}->[2];
        my string $right_brace = $self->{children}->[3];
 
        $rperl_source_group->{PMC} .= $at_left_brace . q{ };
        if (exists $type_inner_optional->{children}->[0]) {
            $rperl_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= q{ };
        }
        $rperl_source_subgroup = $array_reference->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where ArrayDereference_189 or ArrayDereference_190 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::AD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::AD __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
