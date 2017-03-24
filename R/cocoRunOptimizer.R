cocoRunOptimizer = function(optfun, problem, ...) {
  assertFunction(optfun)
  assertClass(problem, "CocoProblem")
  fn = function(x) {
    cocoEvaluateFunction(problem, x)
  }
  start = cocoProblemGetInitialSolution(problem)
  optfun(fn, start, problem, ...)
}
