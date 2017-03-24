#' @title Get specific coco problem.
#' 
#' @description
#' See title.
#'
#' @template arg_suite
#' @param index [\code{integer(1)}]\cr
#'   Problem index.
#' @template ret_problem
#' @export
#' @useDynLib rcoco c_cocoSuiteGetNextProblem
cocoSuiteGetProblem = function(suite, index) {
  assertClass(suite, "CocoSuite")
  p = .Call(c_cocoSuiteGetNextProblem, suite)
  names(p) = c("extptr", "id", "name", "nr.of.objectives", "dimension", "nr.of.constraints", "lower", "upper")
  class(p) = "CocoProblem"
  return(p)
}


