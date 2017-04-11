#' @title Get best observed value of the first function objective.
#'
#' @description
#' See title
#'
#' @template arg_problem
#' @template ret_num
#' @export
#' @useDynLib rcoco c_cocoProblemGetBestObservedFValue
cocoProblemGetBestObservedFValue = function(problem) {
  assertClass(problem, "CocoProblem")
  .Call(c_cocoProblemGetBestObservedFValue, problem)
}
