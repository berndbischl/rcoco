#include "rcoco_helpers.h"

void set_class(SEXP s_obj, const char *class_name) {
  SEXP s_attr = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(s_attr, 0, mkChar(class_name));
  setAttrib(s_obj, R_ClassSymbol, s_attr);
  UNPROTECT(1); // s_attr
}

void set_names(SEXP s_obj, int n, const char **names) {
  SEXP s_names = PROTECT(allocVector(STRSXP, n));
  for (int i = 0; i < n; i++) {
    SET_STRING_ELT(s_names, i, mkChar(names[i]));
  }
  setAttrib(s_obj, R_NamesSymbol, s_names);
  UNPROTECT(1); // s_names
}

SEXP s_int_create_PROTECT(int k) {
  SEXP s_res = PROTECT(ScalarInteger(k));
  return s_res;
}

SEXP s_vecint_create_PROTECT(int n) {
  SEXP s_res = PROTECT(allocVector(INTSXP, n));
  return s_res;
}

SEXP s_vecdbl_create_PROTECT(int n) {
  SEXP s_res = PROTECT(allocVector(REALSXP, n));
  return s_res;
}

SEXP s_vecdbl_create_init_PROTECT(int n, const double *values) {
  SEXP s_res = PROTECT(allocVector(REALSXP, n));
  memcpy(REAL(s_res), values, n * sizeof(double));
  return s_res;
}

SEXP s_list_create_PROTECT(int n, const char **names) {
  SEXP s_res = PROTECT(allocVector(VECSXP, n));
  set_names(s_res, n, names);
  return s_res;
}

SEXP s_df_create_PROTECT(int n_rows, int n_cols, const char **col_names) {
  SEXP s_res = PROTECT(allocVector(VECSXP, n_cols));
  set_class(s_res, "data.frame");
  set_names(s_res, n_cols, col_names);
  // Set row names to sequential numbers starting from 1
  SEXP s_row_names = PROTECT(allocVector(INTSXP, n_rows));
  for (int i = 0; i < n_rows; i++) {
    INTEGER(s_row_names)[i] = i + 1;
  }
  setAttrib(s_res, R_RowNamesSymbol, s_row_names);
  UNPROTECT(1); // s_row_names

  return s_res;
}

void set_r6_member(SEXP s_obj, const char *member_name, SEXP s_value) {
  SEXP s_sym = PROTECT(install(member_name));
  defineVar(s_sym, s_value, s_obj);
  UNPROTECT(1); // s_member_sym
}

SEXP get_r6_member(SEXP s_obj, const char *member_name) {
  return findVarInFrame(s_obj, install(member_name));
}
