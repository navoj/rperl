## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_200;

# [[[ CRITICS ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 9: allow complex processing with open filehandle

# [[[ INCLUDES ]]]

use RPerl::Parser;
use RPerl::Generator;
use File::Temp qw(tempfile);
use File::Basename;
use English qw(-no_match_vars); # for $OSNAME; why isn't this included from 'require RPerl::Config', which is included from 'use RPerl' above?

# [[[ SUBROUTINES ]]]

# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]

our void $rperl_to_rperl__parse_generate = sub {
    (   my string $rperl_input_file_name,
        my string_hashref $rperl_output_file_name_group,
        my string_hashref $modes
    ) = @_;
    my object $rperl_ast;
    my string_hashref $rperl_source_group;

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' ) )
    {
        $rperl_ast
            = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO RPERL ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' ) )
    {
        $rperl_source_group
            = RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE RPERL TO DISK ]]]

    if ( $modes->{compile} eq 'SAVE' ) {
        save_source_files( $rperl_source_group,
            $rperl_output_file_name_group );
    }
};

# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]

our void $rperl_to_xsbinary__parse_generate_compile = sub {
    (   my string $rperl_input_file_name,
        my string_hashref $cpp_output_file_name_group,
        my string_hashref $modes
    ) = @_;
    my object $rperl_ast;
    my string_hashref $source_group;

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $rperl_ast
            = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO C++ ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $source_group
            = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE C++ TO DISK ]]]

    if (   ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        save_source_files( $source_group, $cpp_output_file_name_group );
    }

    # [[[ COMPILE C++ TO XS & BINARY ]]]

    if ( $modes->{compile} eq 'COMPILE' ) {
        cpp_to_xsbinary__subcompile( $source_group,
            $cpp_output_file_name_group );
    }
};

# generate output file name group(s) based on input file name(s)
#sub generate_output_file_names {
our hashref_arrayref $generate_output_file_names = sub {
    (   my string_arrayref $input_file_names,
        my string_arrayref $output_file_name_prefixes,
        my string_hashref $modes,
        my integer $input_files_count
    ) = @_;

    # NEED FIX: add string_hashref_arrayref type
    #    my string_hashref_arrayref $output_file_name_groups = [];
    my hashref_arrayref $output_file_name_groups = [];
    my string $input_file_name;
    my string $input_file_name_path;
    my string $input_file_name_prefix;
    my string $input_file_name_suffix;

    for my $i ( 0 .. ( $input_files_count - 1 ) ) {
        $input_file_name = $input_file_names->[$i];

        $output_file_name_groups->[$i] = {};

# if output file prefix(es) provided, then use to generate output file name(s)
        if ( defined $output_file_name_prefixes->[$i] ) {

# explicitly provided option should already be only prefix, but fileparse() to make sure
            (   $input_file_name_prefix, $input_file_name_path,
                $input_file_name_suffix
                )
                = fileparse( $output_file_name_prefixes->[$i],
                qr/[.][^.]*/xms );
            if ( $input_file_name_prefix eq q{} ) {
                die
                    "ERROR EARG08: Invalid RPerl source code output file option specified, dying\n";
            }
        }

# if output file prefix(es) not provided, then generate output file name(s) from input file name(s)
        else {
#            RPerl::diag 'have $input_file_name = ' . $input_file_name . "\n";
# should not already be only prefix, fileparse() to isolate prefix
            (   $input_file_name_prefix, $input_file_name_path,
                $input_file_name_suffix
            ) = fileparse( $input_file_name, qr/[.][^.]*/xms );
        }

#        RPerl::diag '$output_file_name_groups->[' . $i . ']' . "\n" . Dumper($output_file_name_groups->[$i]) . "\n";

        my string $output_file_name_path_prefix
            = $input_file_name_path . $input_file_name_prefix;

        # all *.pl input files require EXE output file
        if ( $input_file_name =~ /[.]pl$/xms ) {

# Micro$oft Windows uses *.exe file extension (suffix) for compiled executables
            if ( $OSNAME eq 'MSWin32' ) {
                $output_file_name_groups->[$i]->{EXE}
                    = $output_file_name_path_prefix . '.exe';
            }

 # traditionally, *NIX has no file extension (suffix) for compiled executables
            else {
                $output_file_name_groups->[$i]->{EXE}
                    = $output_file_name_path_prefix;
            }

            if ( $modes->{ops} eq 'CPP' ) {

# *.pl input files in CPPOPS mode requires PMC loader module; *.pl input files in PERLOPS test mode does not require PMC file, only EXE file
                $output_file_name_groups->[$i]->{PMC}
                    = $output_file_name_path_prefix . '.pmc';
            }
        }
        else { # all *.pm input files require PMC output file; PMC is the only output file for *.pm input files in PERLOPS mode
            $output_file_name_groups->[$i]->{PMC}
                = $output_file_name_path_prefix . '.pmc';
        }

        # all CPP ops modes require CPP & H output files
        if ( $modes->{ops} eq 'CPP' ) {
            $output_file_name_groups->[$i]->{CPP}
                = $output_file_name_path_prefix . '.cpp';
            $output_file_name_groups->[$i]->{H}
                = $output_file_name_path_prefix . '.h';
        }

#        RPerl::diag 'in rperl::generate_output_file_names(), bottom of loop ' . $i . ' of ' . $input_files_count . ", have \$output_file_name_groups->[$i] = \n" . Dumper( $output_file_name_groups->[$i] ) . "\n";
    }

    return $output_file_name_groups;
};

