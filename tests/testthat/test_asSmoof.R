context("asSmoof")

test_that("asSmoof", {
  s = cocoOpenSuite()
  p = cocoSuiteGetProblem(s, 0L)
  f = asSmoof(p)
  expect_is(f, "smoof_function")
  expect_equal(getNumberOfObjectives(f), p$nr.of.objectives)
  expect_equal(getID(f), p$id)
  expect_equal(getName(f), p$name)
  expect_equal(getNumberOfParameters(f), p$dimension)
  expect_equal(getLowerBoxConstraints(f), p$lower, check.names = FALSE)
  expect_equal(getUpperBoxConstraints(f), p$upper, check.names = FALSE)

  x = c(0, 0)
  y1 = cocoEvaluateFunction(p, x) 
  y2 = f(x)
  expect_equal(y1, y2)
  cocoCloseSuite(s)
})


