#' @title COCO Problem R6 Class
#' @description
#' Represents a COCO optimization problem.
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
    #' @field fun_idx Function index
    fun_idx = NULL,
    #' @field n_obj Number of objectives
    n_obj = NULL,
    #' @field n_constr Number of constraints
    n_constr = NULL,
    #' @field n_int Number of integer variables
    n_int = NULL,
    #' @field lower Lower bounds of decision space
    lower = NULL,
    #' @field upper Upper bounds of decision space
    upper = NULL,
    #' @field target Target value for the first objective
    target = NULL,
    #' @field fupper Upper bounds of objective space, only for multi-objective problems
    fupper = NULL,

    #' @description
    #' Initialize a new COCO Problem
    #' @param suite The COCO suite
    #' @param problem_idx The index of the problem in the suite
    initialize = function(suite, problem_idx) {
      assert_class(suite, "CocoSuite")
      # if (suite$name == "bbob-noisy") {
      #   stop("Cannot initialize noisy problems with this suite")
      # }
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
      catf("* Target: %g", self$target)
    }
  )
)
