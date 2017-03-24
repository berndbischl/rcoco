library(roxygen2)
library(devtools)
roxygenize()
load_all()


cocoSetLogLevel("info")
s = cocoOpenSuite()
print(s)
p = cocoSuiteGetNextProblem(s)
print(p)


g = function(fn, start, problem, ...) {
  optim(par = start, fn = fn, ...)
}
res = cocoRunOptimizer(g, p)
print(res)

cocoCloseSuite(s)

# n = cocoProblemGetEvaluations(p)
# print(n)
# y = cocoEvaluateFunction(p, c(0,0))
# print(y)
# n = cocoProblemGetEvaluations(p)
# print(n)


