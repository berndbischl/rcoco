#' @title Create a COCO Suite
#' @export
coco_suite = function(name, instance, options = NULL) {
  assert_string(name)
  assert_string(instance)
  assert_string(options, null.ok = TRUE)
  
  result = .Call("c_coco_suite", name, instance, options)
  result$name = name
  result$instance = instance
  result$options = options
  return(result)
}


#' @export
print.coco_suite = function(x, ...) {
  catf("COCO Suite")
  catf("* Name: %s", x$name)
  catf("* Instance: %s", x$instance)
  catf("* Options: %s", if (is.null(x$options)) "NULL" else x$options) 
  catf("* Problems: %i", x$n_problems)
  catf("* Functions: %s", paste(x$functions, collapse = ", "))
  catf("* Dimensions: %s", paste(x$dimensions, collapse = ", "))
  catf("* Instances: %s", paste(x$instances, collapse = ", "))
}
