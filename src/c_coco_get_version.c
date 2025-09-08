#define R_NO_REMAP
#include "coco.h"
#include <R.h>
#include <Rinternals.h>

SEXP c_coco_get_version() { return Rf_mkString(coco_version); }
