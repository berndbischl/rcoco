#' @title Run optimizer on complete coco suite.
#'
#' @description
#' The function is mainly called for its side effect of coco logging of results on disk.
#' It is expected that the caller opens the suite with \code{\link{cocoOpenSuite}} and closes the
#' suite with \code{\link{cocoCloseSuite}}.
#' This function can be parallelized via various back-ends, e.g., multicore, via \pkg{parallelMap}.
#' For details on the usage see the [parallelMap github page](https://github.com/berndbischl/parallelMap#readme),
#' which offers a nice tutorial and describes all possible back-ends thoroughly.
#'
#' @template arg_suite
#' @template arg_optimizer
#' @template arg_observer
#' @param show.info [\code{logical(1)}]\cr
#'   Print short log message for each problem?
#'   Default is \code{TRUE}.
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
#' res = cocoSuiteRunOptimizer(suite, cocoOptimizerNelderMead, observer)
#' cocoCloseSuite(suite)
#' @export
cocoSuiteRunOptimizer = function(suite, optimizer, observer, show.info = TRUE, ...) {
  assertFunction(optimizer, c("fn", "problem"))
  assertClass(suite, "CocoSuite")
  assertClass(observer, "CocoObserver")
  assertFlag(show.info)

  problems = cocoSuiteGetAllProblems(suite)
  problem.ids = names(problems)

  res = parallelMap(function(id) {
    p = problems[[id]]
    if (show.info)
      catf("Optimizing function: %s", p$id)
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
