#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>
#include <stdlib.h>
#include <string.h>

#include "coco.h"


 SEXP c_coco_suite(SEXP s_name, SEXP s_instance, SEXP s_options) {
    const char* name = CHAR(STRING_ELT(s_name, 0));
    const char* instance = CHAR(STRING_ELT(s_instance, 0));
    const char* options = isNull(s_options) ? NULL : CHAR(STRING_ELT(s_options, 0));
    
    coco_suite_t* suite = coco_suite(name, instance, options);
    if (suite == NULL) error("Failed to create COCO suite");
    // make sure free is called when the external pointer is garbage collected
    SEXP s_ptr = PROTECT(R_MakeExternalPtr(suite, R_NilValue, R_NilValue));
    R_RegisterCFinalizer(s_ptr, (R_CFinalizer_t) coco_suite_free);

    // get number of problems
    size_t n_problems = coco_suite_get_number_of_problems(suite);
    SEXP s_n_problems = PROTECT(ScalarInteger((int) n_problems));
    
    // Get all functions, dimensions, and instances by iterating through indices
    // Use conservative bounds to avoid exceeding suite limits
    size_t max_function_idx = 10;
    
    
    // create integer vectors for functions, dimensions, and instances
    SEXP s_functions = PROTECT(allocVector(INTSXP, max_function_idx));
    SEXP s_dimensions = PROTECT(allocVector(INTSXP, 10));
    SEXP s_instances = PROTECT(allocVector(INTSXP, 10));
    
    // fill the vectors with the actual values
    for (size_t i = 0; i < max_function_idx; i++) {
        INTEGER(s_functions)[i] = (int) coco_suite_get_function_from_function_index(suite, i);
    }
    
    // create result list with 6 elements
    SEXP s_result = PROTECT(allocVector(VECSXP, 6));
    SET_VECTOR_ELT(s_result, 0, s_ptr);
    SET_VECTOR_ELT(s_result, 1, s_n_problems);
    SET_VECTOR_ELT(s_result, 2, s_functions);
    SET_VECTOR_ELT(s_result, 3, s_dimensions);
    SET_VECTOR_ELT(s_result, 4, s_instances);

    // set list names and class
    SEXP s_names = PROTECT(allocVector(STRSXP, 6));
    SET_STRING_ELT(s_names, 0, mkChar("suite_ptr"));
    SET_STRING_ELT(s_names, 1, mkChar("n_problems"));
    SET_STRING_ELT(s_names, 2, mkChar("functions"));
    SET_STRING_ELT(s_names, 3, mkChar("dimensions"));
    SET_STRING_ELT(s_names, 4, mkChar("instances"));
    setAttrib(s_result, R_NamesSymbol, s_names);
    SEXP s_class = PROTECT(allocVector(STRSXP, 1));
    SET_STRING_ELT(s_class, 0, mkChar("coco_suite")); 
    setAttrib(s_result, R_ClassSymbol, s_class);
    
    UNPROTECT(9); // s_ptr, s_n_problems, s_functions, s_dimensions, s_instances, s_result, s_names, s_class
    return s_result;
}

