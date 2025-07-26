#ifndef RCOCO_HELPERS_H
#define RCOCO_HELPERS_H

#include <R.h>
#include <Rinternals.h>


// set class attribute for a arbitrary R object
void set_class(SEXP s_obj, const char* class_name);

// set names attribute for a arbitrary / many R objects
void set_names(SEXP s_obj, int n, const char** names);

// create int scalar
SEXP s_int_create_PROTECT(int k);

// create intvec with n elements
SEXP s_vecint_create_PROTECT(int n);

// create doublevec with n elements
SEXP s_vecdbl_create_PROTECT(int n);

// create named list with n elements and names
SEXP s_list_create_PROTECT(int n, const char** names);

// create dataframe with n_cols columns and col_names
SEXP s_df_create_PROTECT(int n_rows, int n_cols, const char** col_names);

// set a member variable slot in an R6 object
void set_r6_member(SEXP s_obj, const char* member_name, SEXP s_value);

// get a member variable slot in an R6 object
SEXP get_r6_member(SEXP s_obj, const char* member_name);

#endif // RCOCO_HELPERS_H 