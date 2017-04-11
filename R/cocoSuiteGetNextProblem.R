#' @title Get next coco problem.
#'
#' @description
#' Can be used to iterate through a complete coco problem suite.
#'
#' @template arg_suite
#' @template arg_observer
#' @return problem [\code{\link{CocoProblem}} | \code{NULL}]\cr
#'   Coco problem. \code{NULL} is returned if no problems are left.
#' @export
#' @useDynLib rcoco c_cocoSuiteGetNextProblem
cocoSuiteGetNextProblem = function(suite, observer) {
  assertClass(suite, "CocoSuite")
  assertClass(observer, "CocoObserver")
  p = .Call(c_cocoSuiteGetNextProblem, suite, observer)
  if (!is.null(p))
    p = makeCocoProblem(p)
  return(p)
}

