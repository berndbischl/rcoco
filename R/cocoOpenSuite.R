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
#' @return [\code{\link{CocoSuite}}].
#' @export
#' @useDynLib cocor c_cocoOpenSuite
cocoOpenSuite = function(suite.name = "bbob", observer.name = "bbob") {
  assertString(suite.name)
  assertString(observer.name)
  s = .Call(c_cocoOpenSuite, suite.name, observer.name)
  names(s) = c("suite.name", "suite.extptr", "observer.name", "observer.extptr")
  class(s) = "CocoSuite"
  return(s)
}


