context("cocoSuiteGetProblem")

test_that("cocoSuiteGetProblem", {
  s = cocoOpenSuite()
  o = cocoInitObserver(s)
  # iterate normal noiseless bbob, 6 dims (d = 2,5,10,20,40) x 24 funs x 15 function instances
  for (i in 1:(6 * 24 * 15)) {
    p1 = cocoSuiteGetNextProblem(s, o)
    p2 = cocoSuiteGetProblem(s, i-1)
    expect_output(print(p1), "CocoProblem", info = i)
    expect_equal(p1$index, i-1)
    # FIXME: it is weird that the problems return ONLY differen names? looks like a bug in coco?
    # i openend an issue about this
    p1$name = p2$name
    expect_equal(p1, p2)
  }
  # last call should return NULL
  p = cocoSuiteGetNextProblem(s, o)
  expect_null(p)
  cocoCloseSuite(s)
})

