library(roxygen2)
library(devtools)
library(parallelMap)
roxygenize()
load_all()

unlink("exdata", recursive = TRUE)

cocoSetLogLevel("warning")

s = cocoOpenSuite("bbob", instances = 10:20, dims = c(2, 3, 5, 10, 20), inst.inds = 1:5)
print(s)

obs = cocoInitObserver("bbob", result.folder = "RCOCO_result")
print(obs)

problems = cocoSuiteGetAllProblems(s)
nprobs = cocoSuiteGetNumberOfProblems(s)
catf("problems in suite: %i", nprobs)

res = cocoSuiteRunOptimizer(s, cocoWrapperOptimNelderMead, obs)
print(head(names(res)))
stop(123)


# res = list()
# for (ind in problem.inds) {
#   p = cocoSuiteGetProblem(s, ind)
#   res[[p$id]] = cocoRunOptimizer(cocoWrapperOptimNelderMead, p)
# }

cocoCloseSuite(s)
stop(999)


stop(999)
# p = cocoSuiteGetNextProblem(s, obs)
# print(p)

# res = cocoRunOptimizer(cocoWrapperOptimNelderMead, p)
# p = cocoSuiteGetNextProblem(s, obs)
# print(p)
res = list()
while(!is.null(problem <- cocoSuiteGetNextProblem(s, obs))) {
  res[[problem$id]] = cocoRunOptimizer(cocoWrapperOptimNelderMead, problem)
}
cocoCloseSuite(s)

stop(8473974)
#print(cocoSuiteGetNumberOfProblems(s))
z = cocoSuiteRunOptimizer(cocoWrapperOptimNelderMead, s, obs)
print(z)

# s = cocoOpenSuite()
# ps = cocoSuiteGetAllProblems(s)


# ps = list()

# idx = c(0)
# for (i in idx) {
  # p = cocoSuiteGetNextProblem(s)
  # print(p)
#   # p = cocoSuiteGetProblem(s, i)
  # ps[[length(ps) + 1]] = p
# }

# for (i in seq_along(ps)) {
#   p =  ps[[i]]
#   print(p)
#   y = cocoEvaluateFunction(p, p$initial.solution)
#   print(y)
# }

# for (i in seq_along(ps)) {
#   print(i)
#   p = ps[[i]]
#   print(p)
#   y = cocoEvaluateFunction(p, p$initial.solution)
#   print(y)
# }
#cocoCloseSuite(s)

