#' @title Coco problem suite object.
#'
#' @description
#'
#' The S3 class is a list which stores these elements:
#' \describe{
#'   \item{suite.name [\code{character(1)}]}{Name of suite.}
#'   \item{suite.extptr}{External pointer to C object of coco suite.}
#'   \item{observer.name [\code{character(1)}]}{Name of observer.}
#'   \item{observer.extptr}{External pointer to C object of coco observer.}
#' }
#' @name CocoSuite
#' @rdname CocoSuite
NULL

#' @export
print.CocoSuite = function(x, ...) {
  catf("CocoSuite")
  catf("suite       : %s", x$suite.name)
  catf("observer    : %s", x$observer.name)
}


