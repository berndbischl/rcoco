#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .Call calls */
extern SEXP c_cocoSetLogLevel(SEXP);
extern SEXP c_cocoCloseSuite(SEXP);
extern SEXP c_cocoEvaluateFunction(SEXP, SEXP);
extern SEXP c_cocoInitObserver(SEXP, SEXP);
extern SEXP c_cocoOpenSuite(SEXP, SEXP, SEXP);
extern SEXP c_cocoProblemAddObserver(SEXP, SEXP);
extern SEXP c_cocoProblemFree(SEXP);
extern SEXP c_cocoProblemGetBestObservedFValue(SEXP);
extern SEXP c_cocoProblemGetEvaluations(SEXP);
extern SEXP c_cocoProblemIsFinalTargetHit(SEXP);
extern SEXP c_cocoSuiteGetNextProblem(SEXP, SEXP);
extern SEXP c_cocoSuiteGetNumberOfProblems(SEXP);
extern SEXP c_cocoSuiteGetProblem(SEXP, SEXP);
extern SEXP c_cocoSuiteGetProblemByFunDimInst(SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"c_cocoSetLogLevel", (DL_FUNC)                  &c_cocoSetLogLevel, 1},
    {"c_cocoCloseSuite", (DL_FUNC)                   &c_cocoCloseSuite, 1},
    {"c_cocoEvaluateFunction", (DL_FUNC)             &c_cocoEvaluateFunction, 2},
    {"c_cocoInitObserver", (DL_FUNC)                 &c_cocoInitObserver, 2},
    {"c_cocoOpenSuite", (DL_FUNC)                    &c_cocoOpenSuite, 3},
    {"c_cocoProblemAddObserver", (DL_FUNC)           &c_cocoProblemAddObserver, 2},
    {"c_cocoProblemFree", (DL_FUNC)                  &c_cocoProblemFree, 1},
    {"c_cocoProblemGetBestObservedFValue", (DL_FUNC) &c_cocoProblemGetBestObservedFValue, 1},
    {"c_cocoProblemGetEvaluations", (DL_FUNC)        &c_cocoProblemGetEvaluations, 1},
    {"c_cocoProblemIsFinalTargetHit", (DL_FUNC)      &c_cocoProblemIsFinalTargetHit, 1},
    {"c_cocoSuiteGetNextProblem", (DL_FUNC)          &c_cocoSuiteGetNextProblem, 2},
    {"c_cocoSuiteGetNumberOfProblems", (DL_FUNC)     &c_cocoSuiteGetNumberOfProblems, 1},
    {"c_cocoSuiteGetProblem", (DL_FUNC)              &c_cocoSuiteGetProblem, 2},
    {"c_cocoSuiteGetProblemByFunDimInst", (DL_FUNC)  &c_cocoSuiteGetProblemByFunDimInst, 4},
    {NULL, NULL, 0}
};

void R_init_rcoco(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
