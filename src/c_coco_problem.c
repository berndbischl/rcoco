#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "coco.h"
#include "rcoco_helpers.h"

SEXP c_coco_eval(SEXP s_problem, SEXP s_x) {
  /* Evaluates a candidate point on the target function of a COCO problem
   * Input:
   *    - s_problem: A COCO problem
   *    - s_x: A candidate point
   * Output:
   *    - Value of the target function at s_x
   */
  SEXP s_problem_ptr = get_r6_member(s_problem, "problem_ptr");
  coco_problem_t *problem = (coco_problem_t *)R_ExternalPtrAddr(s_problem_ptr);
  unsigned int dim = Rf_asInteger(get_r6_member(s_problem, "dim"));
  unsigned int n_obj = Rf_asInteger(get_r6_member(s_problem, "n_obj"));
  if (Rf_length(s_x) != dim) {
    Rf_error("Input vector length %d does not match problem dimension %u", Rf_length(s_x), dim);
  }
  double *x = REAL(s_x);
  SEXP s_y = s_vecdbl_create_PROTECT(n_obj);
  double *y = REAL(s_y);
  coco_evaluate_function(problem, x, y);
  UNPROTECT(1); // s_y
  return s_y;
}

void problem_finalizer(SEXP extptr) {
  /* Frees up the memory allocated to a COCO problem
   * Input:
   *    - extptr: A given COCO problem
   * Output:
   *    - None
   */
  coco_problem_t *p = R_ExternalPtrAddr(extptr);
  if (p != NULL) {
    coco_problem_free(p);
    R_ClearExternalPtr(extptr); // avoid double free
  }
}

SEXP c_coco_problem(SEXP s_suite, SEXP s_problem_idx, SEXP s_self) {
  /* Retrieves a problem from a suite and populates an R6 CocoProblem object
   * Input:
   *    - s_suite: The suite that contains the problem
   *    - s_problem_idx: Index of the problem in the suite
   *    - s_self: A CocoProblem object to be populated (Defined in coco_problem.R)
   * Output:
   *    - R_NilValue (the function works by side effect, populates s_self)
   */
  SEXP s_suite_ptr = get_r6_member(s_suite, "suite_ptr"); // get suite
  const int problem_idx = Rf_asInteger(s_problem_idx);
  coco_suite_t *suite = (coco_suite_t *)R_ExternalPtrAddr(s_suite_ptr);
  // create problem + external pointer
  coco_problem_t *problem = coco_suite_get_problem(suite, problem_idx);
  if (problem == NULL) Rf_error("Failed to create COCO problem");
  SEXP s_problem = PROTECT(R_MakeExternalPtr(problem, R_NilValue, R_NilValue));
  R_RegisterCFinalizer(s_problem, (R_CFinalizer_t)problem_finalizer);

  // get problem info and set members
  const char *name = coco_problem_get_name(problem);
  const char *id = coco_problem_get_id(problem);
  const char *type = coco_problem_get_type(problem);
  const size_t dim = coco_problem_get_dimension(problem);
  const size_t n_obj = coco_problem_get_number_of_objectives(problem);
  const size_t n_constr = coco_problem_get_number_of_constraints(problem);
  const size_t n_int = coco_problem_get_number_of_integer_variables(problem);

  // get bounds and target
  const double *lower = coco_problem_get_smallest_values_of_interest(problem);
  const double *upper = coco_problem_get_largest_values_of_interest(problem);
  SEXP s_lower = s_vecdbl_create_init_PROTECT(dim, lower);
  SEXP s_upper = s_vecdbl_create_init_PROTECT(dim, upper);
  double target = coco_problem_get_final_target_fvalue1(problem);
  SEXP s_target = PROTECT(Rf_ScalarReal(target));

  set_r6_member(s_self, "problem_ptr", s_problem);
  set_r6_member(s_self, "name", PROTECT(Rf_mkString(name)));
  set_r6_member(s_self, "id", PROTECT(Rf_mkString(id)));
  set_r6_member(s_self, "type", PROTECT(Rf_mkString(type)));
  set_r6_member(s_self, "dim", PROTECT(Rf_ScalarInteger(dim)));
  set_r6_member(s_self, "n_obj", PROTECT(Rf_ScalarInteger(n_obj)));
  set_r6_member(s_self, "n_constr", PROTECT(Rf_ScalarInteger(n_constr)));
  set_r6_member(s_self, "n_int", PROTECT(Rf_ScalarInteger(n_int)));
  set_r6_member(s_self, "lower", s_lower);
  set_r6_member(s_self, "upper", s_upper);
  set_r6_member(s_self, "target", s_target);

  // get fupper if problem is multi-objective
  if (n_obj > 1) {
    const double *fupper = coco_problem_get_largest_fvalues_of_interest(problem);
    SEXP s_fupper = s_vecdbl_create_init_PROTECT(n_obj, fupper);
    set_r6_member(s_self, "fupper", s_fupper);
    UNPROTECT(1); // s_fupper
  }
  UNPROTECT(11); // s_problem, 7x members, s_lower, s_upper, s_target
  return R_NilValue;
}
