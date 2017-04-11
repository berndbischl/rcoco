#' @title Run optimizer on complete coco suite.
#'
#' @description
#' The function is mainly called for its side effect of coco logging of results on disk.
#' It is expected that the caller opens the suite with \code{\link{cocoOpenSuite}} and closes the
#' suite with \code{\link{cocoCloseSuite}}.
#'
#' @template arg_optimizer
#' @template arg_suite
#' @template arg_observer
#' @param \ldots [any]\cr
#'   Passed down to \code{optimizer}.
#' @return [\code{list}]. List of results for individual \code{\link{cocoRunOptimizer}} calls.
#'   List is named with coco problem ids.
#' @examples
#' # init test suite
#' suite = cocoOpenSuite("bbob", instances = 10:13, dims = c(2, 3), inst.inds = 1:3)
#'
#' # set up observer
#' observer = cocoInitObserver("bbob", result.folder = "R_NelderMead")
#'
#' # simple wrapper for Nelder-Mead
#' cocoOptimizerNelderMead = function(fn, problem, ...) {
#'   optim(par = problem$initial.solution, fn = fn, method = "Nelder-Mead", ...)
#' }
#'
#' res = cocoBenchmarkOptimizer(cocoOptimizerNelderMead, suite, observer)
#' cocoCloseSuite(suite)
#' @export
cocoBenchmarkOptimizer = function(optimizer, suite, observer, ...) {
  assertFunction(optimizer, c("fn", "problem"))
  assertClass(suite, "CocoSuite")
  assertClass(observer, "CocoObserver")

  problems = cocoSuiteGetAllProblems(suite)
  problem.ids = names(problems)

  res = parallelMap(function(id) {
    p = problems[[id]]
    # wrap function with observer
    p = cocoProblemAddObserver(p, observer)
    opt.res = cocoRunOptimizer(optimizer, p, ...)
    # the next line is of utmost importance! Otherwise we get:
    # COCO FATAL ERROR: The current bbob_logger (observer) must be closed before a new one is opened
    cocoProblemFree(p) # free memory of problem (and observer)
    return(opt.res)
  }, problem.ids)
  names(res) = problem.ids
  return(res)
}
