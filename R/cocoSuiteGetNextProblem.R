#' @title Get next coco problem.
#' 
#' @description
#' Can be used to iterate through a complete coco problem suite.
#'
#' @template arg_suite
#' @return problem [\code{\link{CocoProblem}} | \code{NULL}]\cr
#'   Coco problem. \code{NULL} is returned if no problems are left.
#' @export
#' @useDynLib rcoco c_cocoSuiteGetNextProblem
cocoSuiteGetNextProblem = function(suite) {
  assertClass(suite, "CocoSuite")
  p = .Call(c_cocoSuiteGetNextProblem, suite)
  if (!is.null(p)) {
    names(p) = c("extptr", "id", "index", "name", "nr.of.objectives", "dimension", "nr.of.constraints", "lower", "upper")
    class(p) = "CocoProblem"
  }
  return(p)
}

