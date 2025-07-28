#' @title COCO Suite R6 Class
#' @description
#' R6 class for creating and managing COCO optimization suites.
#' @export
CocoSuiteNoisy = R6::R6Class("CocoSuiteNoisy", inherit = CocoSuite,
  public = list(

    #' @description
    #' Initialize a new COCO Suite
    initialize = function() {
      self$name = "bbobnoisy"
      self$instance = "year: 2009"
      self$observer_name = NULL
      self$observer_options = ""
      self$n_problems = 30
      self$data = data.frame(
        problem_idx = 1:30,
        dim = rep(2, 30),
        fun_idx = 1:30,
        fun_name = sprintf("bbobnoisy_f%03i_d%02i", 1:30, 2)
      )
      .Call("c_coco_suite_noisy", self)
    }
  )
)


