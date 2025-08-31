#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>
#include <stdlib.h>
#include <string.h>

#include "coco.h"
#include "rcoco_helpers.h"

void suite_finalizer(SEXP s_suite) {
  SEXP s_suite_ptr = get_r6_member(s_suite, "suite_ptr");
  SEXP s_observer_ptr = get_r6_member(s_suite, "observer_ptr");
  coco_suite_t *suite = R_ExternalPtrAddr(s_suite_ptr);
  if (!Rf_isNull(s_observer_ptr)) {
    coco_observer_t *observer = R_ExternalPtrAddr(s_observer_ptr);
    coco_observer_free(observer);
    R_ClearExternalPtr(s_observer_ptr); // avoid double free
  }
  if (suite != NULL) {
    coco_suite_free(suite);
    R_ClearExternalPtr(s_suite_ptr); // avoid double free
  }
}

SEXP c_coco_suite(SEXP s_name, SEXP s_instance, SEXP s_observer_name,
                  SEXP s_observer_options, SEXP s_self) {
  const char *name = CHAR(STRING_ELT(s_name, 0));
  const char *instance = CHAR(STRING_ELT(s_instance, 0));

  // create suite and get number of problems
  coco_suite_t *suite = coco_suite(name, instance, NULL);
  if (suite == NULL)
    Rf_error("Failed to create COCO suite");
  // make sure free is called when the external pointer is garbage collected
  SEXP s_ptr = PROTECT(R_MakeExternalPtr(suite, R_NilValue, R_NilValue));
  R_RegisterCFinalizer(s_self, (R_CFinalizer_t)suite_finalizer);
  size_t n_problems = coco_suite_get_number_of_problems(suite);

  // loop through all problems to extract information
  SEXP s_problem_idx = s_vecint_create_PROTECT(n_problems);
  SEXP s_fun_idx = s_vecint_create_PROTECT(n_problems);
  SEXP s_fun = s_vecint_create_PROTECT(n_problems);
  SEXP s_dim_idx = s_vecint_create_PROTECT(n_problems);
  SEXP s_dim = s_vecint_create_PROTECT(n_problems);
  SEXP s_inst_idx = s_vecint_create_PROTECT(n_problems);
  SEXP s_inst = s_vecint_create_PROTECT(n_problems);
  for (size_t i = 0; i < n_problems; i++) {
    size_t fun_idx, dim_idx, inst_idx;
    coco_suite_decode_problem_index(suite, i, &fun_idx, &dim_idx, &inst_idx);
    INTEGER(s_problem_idx)[i] = (int)i;
    INTEGER(s_fun_idx)[i] = fun_idx;
    INTEGER(s_fun)
    [i] = coco_suite_get_function_from_function_index(suite, fun_idx);
    INTEGER(s_dim_idx)[i] = dim_idx;
    INTEGER(s_dim)
    [i] = coco_suite_get_dimension_from_dimension_index(suite, dim_idx);
    INTEGER(s_inst_idx)[i] = inst_idx;
    INTEGER(s_inst)
    [i] = coco_suite_get_instance_from_instance_index(suite, inst_idx);
  }

  // // create data
  const char *data_col_names[] = {"problem_idx", "fun_idx",  "fun", "dim_idx",
                                  "dim",         "inst_idx", "inst"};
  SEXP s_data = s_df_create_PROTECT(n_problems, 7, data_col_names);
  SET_VECTOR_ELT(s_data, 0, s_problem_idx);
  SET_VECTOR_ELT(s_data, 1, s_fun_idx);
  SET_VECTOR_ELT(s_data, 2, s_fun);
  SET_VECTOR_ELT(s_data, 3, s_dim_idx);
  SET_VECTOR_ELT(s_data, 4, s_dim);
  SET_VECTOR_ELT(s_data, 5, s_inst_idx);
  SET_VECTOR_ELT(s_data, 6, s_inst);

  // set results
  set_r6_member(s_self, "suite_ptr", s_ptr);
  SEXP s_n_problems = s_int_create_PROTECT((int)n_problems);
  set_r6_member(s_self, "n_problems", s_n_problems);
  set_r6_member(s_self, "data", s_data);

  // create observer -- if requested
  if (!Rf_isNull(s_observer_name)) {
    const char *observer_name = CHAR(STRING_ELT(s_observer_name, 0));
    const char *observer_options = CHAR(STRING_ELT(s_observer_options, 0));
    coco_observer_t *observer = coco_observer(observer_name, observer_options);
    SEXP s_observer_ptr =
        PROTECT(R_MakeExternalPtr(observer, R_NilValue, R_NilValue));
    set_r6_member(s_self, "observer_ptr", s_observer_ptr);
    // observer will be freed by suite_finalizer
    UNPROTECT(1); // s_observer_ptr
  }

  UNPROTECT(10); // s_ptr, s_problem_idx, s_fun_idx, s_fun, s_dim_idx, s_dim,
                 // s_inst_idx, s_inst, s_data, s_n_problems
  return R_NilValue;
}
