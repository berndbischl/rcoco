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
    #' @field n_problems Number of problems in the suite
    n_problems = NULL,
    #' @field data Data frame with problem information
    data = NULL,

    #' @description
    #' Initialize a new COCO Suite
    #' @param name The name of the suite
    #' @param instance The instance identifier
    initialize = function(name, instance) {
      assert_choice(name, coco_suites)
      assert_string(instance)
      
      .Call("c_coco_suite", name, instance, self)
      self$name = name
      self$instance = instance
    },

    #' @description
    #' Print method for the COCO Suite
    print = function() {
      catf("COCO Suite")
      catf("* Name: %s", self$name)
      catf("* Instance: %s", self$instance)
      catf("* Number of problems: %i", self$n_problems)
      print(head(self$data))
    }
  )
)


