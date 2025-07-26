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
    #' @field options Additional options for the suite
    options = NULL,
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
    #' @param options Additional options (optional)
    initialize = function(name, instance, options = NULL) {
      assert_string(name)
      assert_string(instance)
      assert_string(options, null.ok = TRUE)
      
      result = .Call("c_coco_suite", name, instance, options, self)
      self$name = name
      self$instance = instance
      self$options = options
    },

    #' @description
    #' Print method for the COCO Suite
    print = function() {
      catf("COCO Suite")
      catf("* Name: %s", self$name)
      catf("* Instance: %s", self$instance)
      catf("* Options: %s", if (is.null(self$options)) "NULL" else self$options) 
      catf("* Number of problems: %i", self$n_problems)
      print(head(self$data))
    }
  )
)


