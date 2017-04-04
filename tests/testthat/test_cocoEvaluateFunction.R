context("cocoEvaluateFunction")

test_that("cocoEvaluateFunction", {
  s = cocoOpenSuite()
  p = cocoSuiteGetNextProblem(s)
  expect_equal(cocoProblemGetEvaluations(p), 0L)
  x = c(0, 0)
  y = cocoEvaluateFunction(p, x) 
  expect_is(y, "numeric")
  expect_length(y, 1L)
  expect_equal(cocoProblemGetEvaluations(p), 1L)
  cocoCloseSuite(s)
})

test_that("cocoEvaluateFunction", {
  s = cocoOpenSuite()
  ps = cocoSuiteGetAllProblems(s)
  cocoCloseSuite(s)
})


