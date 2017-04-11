#' @title Free the given coco problem
#'
#' @description
#' See title
#'
#' @template arg_problem
#' @template ret_invnull
#' @useDynLib rcoco c_cocoProblemFree
cocoProblemFree = function(problem) {
  assertClass(problem, "CocoProblem")
  .Call(c_cocoProblemFree, problem)
  return(invisible(NULL))
}
