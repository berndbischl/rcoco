#' @title Get next coco problem.
#' 
#' @description
#' Can be used to iterate through a complete coco problem suite.
#'
#' @template arg_suite
#' @template ret_problem
#' @export
#' @useDynLib rcoco c_cocoSuiteGetNextProblem
cocoSuiteGetNextProblem = function(suite) {
  assertClass(suite, "CocoSuite")
  p = .Call(c_cocoSuiteGetNextProblem, suite)
  names(p) = c("extptr", "id", "name", "nr.of.objectives", "dimension", "nr.of.constraints", "lower", "upper")
  class(p) = "CocoProblem"
  return(p)
}

