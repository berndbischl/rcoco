#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "coco.h"
#include "rcoco_helpers.h"

SEXP c_coco_eval(SEXP s_problem, SEXP s_x) {
    SEXP s_problem_ptr = get_r6_member(s_problem, "problem_ptr");
    coco_problem_t *problem = (coco_problem_t*) R_ExternalPtrAddr(s_problem_ptr);
    unsigned int dim = asInteger(get_r6_member(s_problem, "dim"));
    unsigned int n_obj = asInteger(get_r6_member(s_problem, "n_obj"));
    if (length(s_x) != dim) {
        error("Input vector length %d does not match problem dimension %u", length(s_x), dim);
    }
    double *x = REAL(s_x);
    SEXP s_y = s_vecdbl_create_PROTECT(n_obj);
    double *y = REAL(s_y);
    coco_evaluate_function(problem, x, y);
    UNPROTECT(1); // s_y
    return s_y;
}


void problem_finalizer(SEXP extptr) {
    coco_problem_t *p = R_ExternalPtrAddr(extptr);
    if (p != NULL) {
        coco_problem_free(p);
        R_ClearExternalPtr(extptr);  // avoid double free
    }
}

SEXP c_coco_problem(SEXP s_suite, SEXP s_problem_idx, SEXP s_self) {
    // get suite
    SEXP s_suite_ptr = get_r6_member(s_suite, "suite_ptr");
    const int problem_idx = asInteger(s_problem_idx);
    coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(s_suite_ptr);
    // create problem + external pointer
    coco_problem_t *problem = coco_suite_get_problem(suite, problem_idx);
    if (problem == NULL) error("Failed to create COCO problem");
    SEXP s_problem = PROTECT(R_MakeExternalPtr(problem, R_NilValue, R_NilValue));
    R_RegisterCFinalizer(s_problem, (R_CFinalizer_t) problem_finalizer);
    // get problem info and set members
    const char* name = coco_problem_get_name(problem);
    const char* id = coco_problem_get_id(problem);
    const char* type = coco_problem_get_type(problem);
    const size_t dim = coco_problem_get_dimension(problem);
    const size_t n_obj = coco_problem_get_number_of_objectives(problem);
    const size_t n_constr = coco_problem_get_number_of_constraints(problem);
    const size_t n_int = coco_problem_get_number_of_integer_variables(problem);
    set_r6_member(s_self, "problem_ptr", s_problem);
    set_r6_member(s_self, "name", PROTECT(mkString(name)));
    set_r6_member(s_self, "id", PROTECT(mkString(id)));
    set_r6_member(s_self, "type", PROTECT(mkString(type)));
    set_r6_member(s_self, "dim", PROTECT(ScalarInteger(dim)));
    set_r6_member(s_self, "n_obj", PROTECT(ScalarInteger(n_obj)));
    set_r6_member(s_self, "n_constr", PROTECT(ScalarInteger(n_constr)));
    set_r6_member(s_self, "n_int", PROTECT(ScalarInteger(n_int)));
    UNPROTECT(8); // s_problem, 7x members
    return R_NilValue;
}

