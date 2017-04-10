#' @title Get the number of problems in the given suite.
#'
#' @description
#' See title
#'
#' @template arg_suite
#' @template ret_int
#' @export
#' @useDynLib rcoco c_cocoSuiteGetNumberOfProblems
cocoSuiteGetNumberOfProblems = function(suite) {
  assertClass(suite, "CocoSuite")
  .Call(c_cocoSuiteGetNumberOfProblems, suite)
}
