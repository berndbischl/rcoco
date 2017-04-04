library(roxygen2)
library(devtools)
roxygenize()
load_all()


cocoSetLogLevel("info")
# s = cocoOpenSuite()
# print(s)
# p = cocoSuiteGetNextProblem(s)

# s = cocoOpenSuite() 
# s = cocoOpenSuite(dims = 2) 
# print(s)
# s = cocoOpenSuite(dims = c(2, 3, 5, 10, 20), dim.inds = 2, fun.inds = 1, inst.inds = 1) 
s = cocoOpenSuite(instances = 1:2, dims = 2, fun.inds = 1:2) 
ps = cocoSuiteGetAllProblems(s)
spl = summary(ps)
print(spl)
# print(ps)
# print(length(ps))
# s = cocoOpenSuite("bbob", instances = 10:20, dims = c(2, 3, 5, 10, 20), inst.inds = 1:5) 
# z = cocoBenchmarkOptimizer(cocoWrapperOptimNelderMead, s)
# cocoCloseSuite(s)
  
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
cocoCloseSuite(s)

