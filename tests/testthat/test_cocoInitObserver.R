context("cocoInitObserver")

test_that("cocoInitObserver", {
  expect_error(cocoInitObserver("unknown"))
  suite = cocoOpenSuite()
  observer = cocoInitObserver(suite, algorithm.name = "mbo")
  expect_class(observer, "CocoObserver")
  expect_output(print(observer), "CocoObserver")
  expect_equal(observer$observer.name, "bbob")
  expect_equal(observer$algorithm.name, "mbo")
  expect_string(observer$result.folder)
})
