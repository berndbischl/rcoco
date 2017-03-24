# some simple wrapper functions so we can easily use them
#
cocoWrapperOptimNelderMead = function(fn, start, problem, ...) {
  optim(par = start, fn = fn, method = "Nelder-Mead", ...)
}
