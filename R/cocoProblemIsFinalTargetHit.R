#' @title Check if target is already hit.
#'
#' @description
#' See title
#'
#' @template arg_problem
#' @return [\code{logical(1)}]
#' @export
#' @useDynLib rcoco c_cocoProblemIsFinalTargetHit
cocoProblemIsFinalTargetHit = function(problem) {
  assertClass(problem, "CocoProblem")
  .Call(c_cocoProblemIsFinalTargetHit, problem)
}
