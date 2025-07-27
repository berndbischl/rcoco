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
    initialize = function(name, instance, observer_name = NULL, observer_options = "") {
      assert_choice(name, coco_suites)
      assert_string(instance)
      assert_choice(observer_name, coco_observers, null.ok = TRUE)
      assert_string(observer_options, null.ok = TRUE)

      .Call("c_coco_suite", name, instance, observer_name, observer_options, self)
      self$name = name
      self$instance = instance
      self$observer_name = observer_name
      self$observer_options = observer_options
    },

    #' @description
    #' Print method for the COCO Suite
    print = function() {
      catf("COCO Suite")
      catf("* Name: %s", self$name)
      catf("* Instance: %s", self$instance)
      catf("* Number of problems: %i", self$n_problems)
      catf("* Observer name: %s", self$observer_name)
      catf("* Observer options: %s", self$observer_options)
      print(head(self$data))
    }
  )
)


