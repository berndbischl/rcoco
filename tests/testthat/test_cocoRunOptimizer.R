context("cocoRunOptimizer")

test_that("cocoRunOptimizer", {
  # check that we can optimize fsphere in 2d, should be 1st problem
  # global opt y is ca 79.78
  s = cocoOpenSuite()
  o = cocoInitObserver()
  p = cocoSuiteGetNextProblem(s, o)
  r = cocoRunOptimizer(cocoWrapperOptimNelderMead, p, control = list(maxit = 100L))
  expect_flag(cocoProblemIsFinalTargetHit(p))
  expect_lt(r$value, 80)
  cocoCloseSuite(s)
})

