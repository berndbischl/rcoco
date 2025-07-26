#' @title COCO Problem R6 Class
#' @description
#' R6 class for creating and managing COCO optimization problems.
#' @export
CocoProblem = R6::R6Class("CocoProblem",
  public = list(
    #' @field problem_ptr Internal pointer to the C problem object
    problem_ptr = NULL,
    #' @field problem_idx The index of the problem in the suite
    problem_idx = NULL,
    #' @field name Problem name
    name = NULL,
    #' @field id Problem ID
    id = NULL,
    #' @field type Problem type
    type = NULL,
    #' @field dim Problem dimension
    dim = NULL,
    #' @field n_obj Number of objectives
    n_obj = NULL,
    #' @field n_constr Number of constraints
    n_constr = NULL,
    #' @field n_int Number of integer variables
    n_int = NULL,

    #' @description
    #' Initialize a new COCO Problem
    #' @param suite The COCO suite
    #' @param problem_idx The index of the problem in the suite
    initialize = function(suite, problem_idx) {
      assert_class(suite, "CocoSuite")
      assert_int(problem_idx, lower = 0, upper = suite$n_problems - 1)
      self$problem_idx = problem_idx
      .Call("c_coco_problem", suite, problem_idx, self)
    },

    #' @description
    #' Evaluate the problem at a given point
    #' @param x The point to evaluate
    #' @return The function value at x
    eval = function(x) {
      .Call("c_coco_eval", self, x)
    },

    #' @description
    #' Print method for the COCO Problem
    print = function() {
      catf("COCO Function")
      catf("* Name: %s", self$name)
      catf("* ID: %s", self$id)
      catf("* Type: %s", self$type)
      catf("* Dimension: %i", self$dim)
      catf("* Objectives: %i", self$n_obj)
      catf("* Constraints: %i", self$n_constr)
      catf("* Integer vars: %i", self$n_int)
    }
  )
)
