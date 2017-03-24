context("cocoSuiteGetNextProblem")

test_that("cocoSuiteGetNextProblem", {
  s = cocoOpenSuite()
  # iterate normal noiseless bbob, 6 dims (d = 2,5,10,20,40) x 24 funs x 15 function instances
  for (i in 1:(6 * 24 * 15)) {
    p = cocoSuiteGetNextProblem(s)
    expect_output(print(p), "CocoProblem", info = i)
    expect_equal(p$index, i-1)
  }
  # last call should return NULL
  p = cocoSuiteGetNextProblem(s)
  expect_null(p)
  cocoCloseSuite(s)
})
