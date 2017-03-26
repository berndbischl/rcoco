context("cocoSuiteGetAllProblems")

test_that("cocoSuiteGetAllProblems", {
  s = cocoOpenSuite()
  # normal noiseless bbob, 6 dims (d = 2,5,10,20,40) x 24 funs x 15 function instances
  ps = cocoSuiteGetAllProblems(s)
  expect_list(ps, len = 6 * 24 * 15, types = "CocoProblem")
  xs = extractSubList(ps, "fun.nr")
  expect_set_equal(unique(xs), 1:24)
  xs = extractSubList(ps, "inst.nr")
  expect_set_equal(unique(xs), c(1:5, 61:70)) # instance nr are a bit weird in bbob, not 1-15
  cocoCloseSuite(s)
})


