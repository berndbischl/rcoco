context("cocoSuiteGetNextProblem")

test_that("cocoSuiteGetNextProblem", {
  s = cocoOpenSuite()
  for (i in 1:10) {
    p = cocoSuiteGetNextProblem(s)
    expect_output(print(p), "CocoProblem")
  }
  cocoCloseSuite(s)
})
