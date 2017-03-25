context("cocoSuiteGetProblemByFunDimInst")

test_that("cocoSuiteGetProblemByFunDimInst", {
  s = cocoOpenSuite()
  p1 = cocoSuiteGetProblem(s, 0)
  p2 = cocoSuiteGetProblemByFunDimInst(s, f = 1, d = 2, i = 1)
  expect_equal(p1, p2)
  cocoCloseSuite(s)
})


