#' @title Run optimizer on specific coco problem.
#' 
#' @description
#' The function is mainly called for its side effect of coco logging of results on disk.
#'
#' @template arg_optimizer
#' @template arg_problem
#' @param \ldots [any]\cr
#'   Passed down to \code{optimizer}.
#' @return Result object that \code{optimizer} returns.
#' @export
cocoRunOptimizer = function(optimizer, problem, ...) {
  assertFunction(optimizer, c("fn", "start", "problem"))
  assertClass(problem, "CocoProblem")
  fn = function(x) {
    cocoEvaluateFunction(problem, x)
  }
  start = cocoProblemGetInitialSolution(problem)
  optimizer(fn, start, problem, ...)
}
