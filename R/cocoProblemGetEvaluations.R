#' @title Get number of fevals that were performed for a coco problem.
#' 
#' @description
#' See title
#'
#' @template arg_problem
#' @template ret_int
#' @export
#' @useDynLib rcoco c_cocoProblemGetEvaluations
cocoProblemGetEvaluations = function(problem) {
  assertClass(problem, "CocoProblem")
  .Call(c_cocoProblemGetEvaluations, problem)
}

