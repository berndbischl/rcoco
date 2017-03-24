#' @title Open a coco problem suite.
#' 
#' @description
#' Must be called before problems can be accessed.
#'
#' @param suite.name [\code{character(1)}]\cr
#'   Name of coco suite.
#'   Default is \dQuote{bbob}.
#' @param observer.name [\code{character(1)}]\cr
#'   Name of observer.
#'   Default is \dQuote{bbob}.
#' @param result.folder [\code{character(1)}]\cr
#'   Directory for the observer to write the output.
#'   Default is \code{R_on_<suite.name>}.
#'   If the directory already exists the observer will automatically append \code{-001} to the name.
#' @return [\code{\link{CocoSuite}}].
#' @export
#' @useDynLib rcoco c_cocoOpenSuite
cocoOpenSuite = function(suite.name = "bbob", observer.name = "bbob") {
  assertString(suite.name)
  assertString(observer.name)
  if (is.null(result.folder)) {
    result.folder = sprintf("R_on_%s", suite.name)
  }
  assertString(result.folder)
  s = .Call(c_cocoOpenSuite, suite.name, observer.name, result.folder)
  names(s) = c("suite.name", "suite.extptr", "observer.name", "observer.extptr")
  class(s) = "CocoSuite"
  return(s)
}


