test_basic_suite = function(name, instance) {
  s = CocoSuite$new(name, instance)
  testthat::expect_true(R6::is.R6(s))
  testthat::expect_true(inherits(s, "CocoSuite"))
  testthat::expect_equal(s$name, name)
  testthat::expect_equal(s$instance, instance)
  testthat::expect_true(!is.null(s$suite_ptr))
  expect_integer(s$n_problems)
  expect_data_frame(s$data, nrows = s$n_problems)
}

test_that("Basic tests for all coco suites", {
  for (name in coco_suites) {
    test_basic_suite(name, "year: 2009")
  }
})

test_that("CocoSuite print method works correctly", {
  suite = CocoSuite$new("bbob", "year: 2009")
  output = capture.output(result <- print(suite))
  expect_identical(result, suite)
  expect_true(any(grepl("COCO Suite", output)))
  expect_true(any(grepl("Name: bbob", output)))
  expect_true(any(grepl("Instance: year: 2009", output)))
})

test_that("CocoSuite handles garbage collection properly", {
  create_and_destroy = function() {
    suite = CocoSuite$new("bbob", "year,: 2009")
    # Return nothing to allow garbage collection
    return(NULL)
  }
  create_and_destroy2 = function() {
    suite = CocoSuite$new(
      "bbob",
      "year: 2009",
      observer_name = "bbob",
      observer_options = ""
    )
    return(NULL)
  }

  # This should not cause any errors
  expect_no_error({
    for (i in 1:5) {
      create_and_destroy()
      gc()
      create_and_destroy2()
      gc()
    }
  })
})