# Write Source Code Files To File System
our void $save_source_files = sub {
    ( my string_hashref $source_group, my string_hashref $file_name_group )
        = @_;

#    RPerl::diag( q{in Compiler::save_source_files(), received $source_group =}, "\n", Dumper($source_group), "\n" );
#    RPerl::diag( q{in Compiler::save_source_files(), received $file_name_group =}, "\n", Dumper($file_name_group), "\n" );

    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if (   ( not exists $file_name_group->{$suffix_key} )
            or ( not defined $file_name_group->{$suffix_key} )
            or ( $file_name_group->{$suffix_key} eq q{} ) )
        {
            croak(
                "\nERROR ECVCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking"
            );
        }
    }

    foreach my string $suffix_key ( sort keys %{$file_name_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        if (   ( not exists $source_group->{$suffix_key} )
            or ( not defined $source_group->{$suffix_key} )
            or ( $source_group->{$suffix_key} eq q{} ) )
        {
            croak(
                "\nERROR ECVCOFI01, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix '$suffix_key', but received empty or no value, croaking"
            );
        }
        my filehandleref $SOURCE_FILE_HANDLE;
        my string $file_name = $file_name_group->{$suffix_key};
        my string $source    = $source_group->{$suffix_key};

        if ( $file_name eq '_TEMPFILE' ) {
            ( $SOURCE_FILE_HANDLE, $file_name )
                = tempfile( 'tempfileXXXX', SUFFIX => ( lc $suffix_key ) );

            print {$SOURCE_FILE_HANDLE} $source
                or croak(
                "\nERROR ECVCOFI04, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR"
                );
        }
        else {

            # overwrite existing file
            if ( -f $file_name ) {
                unlink $file_name
                    or croak(
                    "\nERROR ECVCOFI02, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot delete existing file,\ncroaking: $OS_ERROR"
                    );
            }

            open $SOURCE_FILE_HANDLE, '>', $file_name
                or croak(
                "\nERROR ECVCOFI03, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot open file for writing,\ncroaking: $OS_ERROR"
                );

            print {$SOURCE_FILE_HANDLE} $source
                or croak(
                "\nERROR ECVCOFI04, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR"
                );

            close $SOURCE_FILE_HANDLE
                or croak(
                "\nERROR ECVCOFI05, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: $OS_ERROR"
                );
        }

        if ( ( $suffix_key eq 'PMC' ) or ( $suffix_key eq 'EXE' ) ) {

#            `perltidy -pbp --ignore-side-comment-lengths --converge -b -nst -bext='/' -q $file_name`;
            system 'perltidy', '-pbp', '--ignore-side-comment-lengths', '--converge', '-b', '-nst', q{-bext='/'}, '-q', $file_name;
        }
    }

};

# Sub-Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__subcompile = sub {
    ( my string $file_name_group ) = @_;

    RPerl::diag(
        q{in Compiler::cpp_to_xsbinary__subcompile(), received $file_name_group =},
        "\n", Dumper($file_name_group), "\n"
    );

    # ADD CALLS TO TRIGGER Inline::CPP COMPILATION
};

1;    # end of package
