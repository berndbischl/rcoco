test_problem = function(suite, problem_idx) {
  p = CocoProblem$new(suite, problem_idx)
  expect_true(R6::is.R6(p))
  expect_true(inherits(p, "CocoProblem"))
  expect_string(p$name)
  expect_string(p$id)
  expect_string(p$type)
  expect_integer(p$dim)
  expect_integer(p$n_obj)
  expect_integer(p$n_constr)
  expect_integer(p$n_int)
}

test_problems_first = function(suite) {
  for (problem_idx in 1:10) {
    test_problem(suite, problem_idx)
  }
}

test_that("Basic tests for all coco problems", {
  suite = CocoSuite$new("bbob", "year: 2009")
  test_problems_first(suite)
})

test_that("CocoProblem print method works correctly", {
  suite = CocoSuite$new("bbob", "year: 2009")
  p = CocoProblem$new(suite, 1)
  output = capture.output(result <- print(p))
  expect_identical(result, p)
  expect_true(any(grepl("COCO Function", output)))
  expect_true(any(grepl("Name: BBOB suite problem f1 instance 2 in 2D", output)))
  expect_true(any(grepl("ID: bbob_f001_i02_d02", output)))
  expect_true(any(grepl("Type: 1-separable", output)))
  expect_true(any(grepl("Dimension: 2", output)))
  expect_true(any(grepl("Objectives: 1", output)))
  expect_true(any(grepl("Constraints: 0", output)))
  expect_true(any(grepl("Integer vars: 0", output)))
})

test_that("CocoProblem handles garbage collection properly", {
  create_and_destroy = function() {
    suite = CocoSuite$new("bbob", "year: 2009")
    p = CocoProblem$new(suite, 1)
    return(NULL)
  }
  
  # This should not cause any errors
  expect_no_error({
    for (i in 1:5) {
      create_and_destroy()
      gc()
    }
  })
})
