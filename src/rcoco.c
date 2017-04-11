#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>
#include <stdarg.h>
#include "macros.h"
#include "coco.h"


SEXP c_cocoSetLogLevel(SEXP s_level) {
  coco_set_log_level(STRING_VALUE(s_level));
  return R_NilValue;
}


/* SEXP c_cocoOpenSuite(SEXP s_suite_name, SEXP s_observer_name, SEXP s_result_folder) { */
// SEXP c_cocoOpenSuite(SEXP s_suite_name, SEXP s_suite_instance, SEXP s_suite_options, SEXP result_folder) {
SEXP c_cocoOpenSuite(SEXP s_suite_name, SEXP s_suite_instance, SEXP s_suite_options) {
  /* const char* suite_name = STRING_VALUE(s_suite_name); */
  /* const char* observer_name = STRING_VALUE(s_observer_name); */
  /* const char* result_folder = STRING_VALUE(s_result_folder); */
  SEXP s_res = PROTECT(NEW_LIST(2));

  /* Set some options for the observer. See documentation for other options. */
  // char *observer_options =
  //     coco_strdupf("result_folder: %s "
  //                  "algorithm_name: RS "
  //                  "algorithm_info: \"A simple random search algorithm\"", result_folder);

  /* Initialize the suite and observer.
   *
   * For more details on how to change the default options, see
   * http://numbbo.github.io/coco-doc/C/#suite-parameters and
   * http://numbbo.github.io/coco-doc/C/#observer-parameters. */
  coco_suite_t* suite = coco_suite(STRING_VALUE(s_suite_name), STRING_VALUE(s_suite_instance),
      STRING_VALUE(s_suite_options));
  // coco_observer_t* observer = coco_observer("bbob", observer_options);
  // coco_free_memory(observer_options);

  /* SET_VECTOR_ELT(s_res, 0, PROTECT(mkString(suite_name))); */
  SET_VECTOR_ELT(s_res, 0, PROTECT(R_MakeExternalPtr(suite, R_NilValue, R_NilValue)));
  /* SET_VECTOR_ELT(s_res, 2, PROTECT(mkString(observer_name))); */
  //SET_VECTOR_ELT(s_res, 1, PROTECT(R_MakeExternalPtr(observer, R_NilValue, R_NilValue)));

  SET_VECTOR_ELT(s_res, 1, PROTECT(ScalarInteger(coco_suite_get_number_of_problems(suite))));

  UNPROTECT(3); /* s_res */
  return s_res;
}

SEXP c_cocoCloseSuite(SEXP s_suite) {
  coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 0));
  /* coco_observer_t* observer = (coco_observer_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 3)); */
  /* coco_observer_free(observer); */
  coco_suite_free(suite);
  return R_NilValue;
}

SEXP c_cocoCreateProblem(coco_problem_t* problem) {
  /* if problem not found, lets return NULL */
  if (problem == NULL)
    return R_NilValue;
  const char* p_id = coco_problem_get_id(problem);
  size_t p_index = coco_problem_get_suite_dep_index(problem);
  const char* p_name = coco_problem_get_name(problem);
  size_t p_nrobjs = coco_problem_get_number_of_objectives(problem);
  size_t p_dim = coco_problem_get_dimension(problem);
  size_t p_nconstraints = coco_problem_get_number_of_constraints(problem);
  SEXP s_res = PROTECT(NEW_LIST(10));
  SET_VECTOR_ELT(s_res, 0, PROTECT(R_MakeExternalPtr(problem, R_NilValue, R_NilValue)));
  SET_VECTOR_ELT(s_res, 1, PROTECT(mkString(p_id)));
  SET_VECTOR_ELT(s_res, 2, PROTECT(ScalarInteger(p_index)));
  SET_VECTOR_ELT(s_res, 3, PROTECT(mkString(p_name)));
  SET_VECTOR_ELT(s_res, 4, PROTECT(ScalarInteger(p_nrobjs)));
  SET_VECTOR_ELT(s_res, 5, PROTECT(ScalarInteger(p_dim)));
  SET_VECTOR_ELT(s_res, 6, PROTECT(ScalarInteger(p_nconstraints)));

  const double *p_lower = coco_problem_get_smallest_values_of_interest(problem);
  const double *p_upper = coco_problem_get_largest_values_of_interest(problem);
  SEXP s_lower = PROTECT(allocVector(REALSXP, p_dim));
  SEXP s_upper = PROTECT(allocVector(REALSXP, p_dim));
  double* lower = REAL(s_lower);
  double* upper = REAL(s_upper);
  for (int i=0; i<p_dim; i++) {
    lower[i] = p_lower[i];
    upper[i] = p_upper[i];
  }
  SET_VECTOR_ELT(s_res, 7, s_lower);
  SET_VECTOR_ELT(s_res, 8, s_upper);

  SEXP s_initsol = PROTECT(allocVector(REALSXP, p_dim));
  double* initsol = REAL(s_initsol);
  coco_problem_get_initial_solution(problem, initsol);
  SET_VECTOR_ELT(s_res, 9, s_initsol);

  UNPROTECT(11); /* s_res */
  return s_res;
}

