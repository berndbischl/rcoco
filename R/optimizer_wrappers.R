# some simple wrapper functions so we can easily use them
#
cocoWrapperOptimNelderMead = function(fn, problem, ...) {
  optim(par = problem$initial.solution, fn = fn, method = "Nelder-Mead", ...)
}
