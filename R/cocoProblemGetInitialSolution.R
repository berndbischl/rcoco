#' @title Get initial feasible solution for a coco problem.
#' 
#' @description
#' See title
#'
#' @template arg_problem
#' @return [\code{numeric}]. Objective value, of length \code{problem$nr.of.objectives}.
#' @export
#' @useDynLib rcoco c_cocoProblemGetInitialSolution
cocoProblemGetInitialSolution = function(problem) {
  assertClass(problem, "CocoProblem")
  .Call(c_cocoProblemGetInitialSolution, problem)
}


