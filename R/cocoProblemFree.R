#' @title Free the given coco problem.
#'
#' @description
#' This function is needed if one manually iterates over the problems of a
#' \code{\link{CocoSuite}} and wraps these with a \code{CocoObserver} since the
#' current observer needs to be closed before a new one is stared. This function
#' is used internally by \code{\link{cocoSuiteRunOptimizer}} and will rarely be
#' needed.
#'
#' @template arg_problem
#' @template ret_invnull
#' @useDynLib rcoco c_cocoProblemFree
cocoProblemFree = function(problem) {
  assertClass(problem, "CocoProblem")
  .Call(c_cocoProblemFree, problem)
  return(invisible(NULL))
}