SEXP c_cocoSuiteGetNextProblem(SEXP s_suite, SEXP s_observer) {
  coco_observer_t* observer = (coco_observer_t*) R_ExternalPtrAddr(VECTOR_ELT(s_observer, 0));
  coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 0));

  /* Set some options for the observer. See documentation for other options. */
  /* char *observer_options = */
      /* coco_strdupf("result_folder: %s " */
                   /* "algorithm_name: RS " */
                   /* "algorithm_info: \"A simple random search algorithm\"", ""); */

  /* Initialize the suite and observer.
   *
   * For more details on how to change the default options, see
   * http://numbbo.github.io/coco-doc/C/#suite-parameters and
   * http://numbbo.github.io/coco-doc/C/#observer-parameters. */

  /* coco_observer_t* observer = coco_observer("bbob", observer_options); */
  /* coco_free_memory(observer_options); */

  coco_problem_t* problem = coco_suite_get_next_problem(suite, NULL);
  return c_cocoCreateProblem(problem);
}

SEXP c_cocoSuiteGetProblem(SEXP s_suite, SEXP s_index) {
  coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 0));
  coco_problem_t* problem = coco_suite_get_problem(suite, INTEGER_VALUE(s_index));
  return c_cocoCreateProblem(problem);
}

SEXP c_cocoSuiteGetProblemByFunDimInst(SEXP s_suite, SEXP s_fun, SEXP s_dim, SEXP s_inst) {
  coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 0));
  coco_problem_t* problem = coco_suite_get_problem_by_function_dimension_instance(suite,
    INTEGER_VALUE(s_fun), INTEGER_VALUE(s_dim), INTEGER_VALUE(s_inst));
  return c_cocoCreateProblem(problem);
}

SEXP c_cocoProblemGetEvaluations(SEXP s_problem) {
  coco_problem_t* problem = (coco_problem_t*) R_ExternalPtrAddr(VECTOR_ELT(s_problem, 0));
  size_t nevals = coco_problem_get_evaluations(problem);
  SEXP s_res = PROTECT(ScalarInteger(nevals));
  UNPROTECT(1); /* s_res */
  return s_res;
}

SEXP c_cocoEvaluateFunction(SEXP s_problem, SEXP s_x) {
  coco_problem_t* problem = (coco_problem_t*) R_ExternalPtrAddr(VECTOR_ELT(s_problem, 0));
  size_t p_nrobjs = INTEGER_VALUE(VECTOR_ELT(s_problem, 4));
  double* x = REAL(s_x);
  SEXP s_y = PROTECT(allocVector(REALSXP, p_nrobjs));
  double* y = REAL(s_y);
  coco_evaluate_function(problem, x, y);
  UNPROTECT(1); /* s_x */
  return s_y;
}

SEXP c_cocoProblemIsFinalTargetHit(SEXP s_problem) {
  coco_problem_t* problem = (coco_problem_t*) R_ExternalPtrAddr(VECTOR_ELT(s_problem, 0));
  SEXP s_res = PROTECT(ScalarLogical(coco_problem_final_target_hit(problem)));
  UNPROTECT(1); /* s_res */
  return s_res;
}

SEXP c_cocoSuiteGetNumberOfProblems(SEXP s_suite) {
  coco_suite_t* suite = (coco_suite_t*) R_ExternalPtrAddr(VECTOR_ELT(s_suite, 0));
  size_t nproblems = coco_suite_get_number_of_problems(suite);
  SEXP s_res = PROTECT(ScalarInteger(nproblems));
  UNPROTECT(1); /* s_res */
  return s_res;
}

SEXP c_cocoProblemGetBestObservedFValue(SEXP s_problem) {
  coco_problem_t* problem = (coco_problem_t*) R_ExternalPtrAddr(VECTOR_ELT(s_problem, 0));
  SEXP s_res = PROTECT(ScalarReal(coco_problem_get_best_observed_fvalue1(problem)));
  UNPROTECT(1); /* s_res */
  return s_res;
}

SEXP c_cocoProblemAddObserver(SEXP s_problem, SEXP s_observer) {
  coco_problem_t* problem = (coco_problem_t*) R_ExternalPtrAddr(VECTOR_ELT(s_problem, 0));
  coco_observer_t* observer = (coco_observer_t*) R_ExternalPtrAddr(VECTOR_ELT(s_observer, 0));

  coco_problem_t* observed_problem = coco_problem_add_observer(problem, observer);
  return c_cocoCreateProblem(observed_problem);
}

SEXP c_cocoInitObserver(SEXP s_observer_name, SEXP s_observer_options) {
  const char* observer_name = STRING_VALUE(s_observer_name);
  const char* observer_options = STRING_VALUE(s_observer_options);

  SEXP s_res = PROTECT(NEW_LIST(1));

  coco_observer_t* observer = coco_observer(observer_name, observer_options);

  SET_VECTOR_ELT(s_res, 0, PROTECT(R_MakeExternalPtr(observer, R_NilValue, R_NilValue)));
  UNPROTECT(2); /* s_res */
  return s_res;
}
