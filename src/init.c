#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

extern SEXP c_coco_suite(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_coco_problem(SEXP, SEXP, SEXP);
extern SEXP c_coco_eval(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"c_coco_suite", (DL_FUNC) &c_coco_suite, 5},
    {"c_coco_problem", (DL_FUNC) &c_coco_problem, 3},
    {"c_coco_eval", (DL_FUNC) &c_coco_eval, 2},
    {NULL, NULL, 0}
};

void R_init_rcoco(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
    