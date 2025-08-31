#' @title COCO Problem R6 Class
#'
#' @description
#' Represents a COCO optimization problem.
#' This is simply a mathematical test function you can evaluate at a given points.
#'
#' @export
CocoProblem = R6Class(
  "CocoProblem",
  public = list(
    #' @field problem_ptr `(externalptr)`\cr
    #'   Pointer to the C problem object
    problem_ptr = NULL,

    #' @field problem_idx (`integer(1)`)\cr
    #'   The index of the problem in the suite
    problem_idx = NULL,

    #' @field name (`character(1)`)\cr
    #'   Problem name
    name = NULL,

    #' @field id (`integer(1)`)\cr
    #'   Problem ID
    id = NULL,

    #' @field type (`integer(1)`)\cr
    #'   Problem type
    type = NULL,

    #' @field dim (`integer(1)`)\cr
    #'   Problem dimension
    dim = NULL,

    #' @field fun_idx (`integer(1)`)\cr
    #'   Function index
    fun_idx = NULL,

    #' @field n_obj (`integer(1)`)\cr
    #'   Number of objectives
    n_obj = NULL,

    #' @field n_constr (`integer(1)`)\cr
    #'   Number of constraints
    n_constr = NULL,

    #' @field n_int (`integer(1)`)\cr
    #'   Number of integer variables
    n_int = NULL,

    #' @field lower (`numeric(dim)`)\cr
    #'   Lower bounds of decision space
    lower = NULL,

    #' @field upper (`numeric(dim)`)\cr
    #'   Upper bounds of decision space
    upper = NULL,

    #' @field target (`numeric(1)`)\cr
    #'   Target value for the first objective
    target = NULL,

    #' @field fupper (`numeric(1)`)\cr
    #'   Upper bounds of objective space, only for multi-objective problems
    fupper = NULL,

    #' @description
    #' Initialize a new COCO Problem
    #' @param suite ([CocoSuite])\cr
    #'   The COCO suite
    #' @param problem_idx (`integer(1)`)\cr
    #'   The index of the problem in the suite
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
    #' Evaluate the problem function at a given point
    #' @param x (`numeric(dim)`)\cr
    #'   The point to evaluate
    #' @return (`numeric(n_obj)`)\cr
    #'   The function value(s) at x
    eval = function(x) {
      .Call("c_coco_eval", self, x)
    },

    #' @description
    #' Printer.
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
