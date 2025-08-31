#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>

#include "coco.h"

SEXP c_coco_set_log_level(SEXP s_log_level) {
  const char *log_level = CHAR(STRING_ELT(s_log_level, 0));
  const char *previous_level = coco_set_log_level(log_level);
  return Rf_mkString(previous_level);
}
