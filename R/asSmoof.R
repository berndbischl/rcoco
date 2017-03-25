#' @title Converts coco problem to smoof function.
#' 
#' @description
#' See title
#'
#' @template arg_problem
#' @return [\code{smoof_function}].
#' @export
asSmoof = function(problem) {
  assertClass(problem, "CocoProblem")
  #FIXME: constraints not handled yet
  if (problem$nr.of.constraints != 0L)
    stop("Constraints not yet handled!")
  
  fn = function(x) {
    cocoEvaluateFunction(problem, x)
  }
  args = list(
    id = problem$id,
    name = problem$name,
    has.simple.signature = TRUE,
    vectorized = FALSE,
    fn = fn,
    par.set = makeNumericParamSet(len = problem$dimension, lower = problem$lower, upper = problem$upper)
  )
  if (problem$dimension == 1L) {
    constructor = smoof::makeSingleObjectiveFunction 
  } else { 
    constructor = smoof::makeMultiObjectiveFunction
    args$n.objectives = problem$nr.of.objectives 
  }
  do.call(constructor, args)
}



