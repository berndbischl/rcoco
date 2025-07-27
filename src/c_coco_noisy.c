#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "bbobStructures.h"
#include "benchmarksnoisy.h"


#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>

#include "coco.h"
#include "rcoco_helpers.h"


 // from bbob (old code version) :
 //     Noisy functions testbed. All functions are ranged in [-5, 5]^DIM."
 

SEXP c_coco_eval_noisy(SEXP s_fun_idx, SEXP s_x) {
    //if (Rf_length(s_x) != dim) {
    //    Rf_error("Input vector length %d does not match problem dimension %u", Rf_length(s_x), dim);
    //}

    int fun_idx = Rf_asInteger(s_fun_idx);
    bbobFunction f = handlesNoisy[fun_idx];
    double *x = REAL(s_x);
    TwoDoubles res = f(x);
    SEXP s_y = s_vecdbl_create_PROTECT(2);
    REAL(s_y)[0] = res.Ftrue;
    REAL(s_y)[1] = res.Fval;
    UNPROTECT(1); // s_y
    return s_y;
}


