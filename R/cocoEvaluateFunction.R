#' @title Evaluate a coco function at point x.
#' 
#' @description
#' See title
#'
#' @template arg_problem
#' @param x [\code{numeric}]\cr
#'   Point to evaluate at, of length \code{problem$nr.of.dimensions}.
#' @return [\code{numeric}]. Objective value, of length \code{problem$nr.of.objectives}.
#' @export
#' @useDynLib cocor c_cocoProblemGetEvaluations
#' @export
#' @useDynLib cocor c_cocoEvaluateFunction
cocoEvaluateFunction = function(problem, x) {
  assertClass(problem, "CocoProblem")
  assertNumeric(x, len = problem$dimension, any.missing = FALSE)
  .Call(c_cocoEvaluateFunction, problem, x)
}

