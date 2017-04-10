#' @title Run optimizer on complete coco suite.
#'
#' @description
#' The function is mainly called for its side effect of coco logging of results on disk.
#' It is expected that the caller opens the suite with \code{\link{cocoOpenSuite}} and closes the
#' suite with \code{\link{cocoCloseSuite}}.
#'
#' @template arg_optimizer
#' @template arg_suite
#' @param \ldots [any]\cr
#'   Passed down to \code{optimizer}.
#' @return [\code{list}]. List of results for individual \code{\link{cocoRunOptimizer}} calls.
#'   List is named with coco problem ids.
#' @examples
#'   suite = cocoOpenSuite("bbob", instances = 10:20, dims = c(2, 3), inst.inds = 1:3)
#'
#'   # simple wrapper for Nelder-Mead
#'   cocoOptimizerNelderMead = function(fn, problem, ...) {
#'     optim(par = problem$initial.solution, fn = fn, method = "Nelder-Mead", ...)
#'   }
#'
#'   z = cocoBenchmarkOptimizer(cocoOptimizerNelderMead, suite)
#'   cocoCloseSuite(suite)
#' @export
cocoBenchmarkOptimizer = function(optimizer, suite, ...) {
  assertFunction(optimizer, c("fn", "problem"))
  assertClass(suite, "CocoSuite")
  res = list()
  while(!is.null(problem <- cocoSuiteGetNextProblem(suite))) {
    r = cocoRunOptimizer(optimizer, problem, ...)
    res[[problem$id]] = r
  }
  return(res)
}
