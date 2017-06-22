library(devtools)
load_all()

# to install coco
# 1. clone coco repo
# 2. python do.py install-postprocessing
# 3. pip install --user matplotlib
# (i guess the dependcy stuff should be documented rather in the readme?)

runPostProcessing = function(suite) {
  result.folder = file.path(getwd(), suite$result.folder)
  system2(paste0("python -m cocopp ", result.folder))
}

#unlink("exdata", recursive = TRUE)

suite = cocoOpenSuite("bbob", instances = 10:12, dims = c(2, 3), inst.inds = 1:3)

opt1 = function(fn, problem, ...) {
  optim(par = problem$initial.solution, fn = fn, method = "Nelder-Mead", ...)
}
opt2 = function(fn, problem, ...) {
  optim(par = problem$initial.solution, fn = fn, method = "BFGS", ...)
}

observer = cocoInitObserver(suite, algorithm.name = "NelderMead")
res = cocoSuiteRunOptimizer(suite, opt1, observer)

observer = cocoInitObserver(suite, algorithm.name = "bfgs")
res = cocoSuiteRunOptimizer(suite, opt2, observer)

cocoCloseSuite(suite)

#runPostProcessing(suite)

# 4. now run
# python -m cocopp ~/cos/rcoco/exdata/




