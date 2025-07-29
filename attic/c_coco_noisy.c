#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "bbobStructures.h"
#include "benchmarksnoisy.h"
#include "benchmarkshelper.h"

#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "coco.h"
#include "rcoco_helpers.h"

extern int DIM;


 // from bbob (old code version) :
 //     Noisy functions testbed. All functions are ranged in [-5, 5]^DIM."
 

// Package initialization function
SEXP c_coco_init_noisy() {
    initbenchmarkshelper();
    initbenchmarksnoisy();
    return R_NilValue;
}

// Package cleanup function
SEXP c_coco_finit_noisy() {
    finibenchmarkshelper();
    finibenchmarksnoisy();
    return R_NilValue;
}

SEXP c_coco_suite_noisy(SEXP s_suite) {
    // Initialization is now handled during package load
    return R_NilValue;
}

SEXP c_coco_eval_noisy(SEXP s_fun_idx, SEXP s_dim, SEXP s_x) {
    int fun_idx = Rf_asInteger(s_fun_idx);
    bbobFunction f = handlesNoisy[fun_idx];
    int dim = Rf_asInteger(s_dim);
    if (Rf_length(s_x) != dim) {
        Rf_error("Input vector length %d does not match problem dimension %u", Rf_length(s_x), dim);
    }
    double *x = REAL(s_x);
    DIM = dim;
    TwoDoubles res = f(x);
    SEXP s_y = s_vecdbl_create_PROTECT(2);
    REAL(s_y)[0] = res.Ftrue;
    REAL(s_y)[1] = res.Fval;
    UNPROTECT(1); // s_y
    return s_y;
}


