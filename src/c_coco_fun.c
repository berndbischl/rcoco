#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "coco.h"

SEXP c_coco_eval(SEXP s_problem, SEXP s_x) {
    coco_problem_t *problem = (coco_problem_t*) R_ExternalPtrAddr(s_problem);
    if (problem == NULL) error("Invalid problem pointer");
    size_t dim = coco_problem_get_dimension(problem);
    size_t n_obj = coco_problem_get_number_of_objectives(problem);
    if (length(s_x) != dim) {
        error("Input vector length %d does not match problem dimension %zu", length(s_x), dim);
    }
    double *x = REAL(s_x);
    SEXP s_y = PROTECT(allocVector(REALSXP, n_obj));
    double *y = REAL(s_y);
    coco_evaluate_function(problem, x, y);
    UNPROTECT(1); // s_y
    return s_y;
}

SEXP c_coco_fun(SEXP s_suite, SEXP s_fun_idx, SEXP s_dim_idx, SEXP s_inst_idx) {
    coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 0));
    const int fun_idx = asInteger(s_fun_idx);
    const int dim_idx = asInteger(s_dim_idx);
    const int inst_idx = asInteger(s_inst_idx); 

    size_t problem_idx = coco_suite_encode_problem_index(suite, fun_idx, dim_idx, inst_idx);

    coco_problem_t *problem = coco_suite_get_problem(suite, problem_idx);
    if (problem == NULL) error("Failed to create COCO function");
    SEXP s_problem = PROTECT(R_MakeExternalPtr(problem, R_NilValue, R_NilValue));
    R_RegisterCFinalizer(s_problem, (R_CFinalizer_t) coco_problem_free);

    // create result list
    SEXP s_result = PROTECT(allocVector(VECSXP, 1));
    SET_VECTOR_ELT(s_result, 0, s_problem);
    
    // set list names and class
    SEXP s_names = PROTECT(allocVector(STRSXP, 1));
    SET_STRING_ELT(s_names, 0, mkChar("problem_ptr"));
    setAttrib(s_result, R_NamesSymbol, s_names);
    SEXP s_class = PROTECT(allocVector(STRSXP, 1));
    SET_STRING_ELT(s_class, 0, mkChar("coco_fun"));
    setAttrib(s_result, R_ClassSymbol, s_class);
    
    UNPROTECT(7); // s_result, s_problem, eval, rho, eval_fun, s_eval, s_names, s_class
    return s_result;
}

