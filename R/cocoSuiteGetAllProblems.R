#' @title Get all problems of a coco suite.
#'
#' @description
#' Iterates through all problems by calling \code{\link{cocoSuiteGetNextProblem}}.
#'
#' @template arg_suite
#' @template arg_observer
#' @return [\code{list} of \code{\link{CocoProblem}}]. Named with coco problem ids.
#' @export
cocoSuiteGetAllProblems = function(suite, observer) {
  assertClass(suite, "CocoSuite")
  assertClass(observer, "CocoObserver")
  problems = list()
  while(!is.null(p <- cocoSuiteGetNextProblem(suite, observer))) {
    problems[[p$id]] = p
  }
  addClasses(problems, "CocoProblemList")
}
