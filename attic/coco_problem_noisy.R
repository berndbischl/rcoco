#' @title COCO Problem R6 Class
#' @description
#' Represents a COCO optimization problem.
#' @export
CocoProblemNoisy = R6::R6Class("CocoProblemNoisy", inherit = CocoProblem,
  public = list(

    #' @description
    #' Initialize a new COCO Problem
    #' @param suite The COCO suite
    #' @param fun_idx The index of the problem in the suite
    #' @param dim The dimension of the problem
    initialize = function(suite, problem_idx) {
      assert_class(suite, "CocoSuite")
      if (suite$name != "bbob-noisy") {
        stop("Can only initialize noisy problems with bbob-noisy suite")
      }
      assert_int(problem_idx, lower = 0, upper = suite$n_problems - 1)
      self$problem_idx = problem_idx
      row = suite$data[problem_idx + 1, ]
      id = sprintf("bbobnoisy_%s_d%02i", row$fun_id, row$dim)
      self$id = id
      self$name = id
      self$type = "single-objective:noisy"
      self$dim = row$dim
      self$fun_idx = row$fun_idx
      self$n_obj = 1
      self$n_constr = 0
      self$n_int = 0
    },

    #' @description
    #' Evaluate the problem at a given point
    #' @param x The point to evaluate
    #' @return The function value at x
    eval = function(x) {
      .Call("c_coco_eval_noisy", self$fun_idx, self$dim, x)
    }
  )
)
