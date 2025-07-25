#' @title Create a COCO Suite
#' @export
coco_fun = function(suite, fun_idx, dim_idx, inst_idx) {
  assert_class(suite, "coco_suite")
  # Use actual bounds from the suite
  assert_int(fun_idx, lower = 1, upper = max(suite$functions))
  assert_int(dim_idx, lower = 1, upper = max(suite$dimensions))
  assert_int(inst_idx, lower = 1, upper = max(suite$instances))
  
  result = .Call("c_coco_fun", suite, fun_idx, dim_idx, inst_idx)
  result$fun_idx = fun_idx
  result$dim_idx = dim_idx
  result$inst_idx = inst_idx
  result$eval = function(x) {
    .Call("c_coco_eval", result$problem_ptr, x)
  }
  return(result)
}


#' @export
print.coco_fun = function(x, ...) {
  catf("COCO Function")
  catf("* Function: %i", x$fun_idx)
  catf("* Dimension: %i", x$dim_idx)
  catf("* Instance: %i", x$inst_idx)
}
