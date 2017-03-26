context("cocoSuiteGetAllProblems")

test_that("cocoSuiteGetAllProblems", {
  s = cocoOpenSuite()
  # normal noiseless bbob, 6 dims (d = 2,5,10,20,40) x 24 funs x 15 function instances
  ps = cocoSuiteGetAllProblems(s)
  expect_list(ps, len = 6 * 24 * 15, types = "CocoProblem")
  cocoCloseSuite(s)
})


