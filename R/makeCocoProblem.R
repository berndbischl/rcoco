# internal helper to fully create the class (which is partailly created by C code...)
makeCocoProblem = function(p) {
  names(p) = c("extptr", "id", "index", "name", "nr.of.objectives", "dimension", "nr.of.constraints", 
    "lower", "upper", "initial.solution")
  class(p) = "CocoProblem"
  m = stri_match(p$id, regex = "bbob_f(\\d+)_i(\\d+)_d(\\d+)")
  p$fun.nr = as.integer(m[1L, 2L])
  p$inst.nr = as.integer(m[1L, 3L])
  return(p)
}

