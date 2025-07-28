#' @title COCO Problem R6 Class
#' @description
#' Represents a COCO optimization problem.
#' @export
CocoProblemNoisy = R6::R6Class("CocoProblemNoisy", inherit = CocoProblem,
  public = list(

    #' @description
    #' Initialize a new COCO Problem
    #' @param suite The COCO suite
    #' @param problem_idx The index of the problem in the suite
    initialize = function(fun_idx, dim) {
      self$problem_idx = fun_idx
      self$name = sprintf("bbobnoisy_f%03i_d%02i", fun_idx, dim)
      self$id = sprintf("bbobnoisy_f%03i_d%02i", fun_idx, dim)
      self$type = "single-objective:noisy"
      self$dim = dim
      self$n_obj = 1
      self$n_constr = 0
      self$n_int = 0
    },

    #' @description
    #' Evaluate the problem at a given point
    #' @param x The point to evaluate
    #' @return The function value at x
    eval = function(x) {
      .Call("c_coco_eval_noisy", self$problem_idx, x)
    }

  )
)
