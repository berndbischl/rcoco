createProblem = function(p) {
  names(p) = c("extptr", "id", "index", "name", "nr.of.objectives", "dimension", "nr.of.constraints", 
    "lower", "upper", "initial.solution")
  class(p) = "CocoProblem"
  return(p)
}
