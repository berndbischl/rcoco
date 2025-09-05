
#include <R.h>
#include <R_ext/Rdynload.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL

/* R package native routine registration
 *
 * This file registers C functions with R so they can be called from .Call()
 *
 * Functions registered:
 *    - c_coco_suite: Creates a COCO suite and returns problem information
 *    - c_coco_problem: Retrieves a problem from a suite
 *    - c_coco_eval: Evaluates a candidate point on a COCO problem
 *    - c_coco_set_log_level: Sets the COCO logging level
 *
 * Registration mechanism:
 *   - R_registerRoutines(): Registers C functions for .Call() interface
 *   - R_useDynamicSymbols(FALSE): Prevents lookup of unregistered symbols
 *
 * This file is automatically processed by R during package installation
 */

extern SEXP c_coco_suite(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_coco_problem(SEXP, SEXP, SEXP);
extern SEXP c_coco_eval(SEXP, SEXP);
// extern SEXP c_coco_eval_noisy(SEXP, SEXP, SEXP);
// extern SEXP c_coco_init_noisy();
// extern SEXP c_coco_finit_noisy();
extern SEXP c_coco_set_log_level(SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"c_coco_suite", (DL_FUNC)&c_coco_suite, 5},
  {"c_coco_problem", (DL_FUNC)&c_coco_problem, 3},
  {"c_coco_eval", (DL_FUNC)&c_coco_eval, 2},
  // {"c_coco_eval_noisy", (DL_FUNC) &c_coco_eval_noisy, 3},
  // {"c_coco_init_noisy", (DL_FUNC) &c_coco_init_noisy, 0},
  // {"c_coco_finit_noisy", (DL_FUNC) &c_coco_finit_noisy, 0},
  {"c_coco_set_log_level", (DL_FUNC)&c_coco_set_log_level, 1},
  {NULL, NULL, 0},
};

void R_init_rcoco(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
