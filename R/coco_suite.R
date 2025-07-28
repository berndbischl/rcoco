#' @title COCO Suite R6 Class
#' @description
#' R6 class for creating and managing COCO optimization suites.
#' @export
CocoSuite = R6::R6Class("CocoSuite",
  public = list(
    #' @field name The name of the suite
    name = NULL,
    #' @field instance The instance identifier
    instance = NULL,
    #' @field suite_ptr Internal pointer to the C suite object
    suite_ptr = NULL,
    #' @field observer_ptr Internal pointer to the C observer object
    observer_ptr = NULL,
    #' @field n_problems Number of problems in the suite
    n_problems = NULL,
    #' @field data Data frame with problem information
    data = NULL,
    #' @field observer_name The name of the COCO observer
    observer_name = NULL,
    #' @field observer_options Options for the COCO observer
    observer_options = NULL,

    #' @description
    #' Initialize a new COCO Suite
    #' @param name The name of the suite
    #' @param instance The instance identifier
    #' @param observer_name The name of the COCO observer
    #' @param observer_options Options for the COCO observer
    initialize = function(name, instance = "year: 2009", observer_name = NULL, observer_options = "") {
      assert_choice(name, coco_suites)
      assert_string(instance, pattern = "^year: \\d{4}$")
      assert_choice(observer_name, coco_observers, null.ok = TRUE)
      assert_string(observer_options, null.ok = TRUE)

      self$name = name
      self$instance = instance
      self$observer_name = observer_name
      self$observer_options = observer_options

      if (name == "bbob-noisy") {
        if (instance != "year: 2009") {
          stop("Noisy benchmarks must be initialized with instance 'year: 2009'")
        }
        if (!is.null(observer_name) || observer_options != "") {
          stop("Noisy benchmarks do not support observers")
        }
        fun_desc = c(
          "Sphere with moderate Gaussian noise",
          "Sphere with moderate uniform noise",
          "Sphere with moderate seldom Cauchy noise",
          "Rosenbrock with moderate Gaussian noise",
          "Rosenbrock with moderate uniform noise",
          "Rosenbrock with moderate uniform noise",
          "Sphere with Gaussian noise",
          "Sphere with uniform noise",
          "Sphere with seldom Cauchy noise",
          "Rosenbrock with Gaussian noise",
          "Rosenbrock with uniform noise",
          "Rosenbrock with seldom Cauchy noise",
          "Step ellipsoid with Gaussian noise",
          "Step ellipsoid with uniform noise",
          "Step ellipsoid with seldom Cauchy noise",
          "Ellipsoid with Gaussian noise",
          "Ellipsoid with uniform noise",
          "Ellipsoid with seldom Cauchy noise",
          "Different Powers with Gaussian noise",
          "Different Powers with uniform noise",
          "Different Powers with seldom Cauchy noise",
          "Schaffer's F7 with Gaussian noise",
          "Schaffer's F7 with uniform noise",
          "Schaffer's F7 with seldom Cauchy noise",
          "Composite Griewank-Rosenbrock with Gaussian noise",
          "Composite Griewank-Rosenbrock with uniform noise",
          "Composite Griewank-Rosenbrock with seldom Cauchy noise",
          "Gallagher's Gaussian Peaks 101-me with Gaussian noise",
          "Gallagher's Gaussian Peaks 101-me with uniform noise",
          "Gallagher's Gaussian Peaks 101-me with seldom Cauchy noise"
        )
        fun_ids = sprintf("f1%02i", 1:30)
        fun_idx = 0:29
        fun_dims = c(2, 3, 5, 10, 20, 40)
        fun_ids = rep(fun_ids, length(fun_dims))
        fun_idx = rep(fun_idx, length(fun_dims))
        fun_desc = rep(fun_desc, length(fun_dims))
        fun_dims = rep(fun_dims, each = 30)
        data = data.frame(problem_idx = 0:(length(fun_ids) - 1), fun_idx = fun_idx, fun_id = fun_ids, fun_desc = fun_desc, dim = fun_dims)
        print(head(data))
        self$n_problems = nrow(data)
        self$data = data
      } else {
        .Call("c_coco_suite", name, instance, observer_name, observer_options, self)
      }
    },

    #' @description
    #' Print method for the COCO Suite
    print = function() {
      catf("COCO Suite")
      catf("* Name: %s", self$name)
      catf("* Instance: %s", self$instance)
      catf("* Number of problems: %i", self$n_problems)
      catf("* Observer name: %s", ifelse(is.null(self$observer_name), "none", self$observer_name))
      catf("* Observer options: %s", self$observer_options)
      print(head(self$data))
    }
  )
)


