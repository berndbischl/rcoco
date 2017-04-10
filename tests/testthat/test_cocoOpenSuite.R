context("cocoOpenSuite")

test_that("cocoOpenSuite", {
  checkCall = function(..., nprobs) {
    s = cocoOpenSuite(...)
    expect_equal(s$nr.of.problems, 6 * 24 * 15)
    expect_equal(cocoSuiteGetNumberOfProblems(s), 6 * 24 * 15)
    ps = cocoSuiteGetAllProblems(s)
    expect_list(ps, types = "CocoProblem", len = nprobs)
    cocoCloseSuite(s)
  }
  checkCall(nprobs = 6 * 24 * 15)
  checkCall(dims = 2, nprobs = 24 * 15)
  checkCall(dims = c(2,3,5,10), inst.inds = 1:2, fun.inds = c(1,2,3), nprobs = 4 * 2 * 3)
  # FIXME: the coco docs say that this should return 3? as dim and dim.inds are there and only 1st should be considered?
  checkCall(dims = c(2,3,5), dim.inds = 1, fun.inds = 1, inst.inds = 1, nprobs = 1)
})


