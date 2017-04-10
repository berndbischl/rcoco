#' @title Close a coco problem suite.
#'
#' @description
#' Must be called after all evaluations on problem are finished.
#'
#' @template arg_suite
#' @template ret_invnull
#' @export
#' @useDynLib rcoco c_cocoCloseSuite
cocoCloseSuite = function(suite) {
  assertClass(suite, "CocoSuite")
  .Call(c_cocoCloseSuite, suite)
  return(invisible(NULL))
}
