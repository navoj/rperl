////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h 1

#include <types_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm::Sort;
#include <RPerl/Algorithm/Sort.cpp>			// -> Sort.h

////use RPerl::Algorithm::Inefficient;
#include <RPerl/Algorithm/Inefficient.cpp>		// -> Inefficient.h

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
SV* bubblesort(SV* data);
// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Bubble(SV* person);
//SV* uninherited(SV* person);  // PERL_TYPES

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
//class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort  // SINGLE INHERITANCE
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort, public CPP__RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort();  // NEED ANSWER: no named argument required for $self object?
// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(SV* person);
//	void inherited(SV* person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	SV* get_data() { return SvREFCNT_inc(this->data); }
	void set_data(SV* data_new) { this->data = data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm__Sort__Bubble() {}
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties = ( data => my integer__array_ref $KEY_data );
	SV* data;
};

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
integer__array_ref bubblesort(integer__array_ref data);
// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Bubble(SV* person);  // NEED UPGRADE TO CPP_TYPES!!!
//char *uninherited(char *person);  // CPP_TYPES

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
//class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort  // SINGLE INHERITANCE
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort, public CPP__RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort();  // NEED ANSWER: no named argument required for $self object?
// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(SV* person);  // NEED UPGRADE TO CPP_TYPES!!!
//	void inherited(SV* person);  // NEED UPGRADE TO CPP_TYPES!!!

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	integer__array_ref get_data() { return(this->data); }
	void set_data(integer__array_ref data_new) { this->data = data_new; }  // NEED ANSWERS: do we need to use some vector copy feature here???

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm__Sort__Bubble() {}
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties = ( data => my integer__array_ref $KEY_data );
	integer__array_ref data;
};

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif
