#' @title Get specific coco problem.
#' 
#' @description
#' NB: If the problem index is too large, coco might just issue a warning and return a different
#' problem.
#'
#'
#' @template arg_suite
#' @param f [\code{integer(1)}]\cr
#'   Function number. Starts at 1.
#' @param d [\code{integer(1)}]\cr
#'   Dimension.
#' @param i [\code{integer(1)}]\cr
#'   Instance number. Starts at 1.
#' @template ret_problem
#' @export
#' @useDynLib rcoco c_cocoSuiteGetProblemByFunDimInst
cocoSuiteGetProblemByFunDimInst = function(suite, f, d, i) {
  assertClass(suite, "CocoSuite")
  f = asCount(f, positive = TRUE)
  d = asCount(d, positive = TRUE)
  i = asCount(i, positive = TRUE)
  p = .Call(c_cocoSuiteGetProblemByFunDimInst, suite, f, d, i)
  if (is.null(p))
    stopf("No problem found for: f=%i; d=%i, i=%i", f, d, i)
  makeCocoProblem(p) 
}



