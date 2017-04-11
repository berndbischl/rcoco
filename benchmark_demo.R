library(devtools)
load_all()

# to install coco
# 1. clone coco repo
# 2. python do.py install-postprocessing
# 3. pip install --user matplotlib
# (i guess the dependcy stuff should be documented rather in the readme?)

unlink("exdata", recursive = TRUE)

suite = cocoOpenSuite("bbob")

opt1 = function(fn, problem, ...) {
  optim(par = problem$initial.solution, fn = fn, method = "Nelder-Mead", ...)
}
opt2 = function(fn, problem, ...) {
  optim(par = problem$initial.solution, fn = fn, method = "BFGS", ...)
}


observer = cocoInitObserver("bbob", result.folder = "neldermead")
res = cocoBenchmarkOptimizer(opt1, suite, observer)

observer = cocoInitObserver("bbob", result.folder = "bfgs")
res = cocoBenchmarkOptimizer(opt2, suite, observer)

cocoCloseSuite(suite)


# 4. now run
# python -m cocopp ~/cos/rcoco/exdata/




