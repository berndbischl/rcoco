#' @title Get all problems of a coco suite.
#'
#' @description
#' Iterates through all problems by calling \code{\link{cocoSuiteGetNextProblem}}.
#'
#' @template arg_suite
#' @return [\code{list} of \code{\link{CocoProblem}}]. Named with coco problem ids.
#' @export
cocoSuiteGetAllProblems = function(suite) {
  assertClass(suite, "CocoSuite")
  problems = list()
  while(!is.null(p <- cocoSuiteGetNextProblem(suite))) {
    problems[[p$id]] = p
  }
  addClasses(problems, "CocoProblemList")
}
