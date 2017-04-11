# some simple wrapper functions so we can easily use them
#
cocoWrapperOptimNelderMead = function(fn, problem, ...) {
  #Sys.sleep(0.1)
  optim(par = problem$initial.solution, fn = fn, method = "Nelder-Mead", ...)
}
