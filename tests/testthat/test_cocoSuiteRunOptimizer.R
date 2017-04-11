context("cocoSuiteRunOptimizer")

test_that("cocoSuiteRunOptimizer", {
  instances = 10:20
  fun.inds = 1:5
  dims = c(2, 3, 5)
  inst.inds = 1:5
  suite = cocoOpenSuite("bbob", instances = instances, fun.inds = 1:5, dims = dims, inst.inds = inst.inds)
  observer = cocoInitObserver("bbob")
  res = cocoSuiteRunOptimizer(suite, cocoWrapperOptimNelderMead, observer)
  expect_list(res, types = "list", any.missing = FALSE, all.missing = FALSE)
  expect_length(res, length(fun.inds) * length(dims) * length(inst.inds))
  cocoCloseSuite(suite)
})

