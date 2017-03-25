#' @title Get specific coco problem.
#' 
#' @description
#' NB: If the problem index is too large, coco might just issue a warning and return a different
#' problem.
#'
#' @template arg_suite
#' @param index [\code{integer(1)}]\cr
#'   Problem index. Note that coco indices start at 0!
#' @template ret_problem
#' @export
#' @useDynLib rcoco c_cocoSuiteGetProblem
cocoSuiteGetProblem = function(suite, index) {
  assertClass(suite, "CocoSuite")
  index = asInt(index, lower = 0, upper = suite$nr.of.problems - 1L)
  p = .Call(c_cocoSuiteGetProblem, suite, index)
  names(p) = c("extptr", "id", "index", "name", "nr.of.objectives", "dimension", "nr.of.constraints", 
    "lower", "upper", "initial.solution")
  class(p) = "CocoProblem"
  return(p)
}


